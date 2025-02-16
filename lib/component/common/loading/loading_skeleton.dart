import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../const/styles.dart';

class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppStyles.padding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // MainStat 영역 Shimmer
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[700]!,
                        highlightColor: Colors.grey[500]!,
                        child: Container(
                          width: 120,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      Icon(Icons.refresh, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[700]!,
                    highlightColor: Colors.grey[500]!,
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // ChartStat 영역 Shimmer
            Shimmer.fromColors(
              baseColor: Colors.grey[700]!,
              highlightColor: Colors.grey[500]!,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // PastStat 영역 Shimmer
            Shimmer.fromColors(
              baseColor: Colors.grey[700]!,
              highlightColor: Colors.grey[500]!,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 