import 'package:buy_or_bye/component/chart_stat.dart';
import 'package:buy_or_bye/component/main_stat.dart';
import 'package:buy_or_bye/component/past_stat.dart';
import 'package:buy_or_bye/model/fng_index_model.dart';
import 'package:buy_or_bye/repository/fng_index_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:flutter/material.dart' hide DateUtils;

import '../utils/status_utils.dart';
import '../utils/date_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    FngIndexRepository.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GetIt.I<Isar>()
            .fngIndexModels
            .where()
            .sortByDateTimeDesc()
            .findFirst(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData) {
            return Container(
              child: CircularProgressIndicator(),
            );
          }
          final fngIndexModel = snapshot.data!;
          final chance =
              StatusUtils.getStatusModelFromFngIndex(fngIndex: fngIndexModel);
          return Scaffold(
            backgroundColor: chance.primaryColor,
            body: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MainStat(
                      fngIndexModel: fngIndexModel,
                      fontColor: chance.fontColor,
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SizedBox(
                            width: constraints.maxWidth,
                            height: 300, // 명시적인 높이 설정
                            child: ChartStat(
                              darkColor: chance.darkColor,
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    PastStat(
                      darkColor: chance.darkColor,
                      lightColor: chance.lightColor,
                      fontColor: chance.fontColor,
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                        right: 20,
                        left: 20,
                        top: 4,
                      ),
                      child: FutureBuilder(
                        future: GetIt.I<Isar>()
                            .metadatas.get(0),
                        builder: (context, snapshot) {
                          if (snapshot.hasError){
                            return Center(child: Text(snapshot.error.toString()));
                          }
                          if (!snapshot.hasData) {
                            return Container(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final metadata = snapshot.data!;
                          final lastUpdated = metadata.lastUpdated;

                          return Container(
                            width: double.infinity,
                            child: Text(
                              '${DateUtils.formatDateTime(dateTime:lastUpdated)} 업데이트 됨',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
