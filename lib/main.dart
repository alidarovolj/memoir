import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memoir/injection_container.dart' as di;
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/widgets.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'package:memoir/core/utils/error_messages.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/features/memories/presentation/pages/create_memory_page.dart';
import 'package:memoir/features/memories/presentation/widgets/widgets.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/memories/data/datasources/memory_remote_datasource.dart';
import 'package:memoir/core/services/auth_service.dart';
import 'package:memoir/features/auth/presentation/pages/login_page.dart';
import 'package:memoir/features/auth/presentation/pages/register_page.dart';

// Global navigation key для навигации из interceptor
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Настройка системных UI элементов
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFFF8FAFC),
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize dependency injection
  await di.init();

  runApp(const MemoirApp());
}

class MemoirApp extends StatelessWidget {
  const MemoirApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Инициализируем DioClient с navigation key
    DioClient.initialize(navigatorKey);

    return MaterialApp(
      navigatorKey: navigatorKey, // Добавляем глобальный ключ
      title: 'Memoir',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, // Светлая тема по умолчанию
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
    _navigate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 2500));

    if (mounted) {
      // Проверяем авторизацию
      final authService = AuthService(dio: DioClient.instance);
      final isAuth = await authService.isAuthenticated();

      if (isAuth) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.lightBackgroundGradient,
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Анимированная иконка с градиентом
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.5),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Ionicons.sparkles,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        AppTheme.primaryGradient.createShader(bounds),
                    child: Text(
                      'Memoir',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Personal Memory AI',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white60,
                      fontSize: 16,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 60),
                  // Красивый loader
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white.withOpacity(0.3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fabAnimController;
  int _selectedIndex = 0;

  late MemoryRemoteDataSource _memoryDataSource;
  List<Map<String, dynamic>> _memories = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fabAnimController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimController.forward();

    _memoryDataSource = MemoryRemoteDataSourceImpl(dio: DioClient.instance);
    _loadMemories();
  }

  @override
  void dispose() {
    _fabAnimController.dispose();
    super.dispose();
  }

  Future<void> _loadMemories() async {
    setState(() => _isLoading = true);

    try {
      final memories = await _memoryDataSource.getMemories();
      if (mounted) {
        setState(() {
          _memories = memories;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        final message = ErrorMessages.getErrorMessage(e);
        SnackBarUtils.showError(context, message);
      }
    }
  }

  Future<void> _createMemory(Map<String, dynamic> memoryData) async {
    try {
      await _memoryDataSource.createMemory(memoryData);
      if (mounted) {
        await _loadMemories(); // Перезагружаем список
        SnackBarUtils.showAIProcessing(
          context,
          'Воспоминание создано!\nAI классифицирует его в фоне...',
        );
      }
    } catch (e) {
      if (mounted) {
        final message = ErrorMessages.getErrorMessage(e);
        SnackBarUtils.showError(
          context,
          'Не удалось создать воспоминание: $message',
        );
      }
    }
  }

  Future<void> _deleteMemory(String id, int index) async {
    try {
      await _memoryDataSource.deleteMemory(id);
      if (mounted) {
        setState(() {
          _memories.removeAt(index);
        });
        SnackBarUtils.showSuccess(context, 'Воспоминание удалено');
      }
    } catch (e) {
      if (mounted) {
        final message = ErrorMessages.getErrorMessage(e);
        SnackBarUtils.showError(context, 'Не удалось удалить: $message');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: 'Memoir',
        actions: [
          IconButton(
            icon: const Icon(Ionicons.search_outline, size: 22),
            onPressed: () =>
                SnackBarUtils.showInfo(context, 'Поиск - в разработке'),
          ),
          IconButton(
            icon: const Icon(Ionicons.person_circle_outline, size: 22),
            onPressed: () =>
                SnackBarUtils.showInfo(context, 'Профиль - в разработке'),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.lightBackgroundGradient,
        ),
        child: SafeArea(child: _buildBody()),
      ),
      // floatingActionButton: ScaleTransition(
      //   scale: _fabAnimController,
      //   child: FloatingActionButton.extended(
      //     onPressed: () async {
      //       final result = await Navigator.of(context).push(
      //         PageTransitions.slideFromBottom(const CreateMemoryPage()),
      //       );

      //       if (result != null && result is Map<String, dynamic>) {
      //         await _createMemory(result);
      //       }
      //     },
      //     icon: const Icon(Ionicons.add_outline, size: 20),
      //     label: const Text('Создать'),
      //   ),
      // ),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          if (index == 1) {
            // Показываем модалку категорий
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => DraggableScrollableSheet(
                initialChildSize: 0.7,
                minChildSize: 0.5,
                maxChildSize: 0.9,
                builder: (context, scrollController) => const CategoriesModal(),
              ),
            );
          } else if (index == 2) {
            SnackBarUtils.showInfo(context, 'Поиск - в разработке');
          } else {
            setState(() => _selectedIndex = index);
          }
        },
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingState(message: 'Загрузка воспоминаний...');
    }

    if (_memories.isEmpty) {
      return EmptyState(
        icon: Ionicons.folder_open_outline,
        title: 'У вас пока нет воспоминаний',
        subtitle: 'Начните сохранять важные моменты,\nидеи и мысли',
        buttonText: 'Создать первое воспоминание',
        buttonIcon: Ionicons.add_circle_outline,
        onButtonPressed: () async {
          final result = await Navigator.of(
            context,
          ).push(PageTransitions.slideFromBottom(const CreateMemoryPage()));

          if (result != null && result is Map<String, dynamic>) {
            await _createMemory(result);
          }
        },
      );
    }

    return RefreshIndicator(
      onRefresh: _loadMemories,
      color: AppTheme.primaryColor,
      backgroundColor: AppTheme.surfaceColor,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _memories.length,
        itemBuilder: (context, index) {
          final memory = _memories[index];
          final createdAt = memory['created_at'] != null
              ? DateTime.parse(memory['created_at'])
              : DateTime.now();

          return MemoryCard(
            title: memory['title'] ?? 'Без заголовка',
            content: memory['content'] ?? '',
            category: memory['category_name'],
            tags: memory['tags'] != null
                ? List<String>.from(memory['tags'])
                : null,
            createdAt: createdAt,
            onTap: () {
              SnackBarUtils.showInfo(
                context,
                'Детальный просмотр - в разработке',
              );
            },
            onEdit: () {
              SnackBarUtils.showInfo(context, 'Редактирование - в разработке');
            },
            onDelete: () {
              _showDeleteConfirmation(context, memory['id'], index);
            },
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String id, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Удалить воспоминание?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Это действие нельзя отменить',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteMemory(id, index);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }
}

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;

  final categories = [
    {
      'name': 'Movies & TV',
      'icon': Ionicons.film_outline,
      'color': const Color(0xFFE50914),
      'emoji': '🎬',
    },
    {
      'name': 'Books & Articles',
      'icon': Ionicons.book_outline,
      'color': const Color(0xFF4285F4),
      'emoji': '📚',
    },
    {
      'name': 'Places',
      'icon': Ionicons.location_outline,
      'color': const Color(0xFF34A853),
      'emoji': '📍',
    },
    {
      'name': 'Ideas & Insights',
      'icon': Ionicons.bulb_outline,
      'color': const Color(0xFFFBBC04),
      'emoji': '💡',
    },
    {
      'name': 'Recipes',
      'icon': Ionicons.restaurant_outline,
      'color': const Color(0xFFFF6D00),
      'emoji': '🍳',
    },
    {
      'name': 'Products',
      'icon': Ionicons.bag_handle_outline,
      'color': const Color(0xFF9C27B0),
      'emoji': '🛍️',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      categories.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ),
    );
    _animateCards();
  }

  void _animateCards() async {
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 80));
      if (mounted) {
        _controllers[i].forward();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: 'Категории',
        leading: IconButton(
          icon: const Icon(Ionicons.chevron_back_outline),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.lightBackgroundGradient,
        ),
        child: SafeArea(
          child: GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.0,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _controllers[index],
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                child: FadeTransition(
                  opacity: _controllers[index],
                  child: CategoryCard(
                    name: category['name'] as String,
                    icon: category['icon'] as IconData,
                    color: category['color'] as Color,
                    emoji: category['emoji'] as String,
                    count: 0,
                    onTap: () {
                      SnackBarUtils.showInfo(
                        context,
                        '${category['name']} - в разработке',
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
