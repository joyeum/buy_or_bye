import 'package:buy_or_bye/component/main_stat.dart';
import 'package:buy_or_bye/component/past_stat.dart';
import 'package:buy_or_bye/const/color.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              MainStat(),
              SizedBox(
                height: 100,
              ),
              PastStat(),
              Padding(
                padding:EdgeInsets.only(right: 20, left: 20, top: 4,),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    '2024-04-01 11:00 업데이트 됨',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
