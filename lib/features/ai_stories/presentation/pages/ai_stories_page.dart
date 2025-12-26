import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:memoir/features/ai_stories/data/models/ai_story_model.dart';
import 'package:memoir/features/ai_stories/data/datasources/ai_story_remote_datasource.dart';
import 'package:share_plus/share_plus.dart';

class AIStoriesPage extends StatefulWidget {
  final String? memoryId;

  const AIStoriesPage({super.key, this.memoryId});

  @override
  State<AIStoriesPage> createState() => _AIStoriesPageState();
}

class _AIStoriesPageState extends State<AIStoriesPage> {
  late AIStoryRemoteDataSource _dataSource;
  StoryType _selectedType = StoryType.poem;
  String? _generatedText;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _dataSource = AIStoryRemoteDataSourceImpl(dio: DioClient.instance);
  }

  Future<void> _generateStory() async {
    setState(() {
      _isLoading = true;
      _generatedText = null;
    });

    try {
      final request = StoryGenerationRequest(
        storyType: _selectedType,
        memoryId: widget.memoryId,
      );

      final response = await _dataSource.generateStory(request);

      setState(() {
        _generatedText = response.generatedText;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _shareStory() {
    if (_generatedText != null) {
      Share.share(_generatedText!, subject: 'AI История из Memoir');
    }
  }

  void _copyToClipboard() {
    if (_generatedText != null) {
      Clipboard.setData(ClipboardData(text: _generatedText!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Скопировано!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pageBackgroundColor, // rgba(28, 27, 32, 1)
      body: Column(
        children: [
          Container(
            color: AppTheme.headerBackgroundColor, // rgba(21, 20, 24, 1)
            child: SafeArea(
              bottom: false,
              child: const CustomHeader(
                title: 'AI Истории',
                type: HeaderType.pop,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Выберите тип истории',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTypeSelector(),
                  const SizedBox(height: 24),
                  _buildGenerateButton(),
                  if (_isLoading) ...[
                    const SizedBox(height: 32),
                    _buildLoadingIndicator(),
                  ],
                  if (_generatedText != null) ...[
                    const SizedBox(height: 24),
                    _buildGeneratedStory(),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: StoryType.values.map((type) {
        final isSelected = _selectedType == type;
        return GestureDetector(
          onTap: () => setState(() => _selectedType = type),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? const LinearGradient(
                      colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                    )
                  : null,
              color: isSelected ? null : const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? Colors.transparent : Colors.white10,
              ),
            ),
            child: Column(
              children: [
                Text(type.icon, style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 4),
                Text(
                  type.displayName,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGenerateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _generateStory,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: const Color(0xFF667eea),
          disabledBackgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.auto_awesome, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Создать ${_selectedType.displayName}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Column(
        children: [
          const CircularProgressIndicator(color: Color(0xFF667eea)),
          const SizedBox(height: 16),
          Text(
            'AI создаёт ${_selectedType.displayName.toLowerCase()}...',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneratedStory() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(255, 255, 255, 0.2),
            Color.fromRGBO(233, 233, 233, 0.2),
            Color.fromRGBO(242, 242, 242, 0),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(44, 44, 44, 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    _selectedType.icon,
                    style: const TextStyle(fontSize: 32),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _selectedType.displayName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _copyToClipboard,
                    icon: const Icon(
                      Icons.copy,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: _shareStory,
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.white10, height: 32),
              SelectableText(
                _generatedText!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
