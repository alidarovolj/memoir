import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:memoir/injection_container.dart' as di;
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/widgets.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'package:memoir/core/utils/error_messages.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/features/memories/presentation/pages/create_memory_page.dart';
import 'package:memoir/features/memories/presentation/pages/memory_detail_page.dart';
import 'package:memoir/features/memories/presentation/widgets/widgets.dart';
import 'package:memoir/features/search/presentation/pages/search_page.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/memories/data/datasources/memory_remote_datasource.dart';
import 'package:memoir/core/services/auth_service.dart';
import 'package:memoir/core/services/notification_service.dart';
import 'package:memoir/features/auth/presentation/pages/phone_login_page.dart';
import 'package:memoir/features/auth/presentation/pages/profile_setup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memoir/features/stories/data/datasources/story_remote_datasource.dart';
import 'package:memoir/features/stories/data/models/story_model.dart';
import 'package:memoir/features/stories/presentation/widgets/stories_list.dart';
import 'package:memoir/features/tasks/presentation/pages/tasks_page.dart';
import 'package:memoir/features/memories/presentation/pages/edit_memory_page.dart';
import 'package:memoir/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:memoir/features/tasks/data/models/task_suggestion_model.dart';
import 'package:memoir/features/tasks/presentation/widgets/task_suggestions_modal.dart';
import 'package:memoir/features/profile/presentation/pages/profile_page.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memoir/features/analytics/data/datasources/analytics_remote_datasource.dart';
import 'package:memoir/features/analytics/data/models/analytics_model.dart';
import 'package:memoir/features/analytics/presentation/widgets/header_stats.dart';
import 'package:memoir/features/analytics/presentation/widgets/this_week_card.dart';
import 'package:memoir/features/analytics/presentation/widgets/streaks_card.dart';
import 'package:memoir/core/widgets/referral_banner.dart';
// Pet imports
import 'package:memoir/features/pet/data/models/pet_model.dart';
import 'package:memoir/features/pet/data/datasources/pet_remote_datasource.dart';
import 'package:memoir/features/pet/presentation/widgets/pet_widget.dart';
import 'package:memoir/features/pet/presentation/pages/pet_page.dart';
import 'package:memoir/features/pet/presentation/pages/pet_onboarding_page.dart';
import 'package:memoir/features/pet/data/services/pet_service.dart';
// Time Capsule imports
import 'package:memoir/features/time_capsule/data/datasources/time_capsule_remote_datasource.dart';
import 'package:memoir/features/time_capsule/presentation/widgets/throwback_modal.dart';
import 'package:memoir/features/time_capsule/presentation/pages/time_capsule_page.dart';
// Daily Prompts imports
import 'package:memoir/features/daily_prompts/presentation/widgets/daily_prompt_card.dart';

