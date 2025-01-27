import 'package:buy_or_bye/const/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import '../model/fng_index_model.dart';

class ChartStat extends StatelessWidget {
  final Color darkColor;

  ChartStat({required this.darkColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '탐욕 지수',
                style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,)
            ),
          ),
          SizedBox(
            height: 300,
            child: FutureBuilder<List<FngIndexModel>>(
              future: _fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError || snapshot.data?.isEmpty == true) {
                  return Center(child: Text('No data'));
                }
                return LineChart(_buildChart(
                  snapshot.data!,
                ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<FngIndexModel>> _fetchData() async {
    return GetIt.I<Isar>()
        .fngIndexModels
        .where()
        .sortByDateTimeDesc()
        .findAll();
  }

  LineChartData _buildChart(List<FngIndexModel> data) {
    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: data
              .map((e) => FlSpot(e.dateTime.millisecondsSinceEpoch.toDouble(),
                  e.index.toDouble()))
              .toList(),
          color: darkColor,
          barWidth: 2,
        )
      ],
      titlesData: FlTitlesData(
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false, // 상단 라벨 숨김
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false, // 상단 라벨 숨김
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: _calculateDynamicInterval(data), // 동적 간격 설정
            getTitlesWidget: (value, meta) {
              return Text(
                _formatMonth(value),
              );
            },
          ),
        ),
      ),
      minY: 0,
      maxY: 100,
    );
  }

  double _calculateDynamicInterval(List<FngIndexModel> data) {
    if (data.isEmpty) return 30 * 24 * 60 * 60 * 1000; // 기본값: 약 1달
    final start = data.last.dateTime.millisecondsSinceEpoch.toDouble();
    final end = data.first.dateTime.millisecondsSinceEpoch.toDouble();
    final range = end - start;
    return range / 6; // 약 12개의 라벨을 기준으로 간격 계산
  }

  String _formatMonth(double value) {
    final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    final month = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ][date.month - 1];
    return '$month'; // 필요하면 '$month ${date.year}'로 연도 추가
  }
}
