# 🔍 Smart Content Search - Архитектура

## 🎯 Концепция

Превращаем создание воспоминаний в **выбор богатых карточек** вместо ручного ввода!

### Как это работает:

```
1. Пользователь: "Интерстеллар"
   ↓
2. Backend → TMDB API
   ↓
3. Результаты: [
      {
        title: "Интерстеллар",
        poster: "https://image.tmdb.org/...",
        year: 2014,
        director: "Кристофер Нолан",
        rating: 8.6,
        description: "..."
      },
      ...
   ]
   ↓
4. UI показывает карточки
   ↓
5. Пользователь выбирает → все поля заполнены!
```

---

## 🔌 External APIs Integration

### 1. TMDB (Movies & TV)

**Setup:**
```bash
# Регистрация: https://www.themoviedb.org/settings/api
# Бесплатный API key
```

**Endpoints:**
```python
# Поиск фильмов
GET https://api.themoviedb.org/3/search/movie?api_key=XXX&query=Interstellar

# Детали фильма
GET https://api.themoviedb.org/3/movie/{id}?api_key=XXX

# Постер URL
https://image.tmdb.org/t/p/w500{poster_path}
```

**Response:**
```json
{
  "results": [
    {
      "id": 157336,
      "title": "Interstellar",
      "overview": "The adventures of a group of explorers...",
      "poster_path": "/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
      "backdrop_path": "/...",
      "release_date": "2014-11-05",
      "vote_average": 8.442,
      "genre_ids": [12, 18, 878]
    }
  ]
}
```

---

### 2. Google Books API

**Setup:**
```bash
# API Key: https://console.cloud.google.com/apis/credentials
# Enable: Books API
```

**Endpoints:**
```python
# Поиск книг
GET https://www.googleapis.com/books/v1/volumes?q=1984&key=XXX

# Детали книги
GET https://www.googleapis.com/books/v1/volumes/{id}
```

**Response:**
```json
{
  "items": [
    {
      "volumeInfo": {
        "title": "1984",
        "authors": ["George Orwell"],
        "publisher": "Houghton Mifflin Harcourt",
        "publishedDate": "1983",
        "description": "...",
        "imageLinks": {
          "thumbnail": "http://books.google.com/...",
          "smallThumbnail": "..."
        },
        "averageRating": 4.5,
        "isbn": "..."
      }
    }
  ]
}
```

---

### 3. Google Places API (Optional - платный)

**Альтернатива:** OpenStreetMap Nominatim (бесплатный)

```python
# Nominatim
GET https://nominatim.openstreetmap.org/search?q=Central+Park&format=json
```

---

### 4. Spoonacular API (Recipes)

**Setup:**
```bash
# https://spoonacular.com/food-api/console#Dashboard
# Free: 150 requests/day
```

**Endpoints:**
```python
# Поиск рецептов
GET https://api.spoonacular.com/recipes/complexSearch?query=pasta&apiKey=XXX

# Детали рецепта
GET https://api.spoonacular.com/recipes/{id}/information?apiKey=XXX
```

---

## 🏗️ Backend Architecture

### External Search Service

