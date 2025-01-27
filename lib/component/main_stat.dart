import 'package:buy_or_bye/model/fng_index_model.dart';
import 'package:buy_or_bye/utils/status_utils.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:buy_or_bye/utils/date_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:buy_or_bye/const/colors.dart';
import 'package:buy_or_bye/repository/fng_index_repository.dart';

class MainStat extends StatelessWidget {
  final Color statusFontColor = Colors.white;
  final Color introFontColor = lightGrey;
  final Color subFontColor = darkGrey;

  const MainStat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle ts_sub = TextStyle(
      color: subFontColor,
      fontSize: 16,
    );
    TextStyle ts_main = TextStyle(
      color: introFontColor,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );

    return SafeArea(
      child: FutureBuilder(
        future: Future.wait([
          GetIt.I<Isar>()
              .fngIndexModels
              .where()
              .sortByDateTimeDesc()
              .findFirst(),
          GetIt.I<Isar>().metadatas.get(0),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final fngIndexModel = snapshot.data![0] as FngIndexModel?;
          final metadata = snapshot.data![1];

          if (fngIndexModel == null || metadata == null) {
            return Center(child: Text("데이터를 불러오는 중 오류가 발생했습니다."));
          }

          final chance =
              StatusUtils.getStatusModelFromFngIndex(fngIndex: fngIndexModel);
          final lastUpdated = metadata.lastUpdated;

          return Column(
            children: [
              SizedBox(height: 50),
              Container(
                height: 30,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '탐욕 지수',
                      style: ts_sub,
                    ),
                    SizedBox(width: 12),
                    Text(
                      '${fngIndexModel.index.round().toInt()}/100',
                      style: ts_sub.copyWith(
                        fontWeight: FontWeight.w800,
                        color: chance.statusColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                chance.label,
                style: ts_main.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 36,
                  color: statusFontColor,
                ),
              ),
              Text(
                chance.tempImage,
                style: TextStyle(fontSize: 140),
              ),
              Text(
                chance.comment,
                style: ts_main.copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${DateUtils.formatDateTime(dateTime: lastUpdated)} 업데이트 됨',
                      style: ts_sub.copyWith(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      onPressed: () {
                        FngIndexRepository.fetchData();
                      },
                      icon: Icon(
                        Icons.refresh,
                        color: subFontColor,
                      ),
                      tooltip: '새로고침',
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
