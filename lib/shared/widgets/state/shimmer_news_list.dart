import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Was widgets/ShimerList.dart. A dumb, reusable loading skeleton.
class ShimmerNewsList extends StatelessWidget {
  const ShimmerNewsList({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDarkMode ? Colors.grey : Colors.grey.shade600;
    final highlightColor = isDarkMode ? Colors.grey.shade700 : Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: double.infinity, height: 200, color: Colors.black12),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(width: 100, height: 16, color: Colors.black12),
                            const SizedBox(height: 4),
                            Container(width: 150, height: 12, color: Colors.black12),
                            const SizedBox(height: 8),
                            Container(width: double.infinity, height: 16, color: Colors.black12),
                            const SizedBox(height: 8),
                            Container(width: 250, height: 16, color: Colors.black12),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(width: 24, height: 24, color: Colors.black12),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
