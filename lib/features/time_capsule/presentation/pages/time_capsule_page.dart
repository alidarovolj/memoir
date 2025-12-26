import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/custom_header.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/time_capsule/data/datasources/time_capsule_remote_datasource.dart';
import 'package:memoir/features/time_capsule/data/models/time_capsule_model.dart';
import 'package:intl/intl.dart';

/// Page for creating and viewing time capsules
class TimeCapsulePage extends StatefulWidget {
  const TimeCapsulePage({super.key});

  @override
  State<TimeCapsulePage> createState() => _TimeCapsulePageState();
}

class _TimeCapsulePageState extends State<TimeCapsulePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TimeCapsuleRemoteDataSource _dataSource;

  List<TimeCapsuleModel> _allCapsules = [];
  List<TimeCapsuleModel> _readyCapsules = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _dataSource = TimeCapsuleRemoteDataSourceImpl(dio: DioClient.instance);
    _loadCapsules();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadCapsules() async {
    setState(() => _isLoading = true);

    try {
      final all = await _dataSource.getTimeCapsules();
      final ready = await _dataSource.getReadyCapsules();

      setState(() {
        _allCapsules = all;
        _readyCapsules = ready;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка загрузки: $e')));
      }
    }
  }

  Future<void> _openCapsule(TimeCapsuleModel capsule) async {
    try {
      final opened = await _dataSource.openTimeCapsule(capsule.id);

      // Show opened capsule dialog
      if (mounted) {
        await showDialog(
          context: context,
          builder: (context) => _OpenedCapsuleDialog(capsule: opened),
        );

        // Reload capsules
        _loadCapsules();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка открытия: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Header
            CustomHeader(title: 'Капсулы времени', type: HeaderType.pop),

            // Tabs
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(44, 44, 44, 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white60,
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: 'Все'),
                  Tab(text: 'Готовые'),
                  Tab(text: 'Создать'),
                ],
              ),
            ),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAllCapsulesTab(),
                  _buildReadyCapsulesTab(),
                  _buildCreateCapsuleTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllCapsulesTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_allCapsules.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('📦', style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            const Text(
              'У вас еще нет капсул',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Создайте письмо будущему себе!',
              style: TextStyle(color: Colors.white60),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadCapsules,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _allCapsules.length,
        itemBuilder: (context, index) {
          final capsule = _allCapsules[index];
          return _CapsuleCard(
            capsule: capsule,
            onTap: () {
              if (capsule.isReadyToOpen) {
                _openCapsule(capsule);
              } else {
                // Show preview dialog
                _showCapsulePreview(capsule);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildReadyCapsulesTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_readyCapsules.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('⏰', style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            const Text(
              'Нет готовых капсул',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Капсулы появятся здесь, когда придет время',
              style: TextStyle(color: Colors.white60),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadCapsules,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _readyCapsules.length,
        itemBuilder: (context, index) {
          final capsule = _readyCapsules[index];
          return _CapsuleCard(
            capsule: capsule,
            onTap: () => _openCapsule(capsule),
          );
        },
      ),
    );
  }

  Widget _buildCreateCapsuleTab() {
    return _CreateCapsuleForm(
      onCreated: () {
        _tabController.animateTo(0); // Switch to "All" tab
        _loadCapsules();
      },
    );
  }

  void _showCapsulePreview(TimeCapsuleModel capsule) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromRGBO(44, 44, 44, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Text(capsule.statusIcon),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                capsule.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              capsule.statusText,
              style: TextStyle(
                color: Color(
                  int.parse(capsule.statusColor.replaceFirst('#', '0xFF')),
                ),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Создано: ${DateFormat('d MMM yyyy', 'ru').format(capsule.createdAt)}',
              style: const TextStyle(color: Colors.white60, fontSize: 14),
            ),
            Text(
              'Откроется: ${DateFormat('d MMM yyyy', 'ru').format(capsule.openDate)}',
              style: const TextStyle(color: Colors.white60, fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }
}

/// Capsule card widget
class _CapsuleCard extends StatelessWidget {
  final TimeCapsuleModel capsule;
  final VoidCallback onTap;

  const _CapsuleCard({required this.capsule, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
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
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(44, 44, 44, 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              // Emoji icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(
                    int.parse(capsule.statusColor.replaceFirst('#', '0xFF')),
                  ).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    capsule.statusIcon,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      capsule.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      capsule.statusText,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(
                          int.parse(
                            capsule.statusColor.replaceFirst('#', '0xFF'),
                          ),
                        ),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow icon
              Icon(
                capsule.isReadyToOpen
                    ? Ionicons.lock_open_outline
                    : Ionicons.lock_closed_outline,
                color: Colors.white60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Create capsule form
class _CreateCapsuleForm extends StatefulWidget {
  final VoidCallback onCreated;

  const _CreateCapsuleForm({required this.onCreated});

  @override
  State<_CreateCapsuleForm> createState() => _CreateCapsuleFormState();
}

class _CreateCapsuleFormState extends State<_CreateCapsuleForm> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  DateTime? _selectedDate;
  bool _isCreating = false;
  late TimeCapsuleRemoteDataSource _dataSource;

  @override
  void initState() {
    super.initState();
    _dataSource = TimeCapsuleRemoteDataSourceImpl(dio: DioClient.instance);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final firstDate = now.add(const Duration(days: 1));
    final lastDate = now.add(const Duration(days: 3650)); // 10 years

    final picked = await showDatePicker(
      context: context,
      initialDate: firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppTheme.primaryColor,
              surface: Color.fromRGBO(44, 44, 44, 1),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _createCapsule() async {
    if (_titleController.text.trim().isEmpty ||
        _contentController.text.trim().isEmpty ||
        _selectedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Заполните все поля')));
      return;
    }

    setState(() => _isCreating = true);

    try {
      await _dataSource.createTimeCapsule(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        openDate: _selectedDate!,
      );

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Капсула создана! 🎉')));

        // Clear form
        _titleController.clear();
        _contentController.clear();
        setState(() => _selectedDate = null);

        // Notify parent
        widget.onCreated();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isCreating = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // Header
          Center(
            child: Column(
              children: [
                Text('💌', style: const TextStyle(fontSize: 64)),
                const SizedBox(height: 16),
                const Text(
                  'Письмо будущему себе',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Напишите сообщение, которое откроется в будущем',
                  style: TextStyle(color: Colors.white60),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Title field
          const Text(
            'Название',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _titleController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Например: Мне через год',
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: const Color.fromRGBO(44, 44, 44, 1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Content field
          const Text(
            'Сообщение',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _contentController,
            style: const TextStyle(color: Colors.white),
            maxLines: 8,
            decoration: InputDecoration(
              hintText: 'Напишите, что хотите сказать себе в будущем...',
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: const Color.fromRGBO(44, 44, 44, 1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Date picker
          const Text(
            'Дата открытия',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _selectDate,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(44, 44, 44, 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Ionicons.calendar_outline, color: Colors.white60),
                  const SizedBox(width: 12),
                  Text(
                    _selectedDate == null
                        ? 'Выберите дату'
                        : DateFormat(
                            'd MMMM yyyy',
                            'ru',
                          ).format(_selectedDate!),
                    style: TextStyle(
                      color: _selectedDate == null
                          ? Colors.white38
                          : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Create button
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _isCreating ? null : _createCapsule,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isCreating
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : const Text(
                        'Создать капсулу',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Dialog showing opened capsule
class _OpenedCapsuleDialog extends StatelessWidget {
  final TimeCapsuleModel capsule;

  const _OpenedCapsuleDialog({required this.capsule});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(255, 255, 255, 0.3),
              Color.fromRGBO(233, 233, 233, 0.3),
              Color.fromRGBO(242, 242, 242, 0.1),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(44, 44, 44, 1),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('🎁', style: const TextStyle(fontSize: 64)),
              const SizedBox(height: 16),
              Text(
                capsule.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Создано ${DateFormat('d MMM yyyy', 'ru').format(capsule.createdAt)}',
                style: const TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  capsule.content,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Закрыть'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
