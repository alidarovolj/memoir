import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:memoir/core/widgets/base_input.dart';
import 'package:memoir/core/widgets/base_textarea.dart';
import 'package:memoir/core/widgets/base_button.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'package:memoir/features/profile/data/models/personal_data_model.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _professionController = TextEditingController();
  final _telegramController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _youtubeController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _aboutMeController = TextEditingController();
  final _cityController = TextEditingController();
  final _educationController = TextEditingController();
  final _hobbiesController = TextEditingController();

  DateTime? _dateOfBirth;
  bool _isLoading = true;
  bool _isSaving = false;
  String? _avatarUrl;
  File? _selectedImage;
  final _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeDateFormatting();
    _loadPersonalData();
  }

  Future<void> _initializeDateFormatting() async {
    await initializeDateFormatting('ru', null);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _professionController.dispose();
    _telegramController.dispose();
    _whatsappController.dispose();
    _youtubeController.dispose();
    _linkedinController.dispose();
    _aboutMeController.dispose();
    _cityController.dispose();
    _educationController.dispose();
    _hobbiesController.dispose();
    super.dispose();
  }

  Future<void> _loadPersonalData() async {
    try {
      final dio = DioClient.instance;
      
      // Загружаем основные данные пользователя
      final userResponse = await dio.get('/api/v1/users/me');
      final user = userResponse.data;
      
      // Загружаем личные данные
      try {
        final personalDataResponse = await dio.get('/api/v1/users/me/personal-data');
        if (personalDataResponse.data != null) {
          final data = PersonalDataModel.fromJson(personalDataResponse.data);
          setState(() {
            _professionController.text = data.profession ?? '';
            _telegramController.text = data.telegramUrl ?? '';
            _whatsappController.text = data.whatsappUrl ?? '';
            _youtubeController.text = data.youtubeUrl ?? '';
            _linkedinController.text = data.linkedinUrl ?? '';
            _aboutMeController.text = data.aboutMe ?? '';
            _cityController.text = data.city ?? '';
            _educationController.text = data.education ?? '';
            _hobbiesController.text = data.hobbies ?? '';
            _dateOfBirth = data.dateOfBirth;
          });
        }
      } catch (e) {
        // Личные данные могут отсутствовать (404) - это нормально
        // Просто оставляем поля пустыми
      }
      
      setState(() {
        _firstNameController.text = user['first_name'] ?? '';
        _lastNameController.text = user['last_name'] ?? '';
        _avatarUrl = user['avatar_url'] != null &&
                user['avatar_url'].toString().startsWith('/uploads')
            ? 'http://localhost:8000${user['avatar_url']}'
            : user['avatar_url'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickAndUploadAvatar() async {
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
                    color: AppTheme.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Ionicons.camera,
                    color: AppTheme.primaryColor,
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
                    color: AppTheme.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Ionicons.images,
                    color: AppTheme.primaryColor,
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
      }
    } catch (e) {
      if (mounted) {
        SnackBarUtils.showError(context, 'Не удалось выбрать изображение');
      }
    }
  }

  Future<void> _savePersonalData() async {
    // Валидация формы (имя и фамилия)
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Валидация фото
    if (_selectedImage == null && _avatarUrl == null) {
      if (mounted) {
        SnackBarUtils.showError(context, 'Фото профиля обязательно для заполнения');
      }
      return;
    }

    setState(() => _isSaving = true);

    try {
      final dio = DioClient.instance;
      
      // Сначала обновляем основные данные (имя, фамилия, фото)
      // Имя и фамилия обязательны, поэтому не проверяем на isEmpty
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
      
      // Затем обновляем личные данные
      final personalData = {
        'profession': _professionController.text.trim().isEmpty
            ? null
            : _professionController.text.trim(),
        'telegram_url': _telegramController.text.trim().isEmpty
            ? null
            : _telegramController.text.trim(),
        'whatsapp_url': _whatsappController.text.trim().isEmpty
            ? null
            : _whatsappController.text.trim(),
        'youtube_url': _youtubeController.text.trim().isEmpty
            ? null
            : _youtubeController.text.trim(),
        'linkedin_url': _linkedinController.text.trim().isEmpty
            ? null
            : _linkedinController.text.trim(),
        'about_me': _aboutMeController.text.trim().isEmpty
            ? null
            : _aboutMeController.text.trim(),
        'city': _cityController.text.trim().isEmpty
            ? null
            : _cityController.text.trim(),
        'date_of_birth': _dateOfBirth?.toIso8601String(),
        'education': _educationController.text.trim().isEmpty
            ? null
            : _educationController.text.trim(),
        'hobbies': _hobbiesController.text.trim().isEmpty
            ? null
            : _hobbiesController.text.trim(),
      };

      try {
        await dio.put('/api/v1/users/me/personal-data', data: personalData);
      } catch (e) {
        // Если endpoint не найден (404), это нормально для первого сохранения
        // Данные будут созданы при следующем запросе
        debugPrint('Error saving personal data: $e');
      }

      if (mounted) {
        SnackBarUtils.showSuccess(context, 'Данные успешно сохранены');
        Navigator.pop(context, true); // Возвращаем true, чтобы профиль обновил данные
      }
    } catch (e) {
      if (mounted) {
        SnackBarUtils.showError(context, 'Ошибка при сохранении данных: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _selectDateOfBirth() async {
    final picked = await showDatePicker(
      context: context,
      initialDate:
          _dateOfBirth ??
          DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  String? _validateUrl(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return null; // Поле необязательное
    }

    final url = value.trim();
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      return 'Введите корректную ссылку (начинается с http:// или https://)';
    }

    try {
      Uri.parse(url);
      return null;
    } catch (e) {
      return 'Введите корректную ссылку';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackgroundColor,
      body: Stack(
        children: [
          // Body content - весь контент на весь экран
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.primaryColor,
                    ),
                  ),
                )
              : Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 64 + 20, // SafeArea + высота CustomHeader + отступ
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                        children: [
                          // Фото профиля
                          Column(
                            children: [
                              Center(
                                child: GestureDetector(
                                  onTap: _pickAndUploadAvatar,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: AppTheme.primaryGradient,
                                        ),
                                        child: _selectedImage != null
                                            ? ClipOval(
                                                child: Image.file(
                                                  _selectedImage!,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : _avatarUrl != null
                                                ? ClipOval(
                                                    child: CachedNetworkImage(
                                                      imageUrl: _avatarUrl!,
                                                      fit: BoxFit.cover,
                                                      placeholder: (context, url) =>
                                                          const Center(
                                                            child: CircularProgressIndicator(),
                                                          ),
                                                      errorWidget: (context, url, error) =>
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color: AppTheme.primaryColor,
                                                              shape: BoxShape.circle,
                                                            ),
                                                            child: const Icon(
                                                              Ionicons.person,
                                                              size: 50,
                                                              color: AppTheme.whiteColor,
                                                            ),
                                                          ),
                                                    ),
                                                  )
                                                : const Icon(
                                                    Ionicons.person,
                                                    size: 50,
                                                    color: Colors.white,
                                                  ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: AppTheme.primaryColor,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                          child: const Icon(
                                            Ionicons.camera,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Фото профиля *',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.darkColor.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          
                          // Имя
                          BaseInput(
                            controller: _firstNameController,
                            label: 'Имя *',
                            icon: Ionicons.person_outline,
                            hint: 'Введите ваше имя',
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Имя обязательно для заполнения';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          
                          // Фамилия
                          BaseInput(
                            controller: _lastNameController,
                            label: 'Фамилия *',
                            icon: Ionicons.person_outline,
                            hint: 'Введите вашу фамилию',
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Фамилия обязательна для заполнения';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          
                          // Профессия
                          BaseInput(
                            controller: _professionController,
                            label: 'Профессия',
                            icon: Ionicons.briefcase_outline,
                            hint: 'Введите вашу профессию',
                          ),
                          const SizedBox(height: 12),

                          // Город
                          BaseInput(
                            controller: _cityController,
                            label: 'Город',
                            icon: Ionicons.location_outline,
                            hint: 'Введите ваш город',
                          ),
                          const SizedBox(height: 12),

                          // Дата рождения
                          _buildDateField(),
                          const SizedBox(height: 12),

                          // Образование
                          BaseInput(
                            controller: _educationController,
                            label: 'Образование',
                            icon: Ionicons.school_outline,
                            hint: 'Введите ваше образование',
                          ),
                          const SizedBox(height: 12),

                          // Хобби
                          BaseInput(
                            controller: _hobbiesController,
                            label: 'Хобби и интересы',
                            icon: Ionicons.heart_outline,
                            hint: 'Введите ваши хобби и интересы',
                          ),
                          const SizedBox(height: 20),

                          // Раздел соц. сетей
                          Text(
                            'Социальные сети',
                            style: TextStyle(
                              color: AppTheme.darkColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Telegram
                          BaseInput(
                            controller: _telegramController,
                            label: 'Telegram',
                            iconPath: 'assets/icons/socials/telegram.png',
                            hint: 'https://t.me/username',
                            validator: (value) =>
                                _validateUrl(value, 'Telegram'),
                          ),
                          const SizedBox(height: 12),

                          // WhatsApp
                          BaseInput(
                            controller: _whatsappController,
                            label: 'WhatsApp',
                            iconPath: 'assets/icons/socials/whatsapp.png',
                            hint: 'https://wa.me/номер',
                            validator: (value) =>
                                _validateUrl(value, 'WhatsApp'),
                          ),
                          const SizedBox(height: 12),

                          // YouTube
                          BaseInput(
                            controller: _youtubeController,
                            label: 'YouTube',
                            iconPath: 'assets/icons/socials/youtube.png',
                            hint: 'https://youtube.com/@channel',
                            validator: (value) =>
                                _validateUrl(value, 'YouTube'),
                          ),
                          const SizedBox(height: 12),

                          // LinkedIn
                          BaseInput(
                            controller: _linkedinController,
                            label: 'LinkedIn',
                            iconPath: 'assets/icons/socials/linkedin.png',
                            hint: 'https://linkedin.com/in/username',
                            validator: (value) =>
                                _validateUrl(value, 'LinkedIn'),
                          ),
                          const SizedBox(height: 20),

                          // О себе
                          Text(
                            'О себе',
                            style: TextStyle(
                              color: AppTheme.darkColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          BaseTextarea(
                            controller: _aboutMeController,
                            label: 'Расскажите о себе',
                            icon: Ionicons.person_outline,
                            hint: 'Напишите несколько слов о себе',
                            minLines: 3,
                            maxLines: 5,
                          ),
                          const SizedBox(height: 32),

                          // Кнопка сохранения
                          BaseButton(
                            onPressed: _savePersonalData,
                            text: 'Сохранить',
                            isLoading: _isSaving,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
          // CustomHeader поверх контента
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: CustomHeader(title: 'Личные данные', type: HeaderType.back),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.darkColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: _selectDateOfBirth,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Icon(Ionicons.calendar_outline, color: AppTheme.primaryColor),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Дата рождения',
                      style: TextStyle(
                        color: AppTheme.darkColor.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _dateOfBirth != null
                          ? DateFormat(
                              'dd MMMM yyyy',
                              'ru',
                            ).format(_dateOfBirth!)
                          : 'Выберите дату',
                      style: TextStyle(
                        color: _dateOfBirth != null
                            ? AppTheme.darkColor
                            : AppTheme.darkColor.withOpacity(0.5),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Ionicons.chevron_forward_outline,
                color: AppTheme.darkColor.withOpacity(0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
