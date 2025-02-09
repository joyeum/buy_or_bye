import 'package:buy_or_bye/model/fng_index_model.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:buy_or_bye/utils/date_utils.dart';
import 'package:buy_or_bye/const/colors.dart';

class PastStat extends StatelessWidget {
  static const double padding = 24;
  final Rating recentRating;
  final List<FngIndexModel> pastData;

  const PastStat({
    required this.recentRating,
    required this.pastData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitle(),
            _buildListContainer(pastData), // ✅ 좌우 패딩 제거
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        '최근 ${recentRating.krName}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _buildListContainer(List<FngIndexModel> fngIndexModels) {
    return Column(
      children: fngIndexModels.expand((fngIndexModel) {
        return [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Text(
                  DateUtils.DateTimeToString(dateTime: fngIndexModel.dateTime),
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      '탐욕 지수',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14, color: darkGrey),
                    ),
                    Text(
                      '${fngIndexModel.index.round()} / 100',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: darkerGrey, thickness: 0.5),
        ];
      }).toList()
        ..removeLast(), // 마지막 줄의 구분선 제거
    );
  }
}
