import 'package:buy_or_bye/const/styles.dart';
import 'package:buy_or_bye/const/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../model/fng_index_model.dart';

class ChartStat extends StatelessWidget {
  static const double padding = 24;
  static const int days = 365;
  final List<FngIndexModel> chartData;

  ChartStat({required this.chartData, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          children: [
            _buildTitle(),
            _buildChartContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 16),
      child:
          Text('공포 탐욕 지수', style: AppStyles.title, textAlign: TextAlign.left),
    );
  }

  Widget _buildChartContainer() {
    return Expanded(
      child: LineChart(
        _buildChart(chartData),
      ),
    );
  }


  LineChartData _buildChart(List<FngIndexModel> data) {
    return LineChartData(
      lineBarsData: [_buildLineChartBarData(data)],
      gridData: _buildGridData(),
      titlesData: _buildTitlesData(data),
      borderData: FlBorderData(
        border: const Border(
          bottom: BorderSide(color: darkerGrey, width: 1),
        ),
      ),
      minY: 0,
      maxY: 100,
    );
  }

  LineChartBarData _buildLineChartBarData(List<FngIndexModel> data) {
    return LineChartBarData(
      spots: data
          .map((e) => FlSpot(
                e.dateTime.millisecondsSinceEpoch.toDouble(),
                e.index.toDouble(),
              ))
          .toList(),
      color: primaryColor,
      barWidth: 2,
      dotData: const FlDotData(show: false),
    );
  }

  FlGridData _buildGridData() {
    return FlGridData(
      show: true,
      drawHorizontalLine: true,
      horizontalInterval: 25,
      getDrawingHorizontalLine: (indexValue) {
        if (indexValue == 50) {
          return FlLine(
            color: darkerGrey,
            strokeWidth: 0.5,
            dashArray: [4, 4],
          );
        }
        return FlLine(color: Colors.transparent);
      },
      drawVerticalLine: false,
    );
  }

  FlTitlesData _buildTitlesData(List<FngIndexModel> data) {
    return FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: _buildBottomTitles(data),
      leftTitles: _buildLeftTitles(),
    );
  }

  AxisTitles _buildBottomTitles(List<FngIndexModel> data) {
    final minX = data.isNotEmpty
        ? data.last.dateTime.millisecondsSinceEpoch.toDouble()
        : 0;
    final maxX = data.isNotEmpty
        ? data.first.dateTime.millisecondsSinceEpoch.toDouble()
        : 1;

    return AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: _calculateDynamicInterval(data),
        getTitlesWidget: (timestamp, meta) {
          if (timestamp == minX || timestamp == maxX) {
            return const SizedBox.shrink();
          }
          return Text(_formatMonth(timestamp),
              style: AppStyles.subText.copyWith(fontSize: 10));
        },
      ),
    );
  }

  AxisTitles _buildLeftTitles() {
    return AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: 25,
        reservedSize: 30,
        getTitlesWidget: (indexValue, meta) {
          return SideTitleWidget(
            axisSide: meta.axisSide,
            child: Text(
              indexValue.toInt().toString(),
              style: AppStyles.subText.copyWith(fontSize: 10),
              textAlign: TextAlign.right,
            ),
          );
        },
      ),
    );
  }

  double _calculateDynamicInterval(List<FngIndexModel> data) {
    if (data.isEmpty) return 30 * 24 * 60 * 60 * 1000;

    final start = data.last.dateTime.millisecondsSinceEpoch.toDouble();
    final end = data.first.dateTime.millisecondsSinceEpoch.toDouble();
    final range = end - start;

    return (range / 6).clamp(7 * 24 * 60 * 60 * 1000, range);
  }

  String _formatMonth(double timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp.toInt());
    const months = [
      '1월',
      '2월',
      '3월',
      '4월',
      '5월',
      '6월',
      '7월',
      '8월',
      '9월',
      '10월',
      '11월',
      '12월'
    ];
    return months[date.month - 1];
  }
}
