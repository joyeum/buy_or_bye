import 'package:buy_or_bye/component/chart_stat.dart';
import 'package:buy_or_bye/component/main_stat.dart';
import 'package:buy_or_bye/component/past_stat.dart';
import 'package:buy_or_bye/const/styles.dart';
import 'package:buy_or_bye/model/fng_index_model.dart';
import 'package:buy_or_bye/repository/fng_index_repository.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/status_utils.dart';

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
  Future<List<dynamic>>? _futureData;
  static const int chart_days = 365;
  final Rating recentRating = Rating.extremeFear;
// 1. fetchData : save
// 2. _loadData : save

  @override
  void initState() {
    super.initState();
    FngIndexRepository.fetchData().then(
      (value) => _loadData(),
    );
  }

  Future<List<dynamic>> _fetchData() async {
    final metadata = await GetIt.I<Isar>().metadatas.get(0);
    final indexAll = await GetIt.I<Isar>().fngIndexModels.where().sortByDateTimeDesc().findAll();

    return [metadata, indexAll];
  }

  void _loadData() {
    setState(() {
      _futureData = _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _futureData == null
          ? _buildSkeletonUI()
          : FutureBuilder(
              future: _futureData,
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildSkeletonUI(); // Skeleton UI 표시
                }
                if (snapshot.hasError) {
                  return _buildErrorUI(snapshot.error.toString()); // 리프레시 버튼 제공
                }
                if (!snapshot.hasData || snapshot.data!.length < 2) {
                  return Center(child: Text('데이터가 없습니다.'));
                }

                final metadata = snapshot.data![0];
                final chartData = snapshot.data![1] as List<FngIndexModel>;
                final fngIndexModel = chartData.isNotEmpty ? chartData[0] : null;

                // 특정 Rating으로 필터링된 데이터
                final pastData = StatusUtils.filterByRating(
                  initialList: chartData,
                  rating: recentRating,
                );

                if (fngIndexModel == null || metadata == null) {
                  print('errorr!!! $fngIndexModel $metadata');

                  return _buildErrorUI("데이터를 불러오는 중 오류가 발생했습니다.");
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppStyles.padding),
                    child: Column(
                      children: [
                        MainStat(fngIndexModel: fngIndexModel, metadata: metadata, onRefresh: _loadData),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return SizedBox(
                              width: constraints.maxWidth,
                              height: 300, // 명시적인 높이 설정
                              child: ChartStat(
                                chartData: chartData,
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: AppStyles.padding,
                        ),
                        PastStat(
                          recentRating: recentRating,
                          pastData: pastData,
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }

  Widget _buildSkeletonUI() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: Column(
          children: List.generate(3, (index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[700]!,
              highlightColor: Colors.grey[500]!,
              child: Container(
                height: 100,
                margin: const EdgeInsets.only(bottom: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildErrorUI(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '오류 발생: $errorMessage',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadData,
            child: Text('다시 시도하기'),
          ),
        ],
      ),
    );
  }
}
