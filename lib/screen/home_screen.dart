import 'package:buy_or_bye/component/chart_stat.dart';
import 'package:buy_or_bye/component/main_stat.dart';
import 'package:buy_or_bye/component/past_stat.dart';
import 'package:buy_or_bye/model/fng_index_model.dart';
import 'package:buy_or_bye/repository/fng_index_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:buy_or_bye/const/styles.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // 추가
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
  late Future<List<dynamic>> _futureData;
  static const int chart_days = 365;
  final Rating recentRating = Rating.extremeFear;

  @override
  void initState() {
    FngIndexRepository.fetchData();
    super.initState();
    _loadData();
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

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // 추가

    return Scaffold(
      backgroundColor: Colors.black,
      // 🧪 테스트용 FloatingActionButton 추가
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "language_test",
            mini: true,
            backgroundColor: Colors.blue,
            onPressed: () {
              _showLanguageTestDialog(context, localizations);
            },
            child: const Icon(Icons.language, color: Colors.white),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: "current_language",
            mini: true,
            backgroundColor: Colors.green,
            onPressed: () {
              _showLanguageInfo(context, localizations);
            },
            child: Text(
              Localizations.localeOf(context).languageCode.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: _futureData,
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildSkeletonUI();  // Skeleton UI 표시
            }
            if (snapshot.hasError) {
              return _buildErrorUI(snapshot.error.toString(), localizations);  // 다국어 적용
            }
            if (!snapshot.hasData || snapshot.data!.length < 2) {
              return Center(
                child: Text(
                  localizations.errorNoData, // 다국어 적용
                  style: const TextStyle(color: Colors.white),
                ),
              );
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
              return _buildErrorUI(
                "데이터를 불러오는 중 오류가 발생했습니다.",
                localizations,
              );
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
                          child: ChartStat(
                            chartData: chartData,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
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

  Widget _buildErrorUI(String errorMessage, AppLocalizations localizations) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            localizations.errorMessage(errorMessage), // 다국어 적용
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadData,
            child: Text(localizations.errorRetry), // 다국어 적용
          ),
        ],
      ),
    );
  }

  // 🧪 언어 테스트 다이얼로그
  void _showLanguageTestDialog(BuildContext context, AppLocalizations localizations) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          '🌐 Language Test',
          style: TextStyle(color: Colors.white),
        ),
        content: Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection('📊 Ratings', [
                  _buildTestItem('Extreme Fear', localizations.ratingExtremeFear, Colors.blue),
                  _buildTestItem('Fear', localizations.ratingFear, Colors.green),
                  _buildTestItem('Neutral', localizations.ratingNeutral, Colors.grey),
                  _buildTestItem('Greed', localizations.ratingGreed, Colors.orange),
                  _buildTestItem('Extreme Greed', localizations.ratingExtremeGreed, Colors.red),
                ]),
                const SizedBox(height: 16),
                _buildSection('💬 Comments', [
                  _buildTestItem('Extreme Fear', localizations.commentExtremeFear.replaceAll('\n', ' '), Colors.blue),
                  _buildTestItem('Fear', localizations.commentFear.replaceAll('\n', ' '), Colors.green),
                  _buildTestItem('Neutral', localizations.commentNeutral.replaceAll('\n', ' '), Colors.grey),
                ]),
                const SizedBox(height: 16),
                _buildSection('🎯 UI Elements', [
                  _buildTestItem('Greed Index', localizations.titleGreedIndex, Colors.purple),
                  _buildTestItem('Fear & Greed Index', localizations.titleFearGreedIndex, Colors.purple),
                  _buildTestItem('Recent', localizations.labelRecent, Colors.cyan),
                  _buildTestItem('Refresh', localizations.refresh, Colors.cyan),
                ]),
                const SizedBox(height: 16),
                _buildSection('📅 Months', [
                  _buildTestItem('Jan-Mar', '${localizations.month1}, ${localizations.month2}, ${localizations.month3}', Colors.pink),
                  _buildTestItem('Oct-Dec', '${localizations.month10}, ${localizations.month11}, ${localizations.month12}', Colors.pink),
                ]),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...items,
      ],
    );
  }

  Widget _buildTestItem(String key, String value, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  key,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🌍 현재 언어 정보 표시
  void _showLanguageInfo(BuildContext context, AppLocalizations localizations) {
    final currentLocale = Localizations.localeOf(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🌐 Current Language: ${currentLocale.languageCode.toUpperCase()}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('${localizations.titleGreedIndex}: Greed Index'),
            Text('${localizations.ratingExtremeFear}: Best Chance'),
            Text('${localizations.labelRecent}: Recent'),
          ],
        ),
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.green[700],
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}