import 'dart:io';
import 'package:flutter/material.dart';
import 'package:memoir/core/core.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/core/widgets/audio_recorder_widget.dart';
import 'package:memoir/core/widgets/audio_player_widget.dart';
import 'package:memoir/core/widgets/base_input.dart';
import 'package:memoir/core/widgets/base_textarea.dart';
import 'package:memoir/core/widgets/base_button.dart';
import 'package:ionicons/ionicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memoir/features/tasks/data/models/task_model.dart';
import 'package:dio/dio.dart';

class CreateMemoryPage extends StatefulWidget {
  final TaskModel? task; // Опциональная задача для предзаполнения

  const CreateMemoryPage({super.key, this.task});

  @override
  State<CreateMemoryPage> createState() => _CreateMemoryPageState();
}

class _CreateMemoryPageState extends State<CreateMemoryPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _linkController = TextEditingController();
  bool _isLoading = false;
  bool _publishAsStory = false; // Toggle для публикации в историях
  late AnimationController _slideController;
  File? _selectedImage; // Selected image file
  String? _uploadedImageUrl; // Uploaded image URL from backend
  File? _selectedAudio; // Selected audio file
  String? _uploadedAudioUrl; // Uploaded audio URL from backend
  String? _audioTranscript; // Transcribed text from audio
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideController.forward();
    
    // Предзаполняем данные из задачи, если она передана
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      // Используем описание задачи, если оно есть, иначе оставляем пустым для пользователя
      if (widget.task!.description != null && widget.task!.description!.isNotEmpty) {
        _contentController.text = widget.task!.description!;
      }
      // Если описания нет, оставляем поле пустым - пользователь сам заполнит
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _linkController.dispose();
    _slideController.dispose();
    super.dispose();
  }


  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });

        // Upload immediately after selection
        await _uploadImage();
      }
    } catch (e) {
      if (mounted) {
        // Более детальное сообщение об ошибке
        String errorMessage = 'Ошибка выбора изображения';
        if (e.toString().contains('photo access')) {
          errorMessage = 'Необходимо разрешение на доступ к галерее';
        }
        SnackBarUtils.showError(context, errorMessage);
      }
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) return;

    setState(() => _isLoading = true);

    try {
      final dio = DioClient.instance;
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          _selectedImage!.path,
          filename: _selectedImage!.path.split('/').last,
        ),
      });

      final response = await dio.post('/api/v1/upload/image', data: formData);

      if (response.data['success'] == true) {
        final imageUrl = response.data['image_url'];
        print('📸 [UPLOAD] Image uploaded successfully: $imageUrl');
        setState(() {
          _uploadedImageUrl = imageUrl;
          _isLoading = false;
        });

        if (mounted) {
          SnackBarUtils.showSuccess(context, 'Изображение загружено!');
        }
      } else {
        print('❌ [UPLOAD] Upload failed - success is not true');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        SnackBarUtils.showError(context, 'Ошибка загрузки изображения');
      }
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
      _uploadedImageUrl = null;
    });
  }

  Future<void> _handleAudioRecording(String audioPath) async {
    setState(() {
      _selectedAudio = File(audioPath);
    });

    // Upload audio to backend
    await _uploadAudio();
  }

  Future<void> _uploadAudio() async {
    if (_selectedAudio == null) return;

    setState(() => _isLoading = true);

    try {
      final dio = DioClient.instance;
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          _selectedAudio!.path,
          filename: 'voice_note_${DateTime.now().millisecondsSinceEpoch}.m4a',
        ),
      });

      final response = await dio.post('/api/v1/voice/upload', data: formData);

      if (response.data['success'] == true) {
        setState(() {
          _uploadedAudioUrl = response.data['audio_url'];
          _audioTranscript = response.data['transcript'];
          _isLoading = false;
        });

        // Автозаполнение контента транскрибированным текстом
        if (_audioTranscript != null && _audioTranscript!.isNotEmpty) {
          _contentController.text = _audioTranscript!;
        }

        if (mounted) {
          SnackBarUtils.showSuccess(
            context,
            'Голосовая заметка загружена и транскрибирована! 🎙️',
          );
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        SnackBarUtils.showError(context, 'Ошибка загрузки аудио: $e');
      }
    }
  }

  void _removeAudio() {
    setState(() {
      _selectedAudio = null;
      _uploadedAudioUrl = null;
      _audioTranscript = null;
    });
  }

  void _showAudioRecorder() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: AppTheme.pageBackgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.all(20),
            child: AudioRecorderWidget(
              onRecordingComplete: (path) {
                Navigator.pop(context);
                _handleAudioRecording(path);
              },
              onCancel: () => Navigator.pop(context),
            ),
          );
        },
      ),
    );
  }


  Future<void> _createMemory() async {
    print('🎯 [CREATE] Starting memory creation...');

    if (!_formKey.currentState!.validate()) {
      print('❌ [CREATE] Form validation failed');
      return;
    }

    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      print('❌ [CREATE] Title or content is empty');
      SnackBarUtils.showWarning(context, 'Заполните все поля');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final memoryData = <String, dynamic>{
        'title': _titleController.text,
        'content': _contentController.text,
        'source_type': 'text', // Всегда text, так как можно добавлять разные типы контента
      };

      // Добавляем привязку к задаче, если воспоминание создается из задачи
      if (widget.task != null) {
        memoryData['related_task_id'] = widget.task!.id;
      }

      // Add link URL if exists
      if (_linkController.text.trim().isNotEmpty) {
        memoryData['source_url'] = _linkController.text.trim();
      }

      // Add uploaded image URL if exists
      if (_uploadedImageUrl != null) {
        memoryData['image_url'] = 'http://localhost:8000$_uploadedImageUrl';
        print('📸 [CREATE] Image URL added: ${memoryData['image_url']}');
      } else {
        print('⚠️ [CREATE] No image URL - _uploadedImageUrl is null');
      }

      // Add uploaded audio URL and transcript if exists
      if (_uploadedAudioUrl != null) {
        memoryData['audio_url'] = 'http://localhost:8000$_uploadedAudioUrl';
        if (_audioTranscript != null) {
          memoryData['audio_transcript'] = _audioTranscript;
        }
      }

      print('📝 [CREATE] Base memory data: $memoryData');
      print('✅ [CREATE] Final memory data: $memoryData');

      // Add story flag to memory data
      memoryData['publish_as_story'] = _publishAsStory;
      print(
        '🚀 [CREATE] Popping with data (publish_as_story: $_publishAsStory)...',
      );

      if (mounted) {
        Navigator.of(context).pop(memoryData);
        print('✅ [CREATE] Navigation completed');
      }
    } catch (e, stackTrace) {
      print('❌ [CREATE] Error occurred: $e');
      print('📚 [CREATE] Stack trace: $stackTrace');

      if (mounted) {
        setState(() => _isLoading = false);
        final message = ErrorMessages.getErrorMessage(e);
        SnackBarUtils.showError(
          context,
          'Не удалось создать воспоминание: $message',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: AppTheme.pageBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 36,
            height: 5,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.darkColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Новое воспоминание',
                  style: TextStyle(
                    color: AppTheme.darkColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppTheme.darkColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Ionicons.close,
                      color: AppTheme.darkColor,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Divider
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(vertical: 16),
            color: AppTheme.darkColor.withOpacity(0.1),
          ),
          
          // Content
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      // Заголовок
                      _buildSectionTitle('Заголовок'),
                      const SizedBox(height: 12),
                      BaseInput(
                        controller: _titleController,
                        hint: 'О чем это воспоминание?',
                        icon: Ionicons.text_outline,
                        enabled: !_isLoading,
                      ),
                      const SizedBox(height: 24),

                      // Описание
                      _buildSectionTitle('Описание'),
                      const SizedBox(height: 12),
                      BaseTextarea(
                        controller: _contentController,
                        hint: 'Расскажите подробнее о том, что вы хотите запомнить...',
                        icon: Ionicons.document_text_outline,
                        minLines: 3,
                        maxLines: 8,
                        enabled: !_isLoading,
                      ),
                      const SizedBox(height: 32),

                      // Ссылка
                      _buildAddContentSection(
                        title: 'Ссылка',
                        icon: Ionicons.link_outline,
                        onAdd: () => _showLinkInput(),
                        hasContent: _linkController.text.trim().isNotEmpty,
                        contentWidget: _linkController.text.trim().isNotEmpty
                            ? _buildLinkPreview()
                            : null,
                      ),
                      const SizedBox(height: 24),

                      // Фото
                      _buildAddContentSection(
                        title: 'Фото',
                        icon: Ionicons.image_outline,
                        onAdd: _pickImage,
                        hasContent: _selectedImage != null,
                        contentWidget: _selectedImage != null
                            ? _buildImagePreview()
                            : null,
                      ),
                      const SizedBox(height: 24),

                      // Голосовая заметка
                      _buildAddContentSection(
                        title: 'Голосовая заметка',
                        icon: Ionicons.mic_outline,
                        onAdd: _showAudioRecorder,
                        hasContent: _selectedAudio != null,
                        contentWidget: _selectedAudio != null
                            ? AudioPlayerWidget(
                                audioPath: _selectedAudio!.path,
                                onDelete: _removeAudio,
                              )
                            : null,
                      ),
                      const SizedBox(height: 24),

                      // Переключатель "Опубликовать в историях"
                      _buildPublishAsStoryToggle(),
                      const SizedBox(height: 24),

                      // AI Info Card
                      // AIInfoCard(
                      //   features: const [
                      //     AIFeature(
                      //       icon: Ionicons.apps_outline,
                      //       text: 'Определит категорию автоматически',
                      //     ),
                      //     AIFeature(
                      //       icon: Ionicons.pricetags_outline,
                      //       text: 'Создаст релевантные теги',
                      //     ),
                      //     AIFeature(
                      //       icon: Ionicons.cube_outline,
                      //       text: 'Извлечёт ключевые метаданные',
                      //     ),
                      //     AIFeature(
                      //       icon: Ionicons.search_outline,
                      //       text: 'Добавит в семантический поиск',
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 32),

                      // Кнопка создания (дополнительная)
                      BaseButton(
                        text: 'Создать воспоминание',
                        icon: Ionicons.add_circle_outline,
                        onPressed: _createMemory,
                        isLoading: _isLoading,
                      ),
                      const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppTheme.darkColor,
      ),
    );
  }

  Widget _buildPublishAsStoryToggle() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _publishAsStory
              ? AppTheme.primaryColor
              : AppTheme.darkColor.withOpacity(0.1),
          width: _publishAsStory ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: _publishAsStory
                  ? AppTheme.primaryGradient
                  : LinearGradient(
                      colors: [
                        AppTheme.darkColor.withOpacity(0.2),
                        AppTheme.darkColor.withOpacity(0.3),
                      ],
                    ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Ionicons.book_outline,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Опубликовать в историях',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.darkColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _publishAsStory
                      ? 'Будет видна всем пользователям 7 дней'
                      : 'Только вы сможете видеть это воспоминание',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.darkColor.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Switch(
            value: _publishAsStory,
            onChanged: _isLoading
                ? null
                : (value) {
                    setState(() {
                      _publishAsStory = value;
                    });
                  },
            activeThumbColor: AppTheme.primaryColor,
            activeTrackColor: AppTheme.primaryColor.withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildAddContentSection({
    required String title,
    required IconData icon,
    required VoidCallback onAdd,
    required bool hasContent,
    Widget? contentWidget,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: hasContent
                        ? AppTheme.primaryColor.withOpacity(0.1)
                        : AppTheme.darkColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: hasContent
                        ? AppTheme.primaryColor
                        : AppTheme.darkColor.withOpacity(0.5),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkColor,
                  ),
                ),
              ],
            ),
            if (!hasContent)
              BaseButton(
                text: 'Добавить',
                icon: Ionicons.add_outline,
                onPressed: _isLoading ? null : onAdd,
                isFullWidth: false,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                fontSize: 14,
                borderRadius: 12,
              )
            else
              BaseButton(
                text: 'Изменить',
                onPressed: _isLoading ? null : onAdd,
                isFullWidth: false,
                backgroundColor: AppTheme.darkColor.withOpacity(0.05),
                foregroundColor: AppTheme.darkColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                fontSize: 13,
                fontWeight: FontWeight.w500,
                borderRadius: 8,
              ),
          ],
        ),
        if (contentWidget != null) ...[
          const SizedBox(height: 12),
          contentWidget,
        ],
      ],
    );
  }

  void _showLinkInput() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: AppTheme.pageBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Добавить ссылку',
                style: TextStyle(
                  color: AppTheme.darkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              BaseInput(
                controller: _linkController,
                hint: 'https://example.com',
                icon: Ionicons.link_outline,
                enabled: !_isLoading,
                keyboardType: TextInputType.url,
                onSubmitted: (value) {
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BaseButton(
                    text: 'Отмена',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    isFullWidth: false,
                    backgroundColor: AppTheme.darkColor.withOpacity(0.1),
                    foregroundColor: AppTheme.darkColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    fontSize: 14,
                  ),
                  const SizedBox(width: 12),
                  BaseButton(
                    text: 'Добавить',
                    onPressed: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                    isFullWidth: false,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    fontSize: 14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLinkPreview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.darkColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Ionicons.link_outline,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ссылка',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.darkColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _linkController.text.trim(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.darkColor,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _isLoading
                ? null
                : () {
                    setState(() {
                      _linkController.clear();
                    });
                  },
            icon: const Icon(
              Ionicons.close_outline,
              color: AppTheme.darkColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: _selectedImage != null
            ? DecorationImage(
                image: FileImage(_selectedImage!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Stack(
        children: [
          if (_isLoading)
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              onPressed: _isLoading ? null : _removeImage,
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Ionicons.close_outline,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
