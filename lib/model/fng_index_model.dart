import 'package:isar/isar.dart';

part 'fng_index_model.g.dart';

enum Rating {
  extremeGreed,
  greed,
  neutral,
  fear,
  extremeFear;

  static Rating RatingFromString(String input) {
    switch (input) {
      case 'extreme greed':
        return Rating.extremeGreed;
      case 'greed':
        return Rating.greed;
      case 'neutral':
        return Rating.neutral;
      case 'fear':
        return Rating.fear;
      case 'extreme fear':
        return Rating.extremeFear;
      default:
        throw Exception('상태가 존재하지 않아요');
    }
  }

  String get krName {
    switch (this) {
      case Rating.extremeGreed:
        return '극심한 탐욕';
      case Rating.greed:
        return '탐욕';
      case Rating.neutral:
        return '중립';
      case Rating.fear:
        return '공포';
      case Rating.extremeFear:
        return '절호의 기회';
      default:
        throw Exception('상태가 존재하지 않아요');
    }
  }
}

@collection
class FngIndexModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late DateTime dateTime;
  late double index;
  @enumerated
  late Rating rating;
  //나중에 Status랑 리팩토링 필요

}
