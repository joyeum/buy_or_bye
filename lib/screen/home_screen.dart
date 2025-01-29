import 'package:buy_or_bye/component/chart_stat.dart';
import 'package:buy_or_bye/component/main_stat.dart';
import 'package:buy_or_bye/component/past_stat.dart';
import 'package:buy_or_bye/repository/fng_index_repository.dart';

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
  @override
  void initState() {
    FngIndexRepository.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppStyles.padding),
            child: Column(
              children: [
                MainStat(),


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
        ),
      );
    });
  }
}
