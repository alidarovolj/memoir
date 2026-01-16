import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:developer' as developer;

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final _pageController = PageController();
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _imagePicker = ImagePicker();

  bool _isLoading = false;
  int _currentStep = 0;
  File? _selectedImage;

  @override
  void dispose() {
    _pageController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _nextStep() async {
    if (_currentStep == 0) {
      // Валидация имени и фамилии
      if (!_formKey.currentState!.validate()) return;

      setState(() {
        _currentStep = 1;
      });

      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (_currentStep == 1) {
      // Проверяем, что фото выбрано
      if (_selectedImage == null) {
        SnackBarUtils.showError(context, 'Выберите фотографию профиля');
        return;
      }

      // Сохранение профиля
      await _saveProfile();
    }
  }

  Future<void> _pickImage() async {
    // Показываем диалог выбора источника
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppTheme.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Выберите источник',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkColor,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: AppTheme.whiteColor,
                    size: 20,
                  ),
                ),
                title: const Text(
                  'Камера',
                  style: TextStyle(color: AppTheme.darkColor),
                ),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.photo_library,
                    color: AppTheme.whiteColor,
                    size: 20,
                  ),
                ),
                title: const Text(
                  'Галерея',
                  style: TextStyle(color: AppTheme.darkColor),
                ),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        ),
      ),
    );

    if (source == null) return;

    // Для камеры запрашиваем разрешение
    // Для галереи в iOS 14+ не требуется разрешение при использовании image_picker
    if (source == ImageSource.camera) {
      final status = await Permission.camera.request();

      if (!status.isGranted) {
        if (mounted) {
          SnackBarUtils.showError(
            context,
            'Необходимо разрешение на использование камеры',
          );

          // Предлагаем открыть настройки
          final shouldOpenSettings = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: AppTheme.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                'Разрешение не предоставлено',
                style: TextStyle(color: AppTheme.darkColor),
              ),
              content: Text(
                'Для загрузки фото необходимо разрешение. Открыть настройки?',
                style: TextStyle(color: AppTheme.darkColor.withOpacity(0.7)),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Отмена'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.primaryColor,
                  ),
                  child: const Text('Настройки'),
                ),
              ],
            ),
          );

          if (shouldOpenSettings == true) {
            await openAppSettings();
          }
        }
        return;
      }
    }

    // Выбираем изображение
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
        developer.log('📸 [PROFILE_SETUP] Image selected: ${pickedFile.path}');
      }
    } catch (e) {
      developer.log('❌ [PROFILE_SETUP] Error picking image: $e');
      if (mounted) {
        SnackBarUtils.showError(context, 'Не удалось выбрать изображение');
      }
    }
  }

  Future<void> _saveProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final dio = DioClient.instance;

      // Отправляем данные на бэкенд
      final formData = FormData.fromMap({
        'first_name': _firstNameController.text.trim(),
        'last_name': _lastNameController.text.trim(),
        if (_selectedImage != null)
          'avatar': await MultipartFile.fromFile(
            _selectedImage!.path,
            filename: 'avatar.jpg',
          ),
      });

      await dio.put('/api/v1/users/me', data: formData);

      developer.log('✅ [PROFILE_SETUP] Profile saved successfully');

      if (!mounted) return;

      // Переходим на домашнюю страницу
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } catch (e) {
      developer.log('❌ [PROFILE_SETUP] Error saving profile: $e');

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        SnackBarUtils.showError(
          context,
          'Не удалось сохранить профиль. Попробуйте снова.',
        );
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });

      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackgroundColor,
      body: Column(
        children: [
          // Header Section with gradient
          _buildHeader(context),

          // Content
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -20), // Смещаем вверх, чтобы перекрыть зеленый блок
              child: Container(
                decoration: const BoxDecoration(
                  color: AppTheme.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [_buildNameStep(), _buildPhotoStep()],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.primaryGradient,
      ),
      child: Column(
        children: [
          // Status bar spacer and navigation
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: statusBarHeight + 12,
              bottom: 12,
            ),
            child: Row(
              children: [
                // Кнопка назад (только на втором шаге)
                if (_currentStep > 0)
                  GestureDetector(
                    onTap: _previousStep,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.whiteColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.darkColor.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppTheme.darkColor,
                        size: 24,
                      ),
                    ),
                  ),
                // Заголовок по центру
                Expanded(
                  child: Center(
                    child: Text(
                      _currentStep == 0 ? 'Шаг 1 из 2' : 'Шаг 2 из 2',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.whiteColor,
                      ),
                    ),
                  ),
                ),
                // Невидимый элемент для баланса
                if (_currentStep > 0) const SizedBox(width: 40),
              ],
            ),
          ),

          // Progress indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.whiteColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: _currentStep >= 1
                          ? AppTheme.whiteColor
                          : AppTheme.whiteColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildNameStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),

            // Title
            const Text(
              'Как вас зовут?',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkColor,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Это поможет персонализировать ваш опыт',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.darkColor.withOpacity(0.6),
                height: 1.5,
              ),
            ),

            const SizedBox(height: 40),

            // First name field
            _buildTextField(
              controller: _firstNameController,
              label: 'Имя',
              hint: 'Введите ваше имя',
              icon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Введите имя';
                }
                if (value.trim().length < 2) {
                  return 'Минимум 2 символа';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Last name field
            _buildTextField(
              controller: _lastNameController,
              label: 'Фамилия',
              hint: 'Введите вашу фамилию',
              icon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Введите фамилию';
                }
                if (value.trim().length < 2) {
                  return 'Минимум 2 символа';
                }
                return null;
              },
            ),

            const SizedBox(height: 40),

            // Next button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _nextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: AppTheme.whiteColor,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Далее',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32),

          // Title
          const Text(
            'Добавьте фото профиля',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkColor,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Выберите фотографию для вашего профиля',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.darkColor.withOpacity(0.6),
              height: 1.5,
            ),
          ),

          const SizedBox(height: 48),

          // Avatar picker
          Center(
            child: GestureDetector(
              onTap: _pickImage,
              child: Stack(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: _selectedImage == null
                          ? AppTheme.primaryGradient
                          : null,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.accentColor.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                      image: _selectedImage != null
                          ? DecorationImage(
                              image: FileImage(_selectedImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _selectedImage == null
                        ? const Icon(
                            Icons.person,
                            size: 70,
                            color: AppTheme.whiteColor,
                          )
                        : null,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.whiteColor,
                          width: 4,
                        ),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: AppTheme.whiteColor,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 48),

          // Info text
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.lightGrayColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.darkColor.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _selectedImage == null
                        ? 'Нажмите на аватар, чтобы выбрать фото'
                        : 'Вы можете изменить фото позже в настройках',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.darkColor.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Save button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: AppTheme.whiteColor,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                elevation: 0,
                disabledBackgroundColor: AppTheme.primaryColor.withOpacity(0.5),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.whiteColor,
                        ),
                      ),
                    )
                  : const Text(
                      'Завершить',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppTheme.darkColor.withOpacity(0.2),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppTheme.darkColor.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppTheme.primaryColor,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: AppTheme.lightGrayColor,
      ),
      validator: validator,
    );
  }
}
