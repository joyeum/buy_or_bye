import 'package:buy_or_bye/model/fng_index_model.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:buy_or_bye/utils/date_utils.dart';
import 'package:buy_or_bye/utils/status_utils.dart';
import 'package:buy_or_bye/const/colors.dart';

class PastStat extends StatelessWidget {
  static const double padding = 24;
  final Rating recentRating = Rating.extremeFear;

  const PastStat({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FngIndexModel>>(
      future: _getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || snapshot.data?.isEmpty == true) {
          return const Center(child: Text('데이터 없음', style: TextStyle(color: Colors.white)));
        }

        final fngIndexModels = StatusUtils.uniqueDate(initialList: snapshot.data!);

        return Card(
          color: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Padding(
            padding: const EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTitle(),
                _buildListContainer(fngIndexModels), // ✅ 좌우 패딩 제거
              ],
            ),
          ),
        );
      },
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
      }).toList()..removeLast(), // 마지막 줄의 구분선 제거
    );
  }

  Future<List<FngIndexModel>> _getData() async {
    return GetIt.I<Isar>()
        .fngIndexModels
        .filter()
        .ratingEqualTo(recentRating)
        .sortByDateTimeDesc()
        .findAll();
  }
}
