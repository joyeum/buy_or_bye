import 'package:buy_or_bye/utils/status_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:buy_or_bye/utils/date_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import '../model/fng_index_model.dart';

class FngIndexLineChart extends StatelessWidget {
  final Color darkColor;

  FngIndexLineChart({required this.darkColor});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: 300, // 높이 설정
          child: FutureBuilder(
            future: GetIt.I<Isar>()
                .fngIndexModels
                .where()
                .sortByDateTimeDesc()
                .limit(30)
                .findAll(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              final fngIndexModels = StatusUtils.uniqueDate(
                initialList: snapshot.data!,
              );
              return LineChart(
                LineChartData(
                  minY: 0,
                  // y축 최소값 설정
                  maxY: 100,
                  // y축 최대값 설정
                  gridData: FlGridData(show: true),

                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          final date = DateTime.fromMillisecondsSinceEpoch(
                              value.toInt());
                          return Text(
                              DateUtils.DateTimeToString(dateTime: date));
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: fngIndexModels
                          .map((item) => FlSpot(
                                item.dateTime.millisecondsSinceEpoch.toDouble(),
                                item.index,
                              ))
                          .toList(),
                      isCurved: true,
                      barWidth: 2,
                      color: darkColor,
                      belowBarData: BarAreaData(
                          show: true, color: darkColor.withOpacity(0.3)),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
