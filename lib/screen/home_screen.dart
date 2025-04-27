import 'package:buy_or_bye/component/chart_stat.dart';
import 'package:buy_or_bye/component/main_stat.dart';
import 'package:buy_or_bye/component/past_stat.dart';
import 'package:buy_or_bye/const/styles.dart';
import 'package:buy_or_bye/model/fng_index_model.dart';
import 'package:buy_or_bye/repository/fng_index_repository.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import '../utils/status_utils.dart';
import '../component/common/loading/loading_skeleton.dart';

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
  static const int CHART_DAYS = 365;
  static const Rating RECENT_RATING = Rating.extremeFear;

  Future<List<dynamic>>? _futureData;
  bool _isUpdating = false;
  bool _updateCompleted = false;

  @override
  void initState() {
    super.initState();

    // 즉시 로컬 데이터 로드
    //_loadData();

    // 백그라운드에서 데이터 업데이트
    _updateData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 메인 콘텐츠
          _futureData == null
              ? _buildSkeletonUI()
              : FutureBuilder(
            future: _futureData,
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (_shouldShowLoading(snapshot)) {
                return _buildSkeletonUI();
              }
              if (_shouldShowError(snapshot)) {
                return _buildErrorUI(snapshot.error.toString());
              }
              if (_shouldShowEmptyState(snapshot)) {
                return const Center(child: Text('데이터가 없습니다.'));
              }

              final metadata = snapshot.data![0];
              final chartData = snapshot.data![1] as List<FngIndexModel>;
              final fngIndexModel = chartData.isNotEmpty ? chartData[0] : null;

              // 특정 Rating으로 필터링된 데이터
              final pastData = StatusUtils.filterByRating(
                initialList: chartData,
                rating: RECENT_RATING,
              );

              if (fngIndexModel == null || metadata == null) {
                return _buildErrorUI("데이터를 불러오는 중 오류가 발생했습니다.");
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppStyles.padding),
                  child: Column(
                    children: [
                      MainStat(
                          fngIndexModel: fngIndexModel,
                          metadata: metadata,
                          onRefresh: _updateData  // 새로고침 함수 변경
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return SizedBox(
                            width: constraints.maxWidth,
                            height: 300,
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
                        recentRating: RECENT_RATING,
                        pastData: pastData,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // 업데이트 완료 메시지
          if (_updateCompleted)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        '이미 데이터가 업데이트 됐어요',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _updateData() async {
    setState(() {
      _isUpdating = true;
      _updateCompleted = false;
    });

    try {
      await FngIndexRepository.fetchData();

      if (mounted) {
        setState(() {
          _isUpdating = false;
          _updateCompleted = true;
          _loadData(); // 화면 새로고침
        });

        // 잠시 후 완료 메시지 숨기기
        Future.delayed(Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _updateCompleted = false;
            });
          }
        });
      }
    } catch (error) {
      print('API 업데이트 오류: $error');
      if (mounted) {
        setState(() {
          _isUpdating = false;
        });
      }
    }
  }


  Future<List<dynamic>> _fetchData() async {
    final metadata = await GetIt.I<Isar>().metadatas.get(0);
    final indexAll = await GetIt.I<Isar>()
        .fngIndexModels
        .where()
        .sortByDateTimeDesc()
        .findAll();

    return [metadata, indexAll];
  }

  void _loadData() {
    setState(() {
      _futureData = _fetchData();
    });
  }
  Widget _buildSkeletonUI() {
    return const LoadingSkeleton();
  }

  Widget _buildErrorUI(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '오류 발생: $errorMessage',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: _loadData,
            child: const Text('다시 시도하기'),
          ),
        ],
      ),
    );
  }

  bool _shouldShowLoading(AsyncSnapshot<List<dynamic>> snapshot) {
    return snapshot.connectionState == ConnectionState.waiting;
  }

  bool _shouldShowError(AsyncSnapshot<List<dynamic>> snapshot) {
    return snapshot.hasError;
  }

  bool _shouldShowEmptyState(AsyncSnapshot<List<dynamic>> snapshot) {
    return !snapshot.hasData || snapshot.data!.length < 2;
  }
}
