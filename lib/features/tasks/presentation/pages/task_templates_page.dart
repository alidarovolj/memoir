import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/core.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/tasks/data/datasources/task_template_remote_datasource.dart';
import 'package:memoir/features/tasks/data/models/task_template_model.dart';

class TaskTemplatesPage extends StatefulWidget {
  const TaskTemplatesPage({super.key});

  @override
  State<TaskTemplatesPage> createState() => _TaskTemplatesPageState();
}

class _TaskTemplatesPageState extends State<TaskTemplatesPage> {
  final _dataSource =
      TaskTemplateRemoteDataSourceImpl(dio: DioClient.instance);

  bool _isLoading = true;
  List<TaskTemplateModel> _templates = [];
  String _searchQuery = '';
  bool _showSystemOnly = false;

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    setState(() => _isLoading = true);

    try {
      final response = await _dataSource.getTemplates(
        isSystem: _showSystemOnly ? true : null,
        search: _searchQuery.isEmpty ? null : _searchQuery,
      );

      if (mounted) {
        setState(() {
          _templates = (response['items'] as List)
              .map((item) => TaskTemplateModel.fromJson(item))
              .toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        SnackBarUtils.showError(context, 'Не удалось загрузить шаблоны');
      }
    }
  }

  Future<void> _useTemplate(TaskTemplateModel template) async {
    try {
      // Create task from template
      final task = await _dataSource.useTemplate(
        template.id,
        const UseTemplateRequest(),
      );

      if (mounted) {
        SnackBarUtils.showSuccess(
          context,
          '✅ Задача "${task.title}" создана из шаблона',
        );
        Navigator.of(context).pop(true); // Return to tasks page
      }
    } catch (e) {
      if (mounted) {
        SnackBarUtils.showError(
          context,
          'Не удалось создать задачу из шаблона',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: 'Шаблоны задач',
        leading: IconButton(
          icon: const Icon(Ionicons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.lightBackgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Search & Filter
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Search field
                    CustomTextField(
                      hintText: 'Поиск шаблонов...',
                      prefixIcon: Ionicons.search,
                      onChanged: (value) {
                        setState(() => _searchQuery = value);
                        _loadTemplates();
                      },
                    ),
                    const SizedBox(height: 12),

                    // Filter chips
                    Row(
                      children: [
                        FilterChip(
                          label: const Text('Системные'),
                          selected: _showSystemOnly,
                          onSelected: (selected) {
                            setState(() => _showSystemOnly = selected);
                            _loadTemplates();
                          },
                          selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                          checkmarkColor: AppTheme.primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Templates list
              Expanded(
                child: _isLoading
                    ? const LoadingState()
                    : _templates.isEmpty
                        ? EmptyState(
                            icon: Ionicons.document_text_outline,
                            title: 'Нет шаблонов',
                            subtitle: 'Создайте свой первый шаблон',
                            buttonText: 'Создать шаблон',
                            buttonIcon: Ionicons.add,
                            onButtonPressed: () {
                              // TODO: Navigate to create template page
                            },
                          )
                        : RefreshIndicator(
                            onRefresh: _loadTemplates,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: _templates.length,
                              itemBuilder: (context, index) {
                                final template = _templates[index];
                                return _TemplateCard(
                                  template: template,
                                  onTap: () => _useTemplate(template),
                                  onLongPress: () {
                                    _showTemplateOptions(template);
                                  },
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTemplateOptions(TaskTemplateModel template) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Ionicons.add_circle_outline),
              title: const Text('Использовать'),
              onTap: () {
                Navigator.pop(context);
                _useTemplate(template);
              },
            ),
            if (!template.isSystem) ...[
              ListTile(
                leading: const Icon(Ionicons.create_outline),
                title: const Text('Редактировать'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to edit template
                },
              ),
              ListTile(
                leading: const Icon(Ionicons.trash_outline, color: Colors.red),
                title: const Text('Удалить', style: TextStyle(color: Colors.red)),
                onTap: () async {
                  final navigator = Navigator.of(context);
                  navigator.pop();
                  await _dataSource.deleteTemplate(template.id);
                  _loadTemplates();
                  if (mounted) {
                    SnackBarUtils.showSuccess(context, 'Шаблон удален');
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TemplateCard extends StatelessWidget {
  final TaskTemplateModel template;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _TemplateCard({
    required this.template,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: isDark
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.surfaceColor.withOpacity(0.7),
                  AppTheme.cardColor.withOpacity(0.5),
                ],
              )
            : null,
        color: isDark ? null : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      template.icon ?? '📋',
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              template.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                          if (template.isSystem)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Системный',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (template.description != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          template.description!,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark
                                ? Colors.white.withOpacity(0.7)
                                : Colors.black54,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      const SizedBox(height: 8),

                      // Usage count
                      Row(
                        children: [
                          Icon(
                            Ionicons.people_outline,
                            size: 14,
                            color: isDark ? Colors.white60 : Colors.black45,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Использовано ${template.usageCount} раз',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? Colors.white60 : Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Arrow
                Icon(
                  Ionicons.chevron_forward,
                  color: isDark ? Colors.white30 : Colors.black26,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
