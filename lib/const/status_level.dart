import 'package:buy_or_bye/model/status_model.dart';
import 'package:flutter/material.dart';

const statusLevels = [
  StatusModel(
      level: 0,
      label: '절호의 기회',
      statusColor: Color(0xFF2196F3),
      darkColor: Color(0xFF0069C0),
      lightColor: Color(0xFF6EC6FF),
      fontColor: Colors.black,
      tempImage: '🌟',
      comment: '절호의 기회에요'),
  StatusModel(
      level: 1,
      label: '기회',
      statusColor: Color(0xFF00bcd4),
      darkColor: Color(0xFF008ba3),
      lightColor: Color(0xFF62efff),
      fontColor: Colors.black,
      tempImage: '⭐',
      comment: '평소보다 싸게 살 수 있어요'),
  StatusModel(
      level: 2,
      label: '중립',
      statusColor: Color(0xFF009688),
      darkColor: Color(0xFF00675b),
      lightColor: Color(0xFF52c7b8),
      fontColor: Colors.black,
      tempImage: '🙂',
      comment: '오늘은 심심한 날이네요\n결국 장기 우상향 할 거에요'),
  StatusModel(
      level: 3,
      label: '버블',
      statusColor: Color(0xFFffc107),
      darkColor: Color(0xFFc79100),
      lightColor: Color(0xFFfff350),
      fontColor: Colors.black,
      tempImage: '🫧',
      comment: '높게 평가되었을 수 있지만\n장기투자 관점에서는 괜찮아요'),
  StatusModel(
      level: 4,
      label: '고점 주의',
      statusColor: Color(0xFFf44336),
      darkColor: Color(0xFFba000d),
      lightColor: Color(0xFFff7961),
      fontColor: Colors.black,
      tempImage: '🚨',
      comment: '주변 고점 판독기들이 주식을\n사고 계시진 않나요?'),
];
