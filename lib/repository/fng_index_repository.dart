import 'package:buy_or_bye/model/fng_index_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class FngIndexRepository {
  static Future<void> fetchData() async {
    final now = DateTime.now();
    final compareDateTime = now.subtract(Duration(days: 2));
    //.subtract(Duration(hours: 13)) - ET 시간으로 변환법

    final isar = GetIt.I<Isar>();
    final isUpdated = await isar.fngIndexModels
        .filter()
        .dateTimeGreaterThan(compareDateTime)
        .sortByDateTimeDesc()
        .count();
    print('데이터 불러오는 중');
    await fetchDataDaily();
    if (isUpdated > 0) {
      print('데이터가 존재합니다');
      return;
    }
  }

  static Future<List<FngIndexModel>> fetchDataDaily() async {
    final response = await Dio().get(
      'https://production.dataviz.cnn.io/index/fearandgreed/graphdata/',
      options: Options(
        headers: {
          'accept':
              'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
          'accept-encoding': 'gzip, deflate, br, zstd',
          'accept-language':
              'ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7,de-DE;q=0.6,de;q=0.5',
          'cache-control': 'max-age=0',
          'if-none-match': 'W/340831405305825791',
          'priority': 'u=0, i',
          'sec-ch-ua':
              '"Chromium";v="130", "Google Chrome";v="130", "Not?A_Brand";v="99"',
          'sec-ch-ua-mobile': '?0',
          'sec-ch-ua-platform': '"macOS"',
          'sec-fetch-dest': 'document',
          'sec-fetch-mode': 'navigate',
          'sec-fetch-site': 'none',
          'sec-fetch-user': '?1',
          'upgrade-insecure-requests': '1',
          'user-agent':
              'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36',
        },
      ),
    );
    final isar = GetIt.I<Isar>();

    final rawMetadata =
        response.data!['fear_and_greed'] as Map<String, dynamic>;
    //
    final metadata = Metadata()
      ..lastUpdated = rawMetadata['timestamp']
      ..index = rawMetadata['score']
      ..index_previous_close = rawMetadata['previous_close']
      ..index_previous_1_week = rawMetadata['previous_1_week']
      ..index_previous_1_month = rawMetadata['previous_1_month']
      ..index_previous_1_year = rawMetadata['previous_1_year']
      ..rating = rawMetadata['rating'];

    await isar.writeTxn(() async {
      await isar.metadatas.put(metadata);
    });

    final rawItemList =
        (response.data!['fear_and_greed_historical']['data'] as List)
            .map((item) => item as Map<String, dynamic>)
            .toList();

    List<FngIndexModel> fngIndexModels = [];

    for (dynamic item in rawItemList) {
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(item['x'].toInt());
      Rating rating = Rating.RatingFromString(item['rating']);
      double index = item['y'].toDouble();

      final count =
          await isar.fngIndexModels.filter().dateTimeEqualTo(dateTime).count();

      if (count > 0) {
        continue;
      }

      final fngIndexModel = FngIndexModel()
        ..dateTime = dateTime
        ..index = index
        ..rating = rating;

      await isar.writeTxn(() async {
        await isar.fngIndexModels.put(fngIndexModel);
      });
    }

    final snpItemList =
        (response.data!['market_momentum_sp500']['data'] as List)
            .map((item) => item as Map<String, dynamic>)
            .toList();
    print(snpItemList);

    final snpAvgItemList =
        (response.data!['market_momentum_sp125']['data'] as List)
            .map((item) => item as Map<String, dynamic>)
            .toList();
    print(snpAvgItemList);

    print('--------------------');
    final count = await isar.fngIndexModels.count();
    print(count);

    return fngIndexModels;
  }
}