// Global navigation key для навигации из interceptor
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env file
  await dotenv.load(fileName: ".env");

  // Initialize Firebase for Push Notifications
  await Firebase.initializeApp();

  // Initialize Notification Service
  await NotificationService().initialize();

  // Note: PetService will be initialized after DioClient is ready (in HomePage)

  // Настройка системных UI элементов
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
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
    return MaterialApp(
      navigatorKey: navigatorKey, // Добавляем глобальный ключ
      navigatorObservers: [
        ChuckerFlutter.navigatorObserver,
      ], // Добавляем Chucker observer
      title: 'Memoir',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, // Светлая тема по умолчанию
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/phone-login': (context) => const PhoneLoginPage(),
        '/profile-setup': (context) => const ProfileSetupPage(),
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
      // Инициализируем DioClient с navigation key и SharedPreferences
      await DioClient.initialize(navigatorKey);

      // Проверяем авторизацию
      final prefs = await SharedPreferences.getInstance();
      final dio = DioClient
          .instance; // Используем глобальный instance с auth interceptor
      final authService = AuthService(dio, prefs);
      final isAuth = await authService.isAuthenticated();

      if (isAuth) {
        // Send FCM token to backend for already authenticated user
        try {
          final notificationService = NotificationService();
          await notificationService.sendTokenToBackend();
        } catch (e) {
          // Log but don't block navigation
          print('⚠️ [SPLASH] Failed to send FCM token: $e');
        }

        // Проверяем заполненность профиля
        try {
          final response = await dio.get('/api/v1/users/me');
          final user = response.data;

          final hasFirstName =
              user['first_name'] != null &&
              user['first_name'].toString().isNotEmpty;
          final hasLastName =
              user['last_name'] != null &&
              user['last_name'].toString().isNotEmpty;

          if (!hasFirstName || !hasLastName) {
            // Профиль не заполнен, перенаправляем на настройку
            print('👤 [SPLASH] Profile incomplete, redirecting to setup');
            Navigator.of(context).pushReplacementNamed('/profile-setup');
          } else {
            // Профиль заполнен, переходим на главную
            Navigator.of(context).pushReplacementNamed('/home');
          }
        } catch (e) {
          print('⚠️ [SPLASH] Failed to check profile: $e');
          // В случае ошибки, переходим на главную
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } else {
        Navigator.of(context).pushReplacementNamed('/phone-login');
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
                  // SVG Logo
                  Container(
                    width: 200,
                    height: 147, // Соотношение сторон 400:294 из SVG
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      'assets/images/first_logo.svg',
                      fit: BoxFit.contain,
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
  late ScrollController _scrollController;
  int _selectedIndex = 0;
  bool _showHeaderTitle = false;

  late MemoryRemoteDataSource _memoryDataSource;
  late StoryRemoteDataSource _storyDataSource;
  late TaskRemoteDataSource _taskDataSource;
  late AnalyticsRemoteDataSource _analyticsDataSource;
  late PetRemoteDataSource _petDataSource;
  late TimeCapsuleRemoteDataSource _timeCapsuleDataSource;
  List<Map<String, dynamic>> _memories = [];
  List<StoryModel> _stories = [];
  bool _isLoading = false;
  bool _isLoadingStories = false;
  AnalyticsDashboard? _analytics;
  bool _isLoadingAnalytics = true;
  PetModel? _pet;
  bool _isLoadingPet = true;
  bool _petOnboardingShown =
      false; // Flag to prevent showing onboarding multiple times
  bool _throwbackShown =
      false; // Flag to prevent showing throwback multiple times

  // User data for display
  String? _userName;
  String? _userAvatar;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    // Initialize PetService with properly configured DioClient
    PetService().initialize();

    _memoryDataSource = MemoryRemoteDataSourceImpl(dio: DioClient.instance);
    _storyDataSource = StoryRemoteDataSourceImpl(dio: DioClient.instance);
    _taskDataSource = TaskRemoteDataSourceImpl(dio: DioClient.instance);
    _analyticsDataSource = AnalyticsRemoteDataSourceImpl(
      dio: DioClient.instance,
    );
    _petDataSource = PetRemoteDataSourceImpl(dio: DioClient.instance);
    _timeCapsuleDataSource = TimeCapsuleRemoteDataSourceImpl(
      dio: DioClient.instance,
    );
    _loadUserData();
    _loadMemories();
    _loadStories();
    _loadAnalytics();
    _loadPet();
    _checkThrowback(); // Check for throwback memory
  }

  void _onScroll() {
    // Показываем заголовок в хедере, если проскроллили больше 100px
    final shouldShow = _scrollController.offset > 100;
    if (shouldShow != _showHeaderTitle) {
      setState(() {
        _showHeaderTitle = shouldShow;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    try {
      final response = await DioClient.instance.get('/api/v1/users/me');
      final user = response.data;

      if (mounted) {
        setState(() {
          final firstName = user['first_name'] ?? '';
          final lastName = user['last_name'] ?? '';
          _userName = '$firstName $lastName'.trim();
          if (_userName!.isEmpty) {
            _userName = user['username'] ?? 'Пользователь';
          }
          _userAvatar = user['avatar_url'];
        });
      }
    } catch (e) {
      print('⚠️ Failed to load user data: $e');
    }
  }

  Future<void> _loadAnalytics() async {
    try {
      setState(() => _isLoadingAnalytics = true);
      final analytics = await _analyticsDataSource.getAnalyticsDashboard();
      if (mounted) {
        setState(() {
          _analytics = analytics;
          _isLoadingAnalytics = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _analytics = null;
          _isLoadingAnalytics = false;
        });
      }
      print('⚠️ Failed to load analytics: $e');
    }
  }

  Future<void> _loadPet() async {
    print('🐾 [HOME] Loading pet...');
    try {
      final pet = await PetService().loadPet();

      print('🐾 [HOME] Pet loaded: $pet');
      print('🐾 [HOME] Pet is null: ${pet == null}');

      if (mounted) {
        setState(() {
          _pet = pet;
          _isLoadingPet = false;
        });

        // Show onboarding ONLY if no pet AND flag not set
        if (pet == null && !_petOnboardingShown) {
          print('🐾 [HOME] No pet found, showing onboarding');
          _petOnboardingShown = true;
          _showPetOnboarding();
        } else if (pet != null) {
          print('🐾 [HOME] Pet exists: ${pet.name}, NOT showing onboarding');
        }
      }
    } catch (e, stackTrace) {
      print('❌ [HOME] Error loading pet: $e');
      print('❌ [HOME] Stack trace: $stackTrace');
      if (mounted) {
        setState(() {
          _pet = null;
          _isLoadingPet = false;
        });
      }
    }
  }

  Future<void> _checkThrowback() async {
    print('🕰️ [HOME] Checking for throwback memory...');

    // Only show once per session
    if (_throwbackShown) {
      print('🕰️ [HOME] Throwback already shown this session');
      return;
    }

    // Delay to let the home page load first
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    try {
      final memory = await _timeCapsuleDataSource.getThrowbackMemory(
        yearsAgo: 1,
      );

      if (memory != null && mounted) {
        print('🕰️ [HOME] Found throwback memory: ${memory.title}');
        _throwbackShown = true;

        // Show throwback modal as overlay
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => ThrowbackModal(
            memory: memory,
            yearsAgo: 1,
            onClose: () => Navigator.pop(context),
          ),
        );
      } else {
        print('🕰️ [HOME] No throwback memory found');
      }
    } catch (e) {
      print('⚠️ [HOME] Error checking throwback: $e');
      // Silently fail - not critical
    }
  }

  Future<void> _showPetOnboarding() async {
    // Delay to let the home page load first
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    final result = await Navigator.of(
      context,
    ).push(PageTransitions.slideFromBottom(const PetOnboardingPage()));

    if (result != null && result is PetModel) {
      setState(() => _pet = result);
      PetService().updatePet(result);
      SnackBarUtils.showSuccess(
        context,
        'Добро пожаловать, ${result.name}! 🎉',
      );
    }
  }

  Future<void> _feedPet() async {
    if (_pet == null) return;

    try {
      final result = await PetService().feedPet();

      if (result != null && mounted) {
        setState(() => _pet = result.pet);

        if (result.levelUps > 0 || result.evolved) {
          SnackBarUtils.showSuccess(context, result.message);
        }
      }
    } catch (e) {
      print('⚠️ Failed to feed pet: $e');
    }
  }

  Future<void> _loadMemories() async {
    setState(() => _isLoading = true);

    try {
      final memories = await _memoryDataSource.getMemories();
      print('📋 [HOME] Loaded ${memories.length} memories');

      // Debug: print first memory details
      if (memories.isNotEmpty) {
        print('🔍 [HOME] First memory data:');
        print('   - id: ${memories[0]['id']}');
        print('   - title: ${memories[0]['title']}');
        print('   - category_name: ${memories[0]['category_name']}');
        print('   - ai_confidence: ${memories[0]['ai_confidence']}');
        print('   - tags: ${memories[0]['tags']}');
        print('   - image_url: ${memories[0]['image_url']}');
        print('   - backdrop_url: ${memories[0]['backdrop_url']}');
        print('   - memory_metadata: ${memories[0]['memory_metadata']}');
      }

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
    print('🏠 [HOME] Received memory data from CreateMemoryPage');
    print('📦 [HOME] Memory data keys: ${memoryData.keys}');

    // Extract story flag before sending to backend
    final shouldPublishAsStory =
        memoryData.remove('publish_as_story') as bool? ?? false;
    print(
      '📖 [HOME] Should publish as story: $shouldPublishAsStory (type: ${shouldPublishAsStory.runtimeType})',
    );

    try {
      print('🚀 [HOME] Calling backend API...');
      final response = await _memoryDataSource.createMemory(memoryData);
      print('✅ [HOME] Backend API call successful!');
      print('📦 [HOME] Response ID: ${response['id']}');

      // If user wants to publish as story, create story
      if (shouldPublishAsStory && response['id'] != null) {
        print('📖 [HOME] Creating story for memory ${response['id']}...');
        try {
          await _storyDataSource.createStory(response['id'], true);
          print('✅ [HOME] Story created successfully');
          await _loadStories(); // Reload stories
        } catch (storyError) {
          print('❌ [HOME] Error creating story: $storyError');
          if (mounted) {
            SnackBarUtils.showWarning(
              context,
              'Воспоминание создано, но не удалось опубликовать в историях',
            );
          }
        }
      } else {
        print(
          'ℹ️ [HOME] Not publishing as story (flag was: $shouldPublishAsStory)',
        );
      }

      if (mounted) {
        print('🔄 [HOME] Reloading memories list...');
        await _loadMemories(); // Перезагружаем список
        print('✅ [HOME] Memories reloaded');

        // 🐾 NEW: Feed pet when creating memory
        await _feedPet();

        if (shouldPublishAsStory) {
          SnackBarUtils.showSuccess(
            context,
            '✨ Воспоминание создано и опубликовано в историях!\nAI обрабатывает данные...',
          );
        } else {
          SnackBarUtils.showAIProcessing(
            context,
            'Воспоминание создано!\nAI классифицирует его в фоне...',
          );
        }

        // 🔥 NEW: Get AI task suggestions after creating memory
        print('💡 [HOME] Fetching AI task suggestions...');
        try {
          final suggestions = await _taskDataSource.getSuggestedTasksFromMemory(
            response['id'],
          );

          if (suggestions.isNotEmpty && mounted) {
            print('✨ [HOME] Got ${suggestions.length} AI suggestions');
            // Show suggestions modal
            await Future.delayed(
              const Duration(milliseconds: 500),
            ); // Небольшая задержка для UX
            if (mounted) {
              _showTaskSuggestionsModal(suggestions);
            }
          } else {
            print('ℹ️ [HOME] No AI suggestions returned');
          }
        } catch (suggestionError) {
          print('⚠️ [HOME] Error fetching suggestions: $suggestionError');
          // Не показываем ошибку пользователю - это не критично
        }
      }
    } catch (e, stackTrace) {
      print('❌ [HOME] Error creating memory: $e');
      print('📚 [HOME] Stack trace: $stackTrace');

      if (mounted) {
        final message = ErrorMessages.getErrorMessage(e);
        SnackBarUtils.showError(
          context,
          'Не удалось создать воспоминание: $message',
        );
      }
    }
  }

  void _showTaskSuggestionsModal(List<TaskSuggestionModel> suggestions) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return TaskSuggestionsModal(
            suggestions: suggestions,
            onTaskSelected: (suggestion) {
              // Создать задачу из suggestion
              _createTaskFromSuggestion(suggestion);
            },
          );
        },
      ),
    );
  }

  Future<void> _createTaskFromSuggestion(TaskSuggestionModel suggestion) async {
    try {
      print('📋 [HOME] Creating task from AI suggestion: ${suggestion.title}');

      final taskData = {
        'title': suggestion.title,
        'description': suggestion.description,
        'priority': suggestion.priority,
        'time_scope': suggestion.timeScope,
        'status': 'pending',
        'ai_suggested': true,
        'ai_confidence': suggestion.confidence,
      };

      await _taskDataSource.createTask(taskData);

      if (mounted) {
        SnackBarUtils.showSuccess(
          context,
          '✅ Задача "${suggestion.title}" создана!',
        );
      }
    } catch (e) {
      print('❌ [HOME] Error creating task from suggestion: $e');
      if (mounted) {
        SnackBarUtils.showError(context, 'Не удалось создать задачу');
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

  Future<void> _editMemory(Map<String, dynamic> memory, int index) async {
    final result = await Navigator.of(
      context,
    ).push(PageTransitions.slideFromRight(EditMemoryPage(memory: memory)));

    if (result != null && result is Map<String, dynamic>) {
      print('🏠 [HOME] Received updated memory data');
      print('📦 [HOME] Update data: $result');

      try {
        print('🚀 [HOME] Calling backend API to update...');
        await _memoryDataSource.updateMemory(memory['id'], result);

        if (mounted) {
          await _loadMemories();
          SnackBarUtils.showSuccess(
            context,
            '✅ Воспоминание обновлено!\nAI переклассифицирует в фоне...',
          );
          print('✅ [HOME] Memory updated successfully');
        }
      } catch (e, stackTrace) {
        print('❌ [HOME] Error updating memory: $e');
        print('📚 [HOME] Stack trace: $stackTrace');

        if (mounted) {
          final message = ErrorMessages.getErrorMessage(e);
          SnackBarUtils.showError(context, 'Не удалось обновить: $message');
        }
      }
    }
  }

  Future<void> _loadStories() async {
    setState(() => _isLoadingStories = true);

    try {
      final stories = await _storyDataSource.getPublicStories();
      print('📖 [STORIES] Loaded ${stories.length} stories');

      if (mounted) {
        setState(() {
          _stories = stories;
          _isLoadingStories = false;
        });
      }
    } catch (e) {
      print('❌ [STORIES] Error loading stories: $e');
      if (mounted) {
        setState(() => _isLoadingStories = false);
      }
    }
  }

  Future<void> _showAddStoryDialog() async {
    // Redirect to create memory page
    SnackBarUtils.showInfo(
      context,
      'Создайте воспоминание и включите "Опубликовать в историях" 📖',
    );

    final result = await Navigator.of(
      context,
    ).push(PageTransitions.slideFromBottom(const CreateMemoryPage()));

    if (result != null && result is Map<String, dynamic>) {
      await _createMemory(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildCurrentPage(),
          // Фиксированная кнопка справа для создания воспоминания
          Positioned(
            right: 0,
            bottom: 20, // Над таббаром
            child: GestureDetector(
              onTap: () async {
                final result = await Navigator.of(context).push(
                  PageTransitions.slideFromBottom(const CreateMemoryPage()),
                );

                if (result != null && result is Map<String, dynamic>) {
                  await _createMemory(result);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(-5, 0),
                    ),
                  ],
                ),
                child: RotatedBox(
                  quarterTurns: 3, // Поворачиваем текст вертикально
                  child: const Text(
                    'Создать воспоминание',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomePage(); // Главная страница с хедером
      case 1:
        return const SearchPage(); // Поиск
      case 2:
        return const TasksPage(); // AI/Задачи
      case 3:
        return const ProfilePage(); // Профиль
      default:
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    return Container(
      color: AppTheme.pageBackgroundColor, // Фон страницы rgba(28, 27, 32, 1)
      child: Column(
        children: [
          // SafeArea с хедером только для главной
          Container(
            color: AppTheme
                .headerBackgroundColor, // Фон хедера и SafeArea rgba(21, 20, 24, 1)
            child: SafeArea(
              bottom: false,
              child: CustomHeader(
                title: _showHeaderTitle ? 'Главная' : '',
                type: HeaderType.none,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Ionicons.add_outline, size: 24),
                      color: Colors.white,
                      onPressed: () async {
                        final result = await Navigator.of(context).push(
                          PageTransitions.slideFromBottom(
                            const CreateMemoryPage(),
                          ),
                        );

                        if (result != null && result is Map<String, dynamic>) {
                          await _createMemory(result);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Ionicons.bookmark_outline, size: 22),
                      color: Colors.white,
                      onPressed: () => SnackBarUtils.showInfo(
                        context,
                        'Закладки - в разработке',
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Ionicons.notifications_outline,
                        size: 22,
                      ),
                      color: Colors.white,
                      onPressed: () => SnackBarUtils.showInfo(
                        context,
                        'Уведомления - в разработке',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Body content
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingState(message: 'Загрузка воспоминаний...');
    }

    return RefreshIndicator(
      onRefresh: _loadMemories,
      color: AppTheme.primaryColor,
      backgroundColor: AppTheme.surfaceColor,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Заголовок "Главная" над сторисами
          if (_stories.isNotEmpty || _isLoadingStories)
            SliverToBoxAdapter(
              child: AnimatedOpacity(
                opacity: _showHeaderTitle ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  color: AppTheme.headerBackgroundColor,
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                  child: const Text(
                    'Главная',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

          // Stories list
          if (_stories.isNotEmpty || _isLoadingStories)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: StoriesList(
                  stories: _stories,
                  isLoading: _isLoadingStories,
                  onAddStory: _showAddStoryDialog,
                  onStoryTap: (story) {
                    // onStoryTap больше не используется, навигация внутри StoriesList
                  },
                ),
              ),
            ),

          // Banner carousel
          // SliverToBoxAdapter(
          //   child: BannerCarousel(
          //     banners: [
          //       BannerItem(
          //         assetPath: 'assets/images/test_banner.jpg',
          //         title: 'Netflix Poster Series II',
          //         subtitle: 'Новая коллекция постеров',
          //         url: 'https://www.netflix.com', // Пример URL
          //       ),
          //       // Можно добавить больше баннеров
          //       BannerItem(
          //         assetPath: 'assets/images/test_banner.jpg',
          //         title: 'Сохраняйте воспоминания',
          //         subtitle: 'Начните свою историю',
          //         onTap: () {
          //           // Пример с callback вместо URL
          //           SnackBarUtils.showInfo(
          //             context,
          //             'Создайте ваше первое воспоминание!',
          //           );
          //         },
          //       ),
          //     ],
          //     height: 180,
          //   ),
          // ),

          // Реферальный баннер
          SliverToBoxAdapter(
            child: ReferralBanner(
              onTap: () {
                SnackBarUtils.showInfo(
                  context,
                  'Функция приглашения друзей - в разработке',
                );
              },
            ),
          ),

          // Pet Widget
          if (_pet != null && !_isLoadingPet)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: PetWidget(
                  pet: _pet!,
                  onTap: () {
                    Navigator.of(context)
                        .push(
                          PageTransitions.slideFromRight(
                            PetPage(initialPet: _pet!),
                          ),
                        )
                        .then((_) => _loadPet()); // Reload pet after returning
                  },
                ),
              ),
            ),

          // Блоки аналитики
          if (_analytics != null && !_isLoadingAnalytics) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: HeaderStats(
                  totalMemories: _analytics!.totalMemories,
                  totalTasksCompleted: _analytics!.totalTasksCompleted,
                ),
              ),
            ),

            // Daily Prompt Card
            const SliverToBoxAdapter(child: DailyPromptCard()),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: ThisWeekCard(
                  thisWeekMemories: _analytics!.thisWeekMemories,
                  thisWeekTasks: _analytics!.thisWeekTasks,
                  thisWeekTime: _analytics!.thisWeekTime,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: StreaksCard(
                  currentStreak: _analytics!.currentStreak,
                  longestStreak: _analytics!.longestStreak,
                ),
              ),
            ),
          ],

          // Заголовок "Вспоминаем вместе"
          if (_memories.isNotEmpty)
            SliverToBoxAdapter(
              child: Container(
                color: AppTheme.pageBackgroundColor,
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: const Text(
                  'Вспоминаем вместе',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          // Memories list
          if (_memories.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyState(
                title: 'У вас пока нет воспоминаний',
                subtitle: 'Начните сохранять важные моменты,\nидеи и мысли',
                buttonText: 'Создать первое воспоминание',
                buttonIcon: Ionicons.add_circle_outline,
                showIcon: false, // Убираем большую иконку
                onButtonPressed: () async {
                  final result = await Navigator.of(context).push(
                    PageTransitions.slideFromBottom(const CreateMemoryPage()),
                  );

                  if (result != null && result is Map<String, dynamic>) {
                    await _createMemory(result);
                  }
                },
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 16, // Уменьшенный отступ, так как нет FAB
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    // Разделители между постами
                    if (index.isOdd) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        height: 1,
                        color: Colors.white.withOpacity(0.08),
                      );
                    }

                    final memoryIndex = index ~/ 2;
                    final memory = _memories[memoryIndex];
                    final createdAt = memory['created_at'] != null
                        ? DateTime.parse(memory['created_at'])
                        : DateTime.now();

                    // Extract AI data
                    final aiConfidence = memory['ai_confidence'] != null
                        ? (memory['ai_confidence'] as num).toDouble()
                        : null;

                    // Check if AI is still processing (memory created recently with no category)
                    final isProcessing =
                        memory['category_id'] == null &&
                        DateTime.now().difference(createdAt).inMinutes < 5;

                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 16,
                        top: 16,
                      ),
                      child: MemoryCard(
                        title: memory['title'] ?? 'Без заголовка',
                        content: memory['content'] ?? '',
                        category: memory['category_name'],
                        tags: memory['tags'] != null
                            ? List<String>.from(memory['tags'])
                            : null,
                        createdAt: createdAt,
                        imageUrl: memory['image_url'],
                        aiConfidence: aiConfidence,
                        isAiProcessing: isProcessing,
                        authorName: _userName,
                        authorAvatar: _userAvatar,
                        isOwnPost: true, // Все посты на главной - свои
                        onTap: () async {
                          final result = await Navigator.of(context).push(
                            PageTransitions.slideFromRight(
                              MemoryDetailPage(memoryId: memory['id']),
                            ),
                          );

                          // If memory was deleted, reload the list
                          if (result == true) {
                            await _loadMemories();
                          }
                        },
                        onEdit: () => _editMemory(memory, memoryIndex),
                        onDelete: () {
                          _showDeleteConfirmation(
                            context,
                            memory['id'],
                            memoryIndex,
                          );
                        },
                      ),
                    );
                  },
                  childCount: _memories.length * 2 - 1,
                ), // Удваиваем количество для разделителей
              ),
            ),
        ],
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
