import 'package:buy_or_bye/model/fng_index_model.dart';
import 'package:buy_or_bye/utils/status_utils.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:buy_or_bye/utils/date_utils.dart';
import 'package:buy_or_bye/const/colors.dart';
import 'package:buy_or_bye/repository/fng_index_repository.dart';
import 'package:buy_or_bye/const/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final localizations = AppLocalizations.of(context)!;

    // 다국어 지원 StatusModel 사용
    final chance = StatusUtils.getStatusModelFromRating(
      rating: fngIndexModel.rating,
      localizations: localizations,
    );

    final lastUpdated = metadata.lastUpdated;

    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 30), // 50 → 30으로 줄임
          Container(
            height: 30,
            width: 200, // 180 → 200으로 넓힘 (아이콘 공간 확보)
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localizations.titleGreedIndex,
                  style: AppStyles.subText,
                ),
                const SizedBox(width: 8), // 12 → 8로 줄임
                Text(
                  '${fngIndexModel.index.round().toInt()}/100',
                  style: AppStyles.subText.copyWith(
                    fontWeight: FontWeight.w800,
                    color: chance.statusColor,
                  ),
                ),
                const SizedBox(width: 4), // 아이콘과 텍스트 사이 간격 추가
                // 정보 아이콘 추가
                IconButton(
                  icon: Icon(Icons.info_outline, color: AppStyles.subText.color, size: 16), // 18 → 16으로 줄임
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 24, minHeight: 24), // 최소 크기 설정
                  onPressed: () => _showInfoDialog(context, localizations),
                  tooltip: localizations.tooltipGreedInfo,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16), // 20 → 16으로 줄임
          Text(
            chance.label,
            style: AppStyles.title.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 36,
            ),
          ),
          const SizedBox(height: 8), // 이모지와 제목 사이 간격 추가
          Text(
            chance.tempImage,
            style: const TextStyle(fontSize: 120), // 140 → 120으로 줄임
          ),
          const SizedBox(height: 8), // 이모지와 코멘트 사이 간격 추가
          Text(
            chance.comment,
            style: AppStyles.title.copyWith(fontSize: 22), // 24 → 22로 줄임
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12), // 코멘트와 업데이트 정보 사이 간격 추가
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), // 20 → 16으로 줄임
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localizations.updatedValue(
                    DateUtils.formatDateTime(dateTime: lastUpdated),
                  ),
                  style: AppStyles.subText.copyWith(fontSize: 11), // 12 → 11로 줄임
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
                    size: 16, // 아이콘 크기 명시
                  ),
                  tooltip: localizations.refresh,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 팝업 다이얼로그 메서드 (완전 다국어 적용)
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
                  Expanded(
                    child: Text(
                      localizations.dialogCalculationTitle,
                      style: AppStyles.title,
                      overflow: TextOverflow.ellipsis,
                    ),
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
                localizations.dialogCalculationDesc,
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
                    child: Text(localizations.dialogConfirm),
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