```python
# app/services/external_search_service.py

from typing import List, Dict, Any, Optional
import httpx
from app.core.config import settings

class ExternalSearchService:
    """Service for searching external APIs"""
    
    def __init__(self):
        self.tmdb_api_key = settings.TMDB_API_KEY
        self.google_books_key = settings.GOOGLE_BOOKS_KEY
        self.spoonacular_key = settings.SPOONACULAR_KEY
        
        self.tmdb_base = "https://api.themoviedb.org/3"
        self.google_books_base = "https://www.googleapis.com/books/v1"
        self.spoonacular_base = "https://api.spoonacular.com"
        self.tmdb_image_base = "https://image.tmdb.org/t/p/w500"
    
    async def search_movies(self, query: str, limit: int = 10) -> List[Dict[str, Any]]:
        """Search movies via TMDB"""
        async with httpx.AsyncClient() as client:
            response = await client.get(
                f"{self.tmdb_base}/search/movie",
                params={
                    "api_key": self.tmdb_api_key,
                    "query": query,
                    "language": "ru-RU",
                }
            )
            data = response.json()
            
            results = []
            for item in data.get("results", [])[:limit]:
                results.append({
                    "external_id": str(item["id"]),
                    "title": item["title"],
                    "description": item.get("overview", ""),
                    "image_url": f"{self.tmdb_image_base}{item['poster_path']}" if item.get("poster_path") else None,
                    "backdrop_url": f"{self.tmdb_image_base}{item['backdrop_path']}" if item.get("backdrop_path") else None,
                    "year": item.get("release_date", "")[:4] if item.get("release_date") else None,
                    "rating": item.get("vote_average"),
                    "source": "tmdb",
                })
            
            return results
    
    async def get_movie_details(self, movie_id: str) -> Dict[str, Any]:
        """Get detailed movie info"""
        async with httpx.AsyncClient() as client:
            # Movie details
            movie_response = await client.get(
                f"{self.tmdb_base}/movie/{movie_id}",
                params={
                    "api_key": self.tmdb_api_key,
                    "language": "ru-RU",
                }
            )
            movie = movie_response.json()
            
            # Credits (director, actors)
            credits_response = await client.get(
                f"{self.tmdb_base}/movie/{movie_id}/credits",
                params={"api_key": self.tmdb_api_key}
            )
            credits = credits_response.json()
            
            director = next(
                (c["name"] for c in credits.get("crew", []) if c["job"] == "Director"),
                None
            )
            actors = [c["name"] for c in credits.get("cast", [])[:5]]
            
            return {
                "title": movie["title"],
                "description": movie.get("overview", ""),
                "image_url": f"{self.tmdb_image_base}{movie['poster_path']}" if movie.get("poster_path") else None,
                "backdrop_url": f"https://image.tmdb.org/t/p/original{movie['backdrop_path']}" if movie.get("backdrop_path") else None,
                "year": movie.get("release_date", "")[:4] if movie.get("release_date") else None,
                "rating": movie.get("vote_average"),
                "director": director,
                "actors": actors,
                "genres": [g["name"] for g in movie.get("genres", [])],
                "runtime": movie.get("runtime"),
                "metadata": {
                    "director": director,
                    "actors": actors,
                    "genres": [g["name"] for g in movie.get("genres", [])],
                    "year": movie.get("release_date", "")[:4] if movie.get("release_date") else None,
                    "runtime": movie.get("runtime"),
                    "rating": movie.get("vote_average"),
                }
            }
    
    async def search_books(self, query: str, limit: int = 10) -> List[Dict[str, Any]]:
        """Search books via Google Books API"""
        async with httpx.AsyncClient() as client:
            response = await client.get(
                f"{self.google_books_base}/volumes",
                params={
                    "q": query,
                    "key": self.google_books_key,
                    "maxResults": limit,
                }
            )
            data = response.json()
            
            results = []
            for item in data.get("items", []):
                info = item.get("volumeInfo", {})
                results.append({
                    "external_id": item["id"],
                    "title": info.get("title", ""),
                    "description": info.get("description", ""),
                    "image_url": info.get("imageLinks", {}).get("thumbnail"),
                    "authors": info.get("authors", []),
                    "year": info.get("publishedDate", "")[:4] if info.get("publishedDate") else None,
                    "rating": info.get("averageRating"),
                    "source": "google_books",
                })
            
            return results
    
    async def search_recipes(self, query: str, limit: int = 10) -> List[Dict[str, Any]]:
        """Search recipes via Spoonacular API"""
        async with httpx.AsyncClient() as client:
            response = await client.get(
                f"{self.spoonacular_base}/recipes/complexSearch",
                params={
                    "query": query,
                    "apiKey": self.spoonacular_key,
                    "number": limit,
                    "addRecipeInformation": True,
                }
            )
            data = response.json()
            
            results = []
            for item in data.get("results", []):
                results.append({
                    "external_id": str(item["id"]),
                    "title": item["title"],
                    "description": item.get("summary", ""),
                    "image_url": item.get("image"),
                    "ready_in_minutes": item.get("readyInMinutes"),
                    "servings": item.get("servings"),
                    "source": "spoonacular",
                })
            
            return results
    
    async def smart_search(
        self,
        query: str,
        category: Optional[str] = None,
        limit: int = 10,
    ) -> Dict[str, List[Dict[str, Any]]]:
        """
        Smart search that queries multiple sources based on category
        
        If category is provided, only search that category.
        Otherwise, search all relevant sources.
        """
        results = {}
        
        if category == "movies" or category is None:
            results["movies"] = await self.search_movies(query, limit)
        
        if category == "books" or category is None:
            results["books"] = await self.search_books(query, limit)
        
        if category == "recipes" or category is None:
            results["recipes"] = await self.search_recipes(query, limit)
        
        return results


# Singleton
external_search_service = ExternalSearchService()
```

---

### API Endpoints

```python
# app/api/v1/external_search.py

from fastapi import APIRouter, Depends, Query
from app.services.external_search_service import external_search_service
from app.api.deps import get_current_user

router = APIRouter()


@router.get("/search")
async def search_external_content(
    q: str = Query(..., min_length=2),
    category: Optional[str] = Query(None),
    limit: int = Query(10, ge=1, le=20),
    current_user = Depends(get_current_user),
):
    """
    Smart search across external APIs
    
    - **q**: Search query
    - **category**: Filter by category (movies, books, recipes)
    - **limit**: Max results per source
    """
    results = await external_search_service.smart_search(q, category, limit)
    return results


@router.get("/movies/{movie_id}")
async def get_movie_details(
    movie_id: str,
    current_user = Depends(get_current_user),
):
    """Get detailed movie information from TMDB"""
    details = await external_search_service.get_movie_details(movie_id)
    return details
```

---

## 📱 Flutter UI

### 1. Search Screen with Rich Cards

