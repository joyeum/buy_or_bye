import 'package:buy_or_bye/const/chance_level.dart';
import 'package:buy_or_bye/model/chance_model.dart';
import 'package:buy_or_bye/model/fng_index_model.dart';
import 'package:buy_or_bye/utils/date_utils.dart';

class ChanceUtils {
  static ChanceModel getChanceModelFromFngIndex({
    required FngIndexModel fngIndex,
  }) {
    if (fngIndex.index >= 0 && fngIndex.index <= 100) {
      int index = (fngIndex.index / 20).floor();
      return chanceLevels[index];
    } else {
      throw Exception('통계 값 오류입니다');
    }
    //   return fngIndex;
  }

  static List<FngIndexModel> uniqueDate({
    required List<FngIndexModel> initialList,
  }) {
    Map<String, FngIndexModel> uniqueMap = {};

    for (FngIndexModel item in initialList) {
      String date = DateUtils.DateTimeToString(dateTime: item.dateTime);
      // print(date);

      // 해당 날짜에 저장된 값보다 더 큰 index 값을 가진 경우 갱신
      if (!uniqueMap.containsKey(date) ||
          item.index > uniqueMap[date]!.index) {
        uniqueMap[date] = item;
      }
    }

    // map의 values를 uniqueList로 변환하여 반환
    return uniqueMap.values.toList();
  }
}
