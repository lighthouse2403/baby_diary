import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:baby_diary/common/extension/date_time_extension.dart';
import 'package:baby_diary/common/extension/text_extension.dart';
import 'package:baby_diary/diary/model/diary.dart';

class DiaryRow extends StatelessWidget {
  const DiaryRow({super.key, required this.diary});
  final Diary diary;

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
          _buildImageRow(),
          const SizedBox(width: 8),
          Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(diary.title).w500().text15().blackColor().ellipsis(),
                  const SizedBox(height: 4),
                  Text(diary.time.globalDateFormat()).w400().text12().primaryTextColor().ellipsis().right(),
                ],
              )
          )
        ],
      ),
    );
  }

  Widget _buildImageRow() {
    if (diary.mediaUrl.isEmpty) {
      return Container();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10), // Image border
      child: SizedBox.fromSize(
        size: const Size.fromRadius(60), // Image radius
        child: Image.file(
          File(diary.mediaUrl.first),
          errorBuilder: (BuildContext context, Object error,
              StackTrace? stackTrace) {
            return const Center(
                child: Text('This image type is not supported'));
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}