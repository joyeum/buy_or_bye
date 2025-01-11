import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import '../model/fng_index_model.dart';

class ChatStat extends StatelessWidget {
  final Color darkColor;

  ChatStat({required this.darkColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: FutureBuilder<List<FngIndexModel>>(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final data = snapshot.data ?? [];
          if (data.isEmpty) {
            return Center(child: Text('No data available'));
          }
          return LineChart(_buildChart(data));
        },
      ),
    );
  }

  Future<List<FngIndexModel>> _fetchData() {
    return GetIt.I<Isar>()
        .fngIndexModels
        .where()
        .sortByDateTimeDesc()
        .limit(30)
        .findAll();
  }

  LineChartData _buildChart(List<FngIndexModel> data) {
    return LineChartData(
      minY: 0,
      maxY: 100,
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => Text(
              _formatMonth(value),
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
      ),
      gridData: FlGridData(show: true),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: data
              .map((e) => FlSpot(
            e.dateTime.millisecondsSinceEpoch.toDouble(),
            e.index.toDouble(),
          ))
              .toList(),
          color: darkColor,
          barWidth: 2,
        ),
      ],
    );
  }

  String _formatMonth(double value) {
    final month = DateTime.fromMillisecondsSinceEpoch(value.toInt()).month;
    return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][month - 1];
  }
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
