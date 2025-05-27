import 'package:buy_or_bye/model/fng_index_model.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:buy_or_bye/utils/date_utils.dart';
import 'package:buy_or_bye/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // 다국어 지원

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
    final localizations = AppLocalizations.of(context)!; // 다국어 지원

    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitle(localizations),
            _buildListContainer(pastData, localizations),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(AppLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        '${localizations.labelRecent} ${_getLocalizedRatingName(localizations)}', // 다국어 적용
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  // Rating에 따른 다국어 이름 반환
  String _getLocalizedRatingName(AppLocalizations localizations) {
    switch (recentRating) {
      case Rating.extremeGreed:
        return localizations.ratingExtremeGreed;
      case Rating.greed:
        return localizations.ratingGreed;
      case Rating.neutral:
        return localizations.ratingNeutral;
      case Rating.fear:
        return localizations.ratingFear;
      case Rating.extremeFear:
        return localizations.ratingExtremeFear;
    }
  }

  Widget _buildListContainer(List<FngIndexModel> fngIndexModels, AppLocalizations localizations) {
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
                    Text(
                      localizations.titleGreedIndex, // 다국어 적용
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 14, color: darkGrey),
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