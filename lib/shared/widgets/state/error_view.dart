import 'package:flutter/material.dart';
import 'package:mynewsapp/core/theme/app_text_styles.dart';

/// Extracted from the inline error UI that used to live in views/News.dart.
/// Every async screen now uses this instead of inventing its own.
class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.signal_wifi_off_outlined, size: 25),
          const SizedBox(height: 8),
          Text(message, style: AppTextStyles.error, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          ElevatedButton(
            style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
            onPressed: onRetry,
            child: const Text("Try Again"),
          ),
        ],
      ),
    );
  }
}
