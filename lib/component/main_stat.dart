import 'package:buy_or_bye/model/fng_index_model.dart';
import 'package:buy_or_bye/utils/status_utils.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:buy_or_bye/utils/date_utils.dart';

class MainStat extends StatelessWidget {
  final Color fontColor;
  final FngIndexModel fngIndexModel;

  const MainStat({
    super.key,
    required this.fngIndexModel,
    required this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle ts = TextStyle(
      color: fontColor,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    );
    return SafeArea(
      child: Builder(builder: (context) {
        final chance =
            StatusUtils.getStatusModelFromFngIndex(fngIndex: fngIndexModel);

        return Column(
          children: [
            SizedBox(height: 50),
            Container(
              height: 30,
              width: 180,
              decoration: BoxDecoration(
                color: chance.darkColor,
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
                    '${fngIndexModel.index.round().toInt()}/100',
                    style: ts,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              chance.label,
              style: ts.copyWith(fontWeight: FontWeight.w900, fontSize: 40),
            ),
            Text(
              chance.tempImage,
              style: TextStyle(fontSize: 140),
            ),
            Text(
              chance.comment,
              style: ts.copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }),
    );
  }
}
