import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/core/widgets/gradient_button.dart';
import 'package:memoir/features/pet/data/models/pet_model.dart';
import 'package:memoir/features/pet/data/datasources/pet_remote_datasource.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'package:ionicons/ionicons.dart';

/// Pet onboarding page - Choose and name your pet
class PetOnboardingPage extends StatefulWidget {
  const PetOnboardingPage({super.key});

  @override
  State<PetOnboardingPage> createState() => _PetOnboardingPageState();
}

class _PetOnboardingPageState extends State<PetOnboardingPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  PetType? _selectedPetType;
  final _nameController = TextEditingController();
  late PetRemoteDataSource _petDataSource;
  bool _isLoading = false;
  int _currentStep = 0; // 0 = choose type, 1 = enter name

  @override
  void initState() {
    super.initState();
    _petDataSource = PetRemoteDataSourceImpl(dio: DioClient.instance);

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _createPet() async {
    if (_selectedPetType == null) {
      SnackBarUtils.showWarning(context, 'Выберите питомца');
      return;
    }

    final name = _nameController.text.trim();
    if (name.isEmpty) {
      SnackBarUtils.showWarning(context, 'Введите имя питомца');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final pet = await _petDataSource.createPet(
        PetCreateRequest(petType: _selectedPetType!, name: name),
      );

      if (mounted) {
        SnackBarUtils.showSuccess(context, 'Питомец $name создан! 🎉');
        Navigator.of(context).pop(pet);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        SnackBarUtils.showError(context, 'Не удалось создать питомца');
      }
    }
  }

  void _nextStep() {
    if (_selectedPetType == null) {
      SnackBarUtils.showWarning(context, 'Выберите питомца');
      return;
    }

    setState(() {
      _currentStep = 1;
      _fadeController.reset();
      _fadeController.forward();
    });
  }

  void _previousStep() {
    setState(() {
      _currentStep = 0;
      _fadeController.reset();
      _fadeController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.lightBackgroundGradient,
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Progress indicator
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            gradient: _currentStep >= 0
                                ? AppTheme.primaryGradient
                                : null,
                            color: _currentStep < 0
                                ? Colors.white.withOpacity(0.3)
                                : null,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            gradient: _currentStep >= 1
                                ? AppTheme.primaryGradient
                                : null,
                            color: _currentStep < 1
                                ? Colors.white.withOpacity(0.3)
                                : null,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  Expanded(
                    child: _currentStep == 0
                        ? _buildPetTypeSelection()
                        : _buildPetNameInput(),
                  ),

                  // Buttons
                  if (_currentStep == 0)
                    GradientButton(
                      text: 'Далее',
                      icon: Ionicons.arrow_forward,
                      onPressed: _nextStep,
                    )
                  else
                    Column(
                      children: [
                        GradientButton(
                          text: 'Создать питомца',
                          icon: Ionicons.checkmark_circle,
                          onPressed: _isLoading ? null : _createPet,
                          isLoading: _isLoading,
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: _previousStep,
                          child: const Text('Назад'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPetTypeSelection() {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: const Text(
            'Выберите питомца',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Ваш спутник будет расти вместе с вами',
          style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.7)),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 40),

        Expanded(
          child: ListView(
            children: [
              _buildPetTypeCard(
                type: PetType.bird,
                emoji: '🐦',
                name: 'Птица',
                description:
                    'Быстрая и свободолюбивая. Эволюция: 🥚 → 🐣 → 🐦 → 🦅',
              ),
              const SizedBox(height: 16),
              _buildPetTypeCard(
                type: PetType.cat,
                emoji: '🐱',
                name: 'Кот',
                description:
                    'Независимый и мудрый. Эволюция: 🥚 → 🐱 → 🐈 → 🦁',
              ),
              const SizedBox(height: 16),
              _buildPetTypeCard(
                type: PetType.dragon,
                emoji: '🐲',
                name: 'Дракон',
                description:
                    'Могущественный и величественный. Эволюция: 🥚 → 🦎 → 🐲 → 🐉',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPetTypeCard({
    required PetType type,
    required String emoji,
    required String name,
    required String description,
  }) {
    final isSelected = _selectedPetType == type;

    return GestureDetector(
      onTap: () => setState(() => _selectedPetType = type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: isSelected ? AppTheme.primaryGradient : null,
          color: isSelected ? null : AppTheme.surfaceColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : Colors.white.withOpacity(0.1),
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(emoji, style: const TextStyle(fontSize: 48)),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white.withOpacity(0.9)
                          : Colors.white.withOpacity(0.6),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Ionicons.checkmark_circle,
                color: Colors.white,
                size: 32,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetNameInput() {
    final petEmoji = _selectedPetType == PetType.bird
        ? '🥚'
        : _selectedPetType == PetType.cat
        ? '🥚'
        : '🥚';

    return Column(
      children: [
        Text(petEmoji, style: const TextStyle(fontSize: 120)),

        const SizedBox(height: 24),

        ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: const Text(
            'Дайте имя питомцу',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'Это имя будет сопровождать вас на всём пути',
          style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.7)),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 40),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: TextField(
            controller: _nameController,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Например: Мурзик',
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 24,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
            ),
            maxLength: 50,
            textCapitalization: TextCapitalization.words,
          ),
        ),

        const SizedBox(height: 24),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Icon(
                Ionicons.information_circle,
                color: AppTheme.primaryColor,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Имя можно будет изменить позже в настройках питомца',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),

        const Spacer(),
      ],
    );
  }
}
