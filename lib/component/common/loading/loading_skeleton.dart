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
            // 상단 여백 추가
            const SizedBox(height: 50),

            // 탐욕 지수 헤더
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '탐욕 지수 ',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                _buildGradientContainer(width: 70, height: 20),
                SizedBox(width: 8),
                Icon(Icons.info_outline, color: Colors.grey[600], size: 20),
              ],
            ),
            const SizedBox(height: 40),

            // 제목 (기회)
            _buildGradientContainer(width: 80, height: 40),
            const SizedBox(height: 30),

            // 별표 영역 (그라데이션 처리)
            _buildGradientContainer(width: 120, height: 120, radius: 60),
            const SizedBox(height: 30),

            // 설명 텍스트
            _buildGradientContainer(width: 280, height: 24),
            const SizedBox(height: 16),

            // 업데이트 시간 영역
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildGradientContainer(width: 180, height: 16),
                SizedBox(width: 8),
                Icon(Icons.refresh, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 30),

            // ChartStat 영역
            Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey.withOpacity(0.05),
                    Colors.grey.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 16),

            // PastStat 영역
            Container(
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey.withOpacity(0.05),
                    Colors.grey.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 그라데이션 컨테이너 생성 함수
  Widget _buildGradientContainer({
    required double width,
    required double height,
    double radius = 4,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.2),
      highlightColor: Colors.grey.withOpacity(0.1),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.withOpacity(0.05),
              Colors.grey.withOpacity(0.15),
            ],
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}