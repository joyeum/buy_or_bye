import 'package:buy_or_bye/component/chart_stat.dart';
import 'package:buy_or_bye/component/main_stat.dart';
import 'package:buy_or_bye/component/past_stat.dart';
import 'package:buy_or_bye/model/fng_index_model.dart';
import 'package:buy_or_bye/repository/fng_index_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:buy_or_bye/const/styles.dart';

class HomeScreen extends StatefulWidget {
  static const TextStyle tsTitle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w900,
  );

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    FngIndexRepository.fetchData();
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _futureData = Future.wait([
        GetIt.I<Isar>().fngIndexModels.where().sortByDateTimeDesc().findFirst(),
        GetIt.I<Isar>().metadatas.get(0),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
          future: _futureData,
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

            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppStyles.padding),
                child: Column(
                  children: [
                    MainStat(
                        fngIndexModel: fngIndexModel,
                        metadata: metadata,
                        onRefresh: _loadData),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          width: constraints.maxWidth,
                          height: 300, // 명시적인 높이 설정
                          child: ChartStat(),
                        );
                      },
                    ),
                    SizedBox(
                      height: AppStyles.padding,
                    ),
                    PastStat(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
