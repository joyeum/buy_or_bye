// "x": 1707350400000.0,
// "y": 74.60000000000001,
// "rating": "greed"

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

  // static Future fetchDataIndex() async {
  //   final response = await Dio().get(
  //     'https://production.dataviz.cnn.io/index/fearandgreed/graphdata/',
  //     options: Options(
  //       headers: {
  //         'accept':
  //             'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
  //         'accept-encoding': 'gzip, deflate, br, zstd',
  //         'accept-language':
  //             'ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7,de-DE;q=0.6,de;q=0.5',
  //         'cache-control': 'max-age=0',
  //         'if-none-match': 'W/340831405305825791',
  //         'priority': 'u=0, i',
  //         'sec-ch-ua':
  //             '"Chromium";v="130", "Google Chrome";v="130", "Not?A_Brand";v="99"',
  //         'sec-ch-ua-mobile': '?0',
  //         'sec-ch-ua-platform': '"macOS"',
  //         'sec-fetch-dest': 'document',
  //         'sec-fetch-mode': 'navigate',
  //         'sec-fetch-site': 'none',
  //         'sec-fetch-user': '?1',
  //         'upgrade-insecure-requests': '1',
  //         'user-agent':
  //             'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36',
  //       },
  //     ),
  //   );
  //   final isar = GetIt.I<Isar>();
  //
  //   final rawItem = response.data!['fear_and_greed'] as Map<String, dynamic>;
  //   print(rawItem);
  //
  // }

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
    final rawItemList =
        (response.data!['fear_and_greed_historical']['data'] as List)
            .map((item) => item as Map<String, dynamic>)
            .toList();

    List<FngIndexModel> fngIndexModels = [];

// 저장하고 싶은 내용
// {
//     "fear_and_greed": {
//         "score": 66.1428571428571,
//         "rating": "greed",
//         "timestamp": "2024-11-29T23:59:42+00:00",
//         "previous_close": 65.2285714285714,
//         "previous_1_week": 60.7714285714286,
//         "previous_1_month": 57.7142857142857,
//         "previous_1_year": 63.28571428571429
//     },


    // final raw = response.data!['fear_and_greed']  as  Map<String, dynamic>;
    //   print(raw['score']);
    //   print(raw['timestamp']);
    //   print(raw['previous_close']);
    //   print(raw);

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


    //




    final isar = GetIt.I<Isar>();

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

    print('--------------------');
    final count = await isar.fngIndexModels.count();
    print(count);

    return fngIndexModels;
  }
}


