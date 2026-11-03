import 'package:flutter/material.dart';

/// Shared empty-state widget, used by favorites/categories/news lists.
class EmptyView extends StatelessWidget {
  final String message;
  final TextStyle? style;

  const EmptyView({super.key, required this.message, this.style});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message, style: style, textAlign: TextAlign.center),
    );
  }
}
