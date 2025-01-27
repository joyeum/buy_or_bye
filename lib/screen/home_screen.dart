import 'package:buy_or_bye/component/chart_stat.dart';
import 'package:buy_or_bye/component/main_stat.dart';
import 'package:buy_or_bye/component/past_stat.dart';
import 'package:buy_or_bye/repository/fng_index_repository.dart';

import 'package:flutter/material.dart' hide DateUtils;

import '../utils/status_utils.dart';
import '../utils/date_utils.dart';

class HomeScreen extends StatefulWidget {
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
    return Builder(

        builder: (context) {

          return Scaffold(
            backgroundColor: Colors.black,
            body: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MainStat(),
                    // SizedBox(
                    //   height: 20,
                    // ),


                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SizedBox(
                            width: constraints.maxWidth,
                            height: 400, // 명시적인 높이 설정
                            child: ChartStat(
                              darkColor: Colors.black,
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    PastStat(
                      darkColor: Colors.black,
                      lightColor: Colors.blue,
                      fontColor: Colors.white,
                    ),


                  ],
                ),
              ),
            ),
          );
        });
  }
}
