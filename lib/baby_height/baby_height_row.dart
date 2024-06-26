import 'package:baby_diary/baby_height/height_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:baby_diary/common/extension/date_time_extension.dart';
import 'package:baby_diary/common/extension/text_extension.dart';

class BabyHeightRow extends StatelessWidget {
  const BabyHeightRow({super.key, required this.height});
  final HeightModel height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: const BorderRadius.all(Radius.circular(6))
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${height.height} cm').w500().text15().blackColor().ellipsis(),
                  const SizedBox(height: 4),
                  Text(height.time.globalDateFormat()).w400().text12().primaryTextColor().ellipsis().right(),
                ],
              )
          )
        ],
      ),
    );
  }
}