import 'package:flutter/material.dart';
import 'package:buy_or_bye/model/fng_index_model.dart';
import 'package:buy_or_bye/model/status_model.dart';
import 'package:buy_or_bye/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatusUtils {
  // 기존 getStatusModel 메서드 (하드코딩된 값들)
  static StatusModel getStatusModel({required int i}) {
    switch (i) {
      case 0: // extremeGreed
        return const StatusModel(
          level: 0,
          label: "고점 주의", // 하드코딩 유지 (기존 호환성)
          statusColor: Colors.red,
          darkColor: Color(0xFF8B0000),
          lightColor: Color(0xFFFFB3B3),
          fontColor: Colors.white,
          tempImage: "📈",
          comment: "고점 판독기들이 주식을\n사고 계시진 않나요?",
        );
      case 1: // extremeFear
        return const StatusModel(
          level: 1,
          label: "절호의 기회", // 하드코딩 유지 (기존 호환성)
          statusColor: primaryColor,
          darkColor: Color(0xFF001F3F),
          lightColor: Color(0xFFB3D9FF),
          fontColor: Colors.white,
          tempImage: "🎯",
          comment: "절호의 기회에요\n저점을 잡으려면 지금!",
        );
      case 2: // greed
        return const StatusModel(
          level: 2,
          label: "버블",
          statusColor: Colors.orange,
          darkColor: Color(0xFF8B4000),
          lightColor: Color(0xFFFFCC99),
          fontColor: Colors.white,
          tempImage: "💭",
          comment: "높게 평가되었을 수 있지만\n장기투자 관점에서는 괜찮아요",
        );
      case 3: // fear
        return const StatusModel(
          level: 3,
          label: "기회",
          statusColor: Colors.green,
          darkColor: Color(0xFF006400),
          lightColor: Color(0xFFB3FFB3),
          fontColor: Colors.white,
          tempImage: "💰",
          comment: "평소보다 싸게 살 수 있어요\n분할 매수를 고려해보세요",
        );
      case 4: // neutral
        return const StatusModel(
          level: 4,
          label: "중립",
          statusColor: Colors.grey,
          darkColor: Color(0xFF404040),
          lightColor: Color(0xFFD3D3D3),
          fontColor: Colors.white,
          tempImage: "😐",
          comment: "오늘은 심심한 날이네요\n결국 장기 우상향 할 거에요",
        );
      default:
        return getStatusModel(i: 1); // 기본값
    }
  }

  // 새로운 다국어 지원 메서드
  static StatusModel getLocalizedStatusModel({
    required int i,
    required AppLocalizations localizations,
  }) {
    switch (i) {
      case 0: // extremeGreed
        return StatusModel(
          level: 0,
          label: localizations.ratingExtremeGreed,
          statusColor: Colors.red,
          darkColor: const Color(0xFF8B0000),
          lightColor: const Color(0xFFFFB3B3),
          fontColor: Colors.white,
          tempImage: "📈",
          comment: localizations.commentExtremeGreed,
        );
      case 1: // extremeFear
        return StatusModel(
          level: 1,
          label: localizations.ratingExtremeFear,
          statusColor: primaryColor,
          darkColor: const Color(0xFF001F3F),
          lightColor: const Color(0xFFB3D9FF),
          fontColor: Colors.white,
          tempImage: "🎯",
          comment: localizations.commentExtremeFear,
        );
      case 2: // greed
        return StatusModel(
          level: 2,
          label: localizations.ratingGreed,
          statusColor: Colors.orange,
          darkColor: const Color(0xFF8B4000),
          lightColor: const Color(0xFFFFCC99),
          fontColor: Colors.white,
          tempImage: "💭",
          comment: localizations.commentGreed,
        );
      case 3: // fear
        return StatusModel(
          level: 3,
          label: localizations.ratingFear,
          statusColor: Colors.green,
          darkColor: const Color(0xFF006400),
          lightColor: const Color(0xFFB3FFB3),
          fontColor: Colors.white,
          tempImage: "💰",
          comment: localizations.commentFear,
        );
      case 4: // neutral
        return StatusModel(
          level: 4,
          label: localizations.ratingNeutral,
          statusColor: Colors.grey,
          darkColor: const Color(0xFF404040),
          lightColor: const Color(0xFFD3D3D3),
          fontColor: Colors.white,
          tempImage: "😐",
          comment: localizations.commentNeutral,
        );
      default:
        return getLocalizedStatusModel(i: 1, localizations: localizations);
    }
  }

  // Rating enum에서 StatusModel로 변환 (다국어 지원)
  static StatusModel getStatusModelFromRating({
    required Rating rating,
    required AppLocalizations localizations,
  }) {
    switch (rating) {
      case Rating.extremeGreed:
        return getLocalizedStatusModel(i: 0, localizations: localizations);
      case Rating.greed:
        return getLocalizedStatusModel(i: 2, localizations: localizations);
      case Rating.neutral:
        return getLocalizedStatusModel(i: 4, localizations: localizations);
      case Rating.fear:
        return getLocalizedStatusModel(i: 3, localizations: localizations);
      case Rating.extremeFear:
        return getLocalizedStatusModel(i: 1, localizations: localizations);
    }
  }

  // 기존 FngIndexModel에서 StatusModel로 변환하는 메서드 (기존 호환성)
  static StatusModel getStatusModelFromFngIndex({required FngIndexModel fngIndex}) {
    return getStatusModelFromFngIndexByRating(rating: fngIndex.rating);
  }

  static StatusModel getStatusModelFromFngIndexByRating({required Rating rating}) {
    switch (rating) {
      case Rating.extremeGreed:
        return getStatusModel(i: 0);
      case Rating.greed:
        return getStatusModel(i: 2);
      case Rating.neutral:
        return getStatusModel(i: 4);
      case Rating.fear:
        return getStatusModel(i: 3);
      case Rating.extremeFear:
        return getStatusModel(i: 1);
    }
  }

  // Rating으로 필터링하는 메서드
  static List<FngIndexModel> filterByRating({
    required List<FngIndexModel> initialList,
    required Rating rating,
  }) {
    return initialList.where((model) => model.rating == rating).toList();
  }
}