```dart
// lib/features/memories/presentation/pages/smart_create_memory_page.dart

class SmartCreateMemoryPage extends StatefulWidget {
  @override
  State<SmartCreateMemoryPage> createState() => _SmartCreateMemoryPageState();
}

class _SmartCreateMemoryPageState extends State<SmartCreateMemoryPage> {
  final _searchController = TextEditingController();
  List<ExternalContent> _searchResults = [];
  bool _isSearching = false;
  
  Future<void> _performSearch(String query) async {
    if (query.length < 2) return;
    
    setState(() => _isSearching = true);
    
    try {
      final results = await externalSearchService.search(query);
      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      setState(() => _isSearching = false);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Создать воспоминание')),
      body: Column(
        children: [
          // Search field
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Найти фильм, книгу, место...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Debounced search
                Future.delayed(Duration(milliseconds: 500), () {
                  if (_searchController.text == value) {
                    _performSearch(value);
                  }
                });
              },
            ),
          ),
          
          // Results
          Expanded(
            child: _isSearching
                ? LoadingState()
                : ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final item = _searchResults[index];
                      return RichContentCard(
                        content: item,
                        onTap: () => _selectContent(item),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
  
  Future<void> _selectContent(ExternalContent content) async {
    // Get full details
    final details = await externalSearchService.getDetails(
      content.externalId,
      content.source,
    );
    
    // Navigate to confirm screen with pre-filled data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmMemoryPage(details: details),
      ),
    );
  }
}
```

### 2. Rich Content Card

```dart
// lib/features/memories/presentation/widgets/rich_content_card.dart

class RichContentCard extends StatelessWidget {
  final ExternalContent content;
  final VoidCallback onTap;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            // Poster/Cover
            if (content.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: content.imageUrl!,
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            
            SizedBox(width: 16),
            
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  SizedBox(height: 4),
                  
                  if (content.year != null)
                    Text(
                      content.year!,
                      style: TextStyle(color: Colors.grey),
                    ),
                  
                  if (content.rating != null)
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.amber),
                        SizedBox(width: 4),
                        Text(content.rating.toString()),
                      ],
                    ),
                  
                  SizedBox(height: 8),
                  
                  Text(
                    content.description,
                    style: TextStyle(fontSize: 12),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 🎨 UI Flow

```
┌─────────────────────────────────────┐
│  Создать воспоминание               │
├─────────────────────────────────────┤
│  🔍 [Найти фильм, книгу...]        │
├─────────────────────────────────────┤
│                                     │
│  ┌───────────────────────────────┐ │
│  │ [Poster] Интерстеллар         │ │
│  │          2014  ⭐ 8.6         │ │
│  │          Научно-фантастический│ │
│  └───────────────────────────────┘ │
│                                     │
│  ┌───────────────────────────────┐ │
│  │ [Poster] Начало               │ │
│  │          2010  ⭐ 8.8         │ │
│  │          Триллер, фантастика  │ │
│  └───────────────────────────────┘ │
│                                     │
└─────────────────────────────────────┘

        ↓ (Выбор карточки)

┌─────────────────────────────────────┐
│  Подтверждение                      │
├─────────────────────────────────────┤
│  [Large Backdrop Image]             │
│                                     │
│  Интерстеллар (2014)                │
│  Режиссер: Кристофер Нолан          │
│  ⭐ 8.6  🎬 169 мин                 │
│                                     │
│  Описание: ...                      │
│                                     │
│  ✏️ [Добавить заметку]              │
│                                     │
│  [Сохранить]  [Отмена]              │
└─────────────────────────────────────┘
```

---

## 💾 Storage Strategy

### Option 1: Store URLs (Recommended)
```python
{
  "image_url": "https://image.tmdb.org/t/p/w500/xxx.jpg",
  "backdrop_url": "https://image.tmdb.org/t/p/original/xxx.jpg"
}
```
✅ Просто
✅ Экономит место
❌ Зависит от внешнего сервиса

### Option 2: Download & Store Locally
```python
# Download image and save to S3/MinIO/local storage
image_path = await download_and_store_image(image_url)
```
✅ Независимость
✅ Быстрее
❌ Нужно storage
❌ Больше места

---

## 🔐 Environment Variables

```bash
# backend/.env

# TMDB (Movies)
TMDB_API_KEY=your_tmdb_key_here

# Google Books
GOOGLE_BOOKS_KEY=your_google_books_key_here

# Spoonacular (Recipes)
SPOONACULAR_KEY=your_spoonacular_key_here
```

---

## 📊 Implementation Priority

### Phase 1: Movies (TMDB) - ВЫСОКИЙ
- ✅ Самый популярный use case
- ✅ Отличное API
- ✅ Бесплатно
- ⏱️ 2-3 дня

### Phase 2: Books (Google Books) - СРЕДНИЙ
- ⏱️ 1-2 дня

### Phase 3: Recipes (Spoonacular) - НИЗКИЙ
- ⏱️ 1-2 дня

### Phase 4: Places (OpenStreetMap) - ОПЦИОНАЛЬНО
- ⏱️ 2-3 дня

---

## 🎯 Next Steps

1. Получить API keys (TMDB, Google Books)
2. Реализовать ExternalSearchService
3. Создать endpoints
4. Flutter UI для поиска
5. Rich cards
6. Confirm & save flow

**Готовы начать?** 🚀

