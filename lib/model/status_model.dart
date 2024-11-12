import 'package:flutter/material.dart';
//기회

class StatusModel {
  // 단계
  final int level; // 0,1,2,3,4

  // 단계 이름
  final String label;

  final Color primaryColor;
  final Color darkColor;
  final Color lightColor;
  final Color fontColor;

  final String tempImage;
  final String comment;

  const StatusModel({
    required this.level,
    required this.label,

    required this.primaryColor,
    required this.darkColor,
    required this.lightColor,
    required this.fontColor,

    required this.tempImage,
    required this.comment,
  });
}
