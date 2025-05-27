import 'package:buy_or_bye/model/fng_index_model.dart';
import 'package:buy_or_bye/utils/status_utils.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:buy_or_bye/utils/date_utils.dart';
import 'package:buy_or_bye/const/colors.dart';
import 'package:buy_or_bye/repository/fng_index_repository.dart';
import 'package:buy_or_bye/const/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // 다국어 지원

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
    final localizations = AppLocalizations.of(context)!; // 다국어 지원

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
                // 정보 아이콘 추가 (origin에서 가져온 기능)
                IconButton(
                  icon: Icon(Icons.info_outline, color: AppStyles.subText.color, size: 18),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => _showInfoDialog(context, localizations), // 다국어 지원
                  tooltip: localizations.refresh, // 다국어 적용
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

  // 팝업 다이얼로그 메서드 (origin에서 가져온 기능 + 다국어 지원)
  void _showInfoDialog(BuildContext context, AppLocalizations localizations) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: backgroundDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(AppStyles.padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '어떻게 계산했나요?', // TODO: 다국어 적용 필요
                    style: AppStyles.title,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'CNN에서 발간한 공포탐욕지수를 기반으로 계산해요. 사람들이 공포에 질릴 때를 노려보세요', // TODO: 다국어 적용 필요
                style: AppStyles.baseText.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 24),
              // 버튼 우측 정렬
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    child: const Text('확인'), // TODO: 다국어 적용 필요
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: infoBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}