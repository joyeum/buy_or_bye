import 'package:buy_or_bye/const/styles.dart';
import 'package:buy_or_bye/const/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // 다국어 지원

import '../model/fng_index_model.dart';

class ChartStat extends StatelessWidget {
  static const double padding = 24;
  static const int days = 365;
  final List<FngIndexModel> chartData;

  ChartStat({required this.chartData, super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // 다국어 지원

    return Card(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          children: [
            _buildTitle(localizations),
            _buildChartContainer(localizations),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(AppLocalizations localizations) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        localizations.titleFearGreedIndex, // 다국어 적용
        style: AppStyles.title,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildChartContainer(AppLocalizations localizations) {
    return Expanded(
      child: LineChart(
        _buildChart(chartData, localizations),
      ),
    );
  }

  LineChartData _buildChart(List<FngIndexModel> data, AppLocalizations localizations) {
    return LineChartData(
      lineBarsData: [_buildLineChartBarData(data)],
      gridData: _buildGridData(),
      titlesData: _buildTitlesData(data, localizations), // 다국어 지원
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

  FlTitlesData _buildTitlesData(List<FngIndexModel> data, AppLocalizations localizations) {
    return FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: _buildBottomTitles(data, localizations), // 다국어 지원
      leftTitles: _buildLeftTitles(),
    );
  }

  AxisTitles _buildBottomTitles(List<FngIndexModel> data, AppLocalizations localizations) {
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
          return Text(
            _formatMonth(timestamp, localizations), // 다국어 적용
            style: AppStyles.subText.copyWith(fontSize: 10),
          );
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

  // 다국어 지원 월 포맷터
  String _formatMonth(double timestamp, AppLocalizations localizations) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp.toInt());

    switch (date.month) {
      case 1: return localizations.month1;
      case 2: return localizations.month2;
      case 3: return localizations.month3;
      case 4: return localizations.month4;
      case 5: return localizations.month5;
      case 6: return localizations.month6;
      case 7: return localizations.month7;
      case 8: return localizations.month8;
      case 9: return localizations.month9;
      case 10: return localizations.month10;
      case 11: return localizations.month11;
      case 12: return localizations.month12;
      default: return localizations.month1;
    }
  }
}