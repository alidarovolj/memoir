import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';

class AIInfoCard extends StatelessWidget {
  final List<AIFeature> features;
  final String title;

  const AIInfoCard({
    super.key,
    required this.features,
    this.title = 'AI автоматически:',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withOpacity(0.1),
            AppTheme.secondaryColor.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _buildAIFeature(feature.icon, feature.text),
              )),
        ],
      ),
    );
  }

  Widget _buildAIFeature(IconData icon, String text) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        
        return Row(
          children: [
            Icon(icon, size: 18, color: AppTheme.primaryColor),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class AIFeature {
  final IconData icon;
  final String text;

  const AIFeature({required this.icon, required this.text});
}

