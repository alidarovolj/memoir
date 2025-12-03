# 🤖 AI-Powered Universal Search

## 🎯 Концепция

**Двухэтапный подход:**
1. **AI анализирует** текст и определяет intent (что пользователь хочет)
2. **Умный поиск** в нужных источниках + универсальный fallback

---

## 🧠 Step 1: AI Intent Detection

### Промпт для GPT

```python
system_prompt = """Проанализируй пользовательский запрос и определи его intent.

Возможные intents:
- movie: фильм, сериал
- book: книга, статья
- recipe: рецепт, блюдо
- place: ресторан, кафе, локация
- product: товар для покупки
- idea: мысль, заметка (без поиска)
- task: задача, дело

Верни JSON:
{
  "intent": "movie",
  "search_query": "Интерстеллар",  // Оптимизированный запрос для поиска
  "confidence": 0.95,
  "needs_search": true,  // false для ideas, tasks
  "reasoning": "Пользователь упоминает фильм"
}

Примеры:
- "Посмотрел Начало" → intent=movie, search_query="Начало", needs_search=true
- "Надо купить брелок" → intent=product, search_query="брелок", needs_search=true
- "Идея для стартапа" → intent=idea, needs_search=false
- "Купить молоко" → intent=task, needs_search=false
"""
```

---

## 🔍 Step 2: Smart Search Strategy

### Backend Service

```python
# app/services/universal_search_service.py

class UniversalSearchService:
    
    async def smart_search(self, user_query: str) -> Dict[str, Any]:
        """
        1. AI определяет intent
        2. Ищем в нужных источниках
        3. Возвращаем результаты + fallback
        """
        
        # Step 1: AI Intent Detection
        intent_result = await ai_service.detect_intent(user_query)
        
        intent = intent_result["intent"]
        search_query = intent_result["search_query"]
        needs_search = intent_result["needs_search"]
        
        results = {
            "intent": intent,
            "search_query": search_query,
            "needs_search": needs_search,
            "sources": {}
        }
        
        if not needs_search:
            # Для ideas, tasks - просто возвращаем пустой результат
            return results
        
        # Step 2: Search in specific sources
        if intent == "movie":
            results["sources"]["tmdb"] = await external_search.search_movies(search_query)
        
        elif intent == "book":
            results["sources"]["google_books"] = await external_search.search_books(search_query)
        
        elif intent == "recipe":
            results["sources"]["spoonacular"] = await external_search.search_recipes(search_query)
        
        elif intent == "product":
            # Универсальный поиск через Google
            results["sources"]["google"] = await self._google_search(search_query)
            # Или можно использовать Amazon Product API, eBay, AliExpress
        
        elif intent == "place":
            results["sources"]["places"] = await self._search_places(search_query)
        
        # Step 3: Universal fallback (Google Custom Search)
        # Если специализированный поиск ничего не нашел
        if not any(results["sources"].values()):
            results["sources"]["web"] = await self._google_search(search_query)
        
        return results
    
    async def _google_search(self, query: str) -> List[Dict[str, Any]]:
        """
        Universal web search via Google Custom Search API
        
        Free tier: 100 queries/day
        Upgrade: $5 per 1000 queries
        """
        async with httpx.AsyncClient() as client:
            response = await client.get(
                "https://www.googleapis.com/customsearch/v1",
                params={
                    "key": settings.GOOGLE_SEARCH_KEY,
                    "cx": settings.GOOGLE_SEARCH_CX,  # Custom search engine ID
                    "q": query,
                    "num": 10,
                }
            )
            data = response.json()
            
            results = []
            for item in data.get("items", []):
                results.append({
                    "title": item.get("title"),
                    "description": item.get("snippet"),
                    "url": item.get("link"),
                    "image_url": item.get("pagemap", {}).get("cse_thumbnail", [{}])[0].get("src"),
                    "source": "web",
                })
            
            return results
    
    async def _search_places(self, query: str) -> List[Dict[str, Any]]:
        """
        Search places via OpenStreetMap (free) or Google Places (paid)
        """
        # OpenStreetMap Nominatim (бесплатный!)
        async with httpx.AsyncClient() as client:
            response = await client.get(
                "https://nominatim.openstreetmap.org/search",
                params={
                    "q": query,
                    "format": "json",
                    "limit": 10,
                },
                headers={"User-Agent": "Memoir/1.0"}
            )
            data = response.json()
            
            results = []
            for item in data:
                results.append({
                    "title": item.get("display_name"),
                    "description": f"{item.get('type')} - {item.get('addresstype', '')}",
                    "address": item.get("display_name"),
                    "lat": item.get("lat"),
                    "lon": item.get("lon"),
                    "source": "osm",
                })
            
            return results
```

---

## 🎨 UI Flow с AI Intent

```
┌─────────────────────────────────────┐
│  Создать воспоминание               │
├─────────────────────────────────────┤
│  ✏️ [Надо купить брелок]            │
│                                     │
│  🤖 AI обрабатывает...              │
├─────────────────────────────────────┤
│                                     │
│  💡 Обнаружено: Товар для покупки   │
│                                     │
│  🔍 Результаты поиска:              │
│                                     │
│  ┌───────────────────────────────┐ │
│  │ [Фото] Брелок для ключей      │ │
│  │        $5.99  ⭐ 4.5          │ │
│  │        Amazon                 │ │
│  └───────────────────────────────┘ │
│                                     │
│  ┌───────────────────────────────┐ │
│  │ [Фото] Кожаный брелок         │ │
│  │        $12.99  ⭐ 4.8         │ │
│  │        AliExpress             │ │
│  └───────────────────────────────┘ │
│                                     │
│  или                                │
│                                     │
│  [➕ Создать простую заметку]       │
└─────────────────────────────────────┘
```

---

## 🛠️ Для разных типов контента:

### 🎬 Фильмы/Сериалы
- **Source:** TMDB API
- **Data:** Постер, описание, режиссер, актеры, рейтинг

### 📚 Книги
- **Source:** Google Books API
- **Data:** Обложка, автор, описание, издательство

### 🍳 Рецепты
- **Source:** Spoonacular API
- **Data:** Фото, ингредиенты, инструкции, время

### 🛍️ Продукты
- **Source:** Google Custom Search
- **Data:** Фото, цена (из snippet), ссылка на магазин

### 📍 Места
- **Source:** OpenStreetMap (бесплатный!)
- **Data:** Адрес, координаты, тип места

### 💡 Идеи/Заметки
- **No search** - просто текстовая заметка
- AI классификация для категории и тегов

---

## 🎯 Что реализовать?

### Вариант 1: **Полный комбо** (рекомендую!)
1. AI Intent Detection
2. TMDB для фильмов
3. Google Books для книг  
4. Google Custom Search для всего остального (универсальный fallback)
5. Возможность создать простую заметку

**Время:** 3-4 дня

### Вариант 2: **Только TMDB + Simple notes**
Для MVP - фильмы с богатыми карточками, остальное - простые заметки

**Время:** 1-2 дня

---

**Что выбираем?** 🤔
1. Полный AI-Powered Universal Search
2. Только TMDB для начала
3. Сначала Planning, потом Smart Search
