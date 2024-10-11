import 'package:buy_or_bye/const/color.dart';
import 'package:flutter/material.dart';

class MainStat extends StatelessWidget {
  const MainStat({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle ts = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    );
    return Column(
      children: [
        SizedBox(height: 50),
        Container(
          height: 30,
          width: 180,
          decoration: BoxDecoration(
            color: darkColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '탐욕 지수',
                style: ts.copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                '50/100',
                style: ts,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),

        Text(
          '중립',
          style: ts.copyWith(fontWeight: FontWeight.w900, fontSize: 40),
        ),
        Text(
          '🙂',
          style: TextStyle(fontSize: 140),
        ),
        Text(
          '보통의 상태에요',
          style: ts.copyWith(fontSize: 24),
        ),
      ],
    );
  }
}
