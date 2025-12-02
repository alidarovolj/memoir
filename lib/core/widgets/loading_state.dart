import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';

class LoadingState extends StatelessWidget {
  final String? message;

  const LoadingState({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.4),
                  blurRadius: 30,
                  spreadRadius: 0,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 24),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? message;

  const LoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: LoadingState(message: message),
          ),
      ],
    );
  }
}

