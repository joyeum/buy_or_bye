import 'package:buy_or_bye/model/chance_model.dart';
import 'package:flutter/material.dart';

const chanceLevels = [
  ChanceModel(
      level: 0,
      label: '절호의 기회',
      primaryColor: Color(0xFF2196F3),
      darkColor: Color(0xFF0069C0),
      lightColor: Color(0xFF6EC6FF),
      fontColor: Colors.black,
      tempImage: '🤑',
      comment: '절호의 기회에요'),
  ChanceModel(
      level: 1,
      label: '기회',
      primaryColor: Color(0xFF03a9f4),
      darkColor: Color(0xFF007ac1),
      lightColor: Color(0xFF67daff),
      fontColor: Colors.black,
      tempImage: '🤩',
      comment: '평소보다 싸게 살 수 있어요'),
  ChanceModel(
      level: 2,
      label: '중립',
      primaryColor: Color(0xFF03a9f4),
      darkColor: Color(0xFF007ac1),
      lightColor: Color(0xFF67daff),
      fontColor: Colors.black,
      tempImage: '🙂',
      comment: '평소보다 싸게 살 수 있어요'),
  ChanceModel(
      level: 3,
      label: '버블',
      primaryColor: Color(0xFF03a9f4),
      darkColor: Color(0xFF007ac1),
      lightColor: Color(0xFF67daff),
      fontColor: Colors.black,
      tempImage: '😟',
      comment: '높게 평가되었을 수 있어요'),
  ChanceModel(
      level: 4,
      label: '큰 버블',
      primaryColor: Color(0xFF03a9f4),
      darkColor: Color(0xFF007ac1),
      lightColor: Color(0xFF67daff),
      fontColor: Colors.black,
      tempImage: '😖',
      comment: '조정이 올 수 있어요'),
];
