import 'package:buy_or_bye/utils/status_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:buy_or_bye/utils/date_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import '../model/fng_index_model.dart';

//https://www.youtube.com/watch?v=LB7B3zudivI

class ChatStat extends StatelessWidget {
  final Color darkColor;

  ChatStat({required this.darkColor});

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
                  maxY: 100,
                  titlesData: LineTitles.getTitleData(),
                  gridData: FlGridData(
                    show: true,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.black,
                        strokeWidth: 0.5,
                      );
                    },
                  ),

                  // gridData: FlGridData(
                  //   show: true,
                  //   drawVerticalLine: false,
                  //   horizontalInterval: 1,
                  //   checkToShowHorizontalLine: (double value) {
                  //     return value == 1 || value == 6 || value == 4 || value == 5;
                  //   },
                  // ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: StatusUtils.modelsToSpot(
                        initialList: fngIndexModels,
                      ),
                      color: darkColor,
                      barWidth: 2,
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

class LineTitles {
  static getTitleData() => FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
          ),
        ),
        bottomTitles: AxisTitles(
          axisNameWidget: Text(
            '2024',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  String text;
  switch (DateTime.fromMillisecondsSinceEpoch(value.toInt()).month) {
    case 0:
      text = 'Jan';
      break;
    case 1:
      text = 'Feb';
      break;
    case 2:
      text = 'Mar';
      break;
    case 3:
      text = 'Apr';
      break;
    case 4:
      text = 'May';
      break;
    case 5:
      text = 'Jun';
      break;
    case 6:
      text = 'Jul';
      break;
    case 7:
      text = 'Aug';
      break;
    case 8:
      text = 'Sep';
      break;
    case 9:
      text = 'Oct';
      break;
    case 10:
      text = 'Nov';
      break;
    case 11:
      text = 'Dec';
      break;
    default:
      return Container();
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 4,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

//gridData: FlGridData(show: true),

// titlesData: FlTitlesData(
//   topTitles: AxisTitles(
//       sideTitles: SideTitles(
//     showTitles: false,
//   )),
//   leftTitles: AxisTitles(
//     sideTitles: SideTitles(showTitles: true),
//   ),
//   bottomTitles: AxisTitles(
//     sideTitles: SideTitles(
//       showTitles: true,
//       getTitlesWidget: (value, _) {
//         final date = DateTime.fromMillisecondsSinceEpoch(
//             value.toInt());
//         return Text(
//             DateUtils.DateTimeToString(dateTime: date));
//       },
//     ),
//   ),
// ),
// borderData: FlBorderData(show: false),
// lineBarsData: [
//   LineChartBarData(
//     spots: fngIndexModels
//         .map((item) => FlSpot(
//               item.dateTime.millisecondsSinceEpoch.toDouble(),
//               item.index,
//             ))
//         .toList(),
//     isCurved: true,
//     barWidth: 2,
//     color: darkColor,
//     belowBarData: BarAreaData(
//         show: true, color: darkColor.withOpacity(0.3)),
//   ),
// ],
//)
// ,
