import 'package:buy_or_bye/model/fng_index_model.dart';
import 'package:buy_or_bye/utils/status_utils.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:buy_or_bye/utils/date_utils.dart';
import 'package:buy_or_bye/const/colors.dart';
import 'package:buy_or_bye/repository/fng_index_repository.dart';
import 'package:buy_or_bye/const/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // 추가

class MainStat extends StatelessWidget {
  final FngIndexModel fngIndexModel;
  final Metadata metadata;
  final VoidCallback onRefresh;

  const MainStat({
    required this.fngIndexModel,
    required this.metadata,
    required this.onRefresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // 추가

    // 다국어 지원 StatusModel 사용
    final chance = StatusUtils.getStatusModelFromRating(
      rating: fngIndexModel.rating,
      localizations: localizations,
    );

    final lastUpdated = metadata.lastUpdated;

    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 50),
          Container(
            height: 30,
            width: 180,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localizations.titleGreedIndex, // 다국어 적용
                  style: AppStyles.subText,
                ),
                const SizedBox(width: 12),
                Text(
                  '${fngIndexModel.index.round().toInt()}/100',
                  style: AppStyles.subText.copyWith(
                    fontWeight: FontWeight.w800,
                    color: chance.statusColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            chance.label, // 이미 다국어가 적용된 label
            style: AppStyles.title.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 36,
            ),
          ),
          Text(
            chance.tempImage,
            style: const TextStyle(fontSize: 140),
          ),
          Text(
            chance.comment, // 이미 다국어가 적용된 comment
            style: AppStyles.title.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localizations.updatedValue( // 다국어 적용
                    DateUtils.formatDateTime(dateTime: lastUpdated),
                  ),
                  style: AppStyles.subText.copyWith(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  onPressed: () {
                    FngIndexRepository.fetchData();
                    onRefresh();
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: AppStyles.subText.color,
                  ),
                  tooltip: localizations.refresh, // 다국어 적용
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}