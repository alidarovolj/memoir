/// App constants
class Constants {
  // Category colors (matching backend)
  static const Map<String, int> categoryColors = {
    'movies': 0xFFE50914,
    'books': 0xFF4285F4,
    'places': 0xFF34A853,
    'ideas': 0xFFFBBC04,
    'recipes': 0xFFFF6D00,
    'products': 0xFF9C27B0,
  };
  
  // Category icons (Material Icons names)
  static const Map<String, String> categoryIcons = {
    'movies': 'movie',
    'books': 'book',
    'places': 'location_on',
    'ideas': 'lightbulb',
    'recipes': 'restaurant',
    'products': 'shopping_bag',
  };
  
  // Animation durations
  static const Duration shortAnimDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimDuration = Duration(milliseconds: 300);
  static const Duration longAnimDuration = Duration(milliseconds: 500);
  
  // Debounce durations
  static const Duration searchDebounce = Duration(milliseconds: 500);
  
  // UI
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
}

