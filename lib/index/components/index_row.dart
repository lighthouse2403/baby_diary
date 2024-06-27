import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baby_diary/common/base/base_statefull_widget.dart';
import 'package:baby_diary/common/constants/app_colors.dart';
import 'package:baby_diary/common/extension/text_extension.dart';
import 'package:baby_diary/index/model/index_model.dart';

class IndexRow extends BaseStatefulWidget {
  const IndexRow({super.key, required this.index});

  final IndexModel? index;
  @override
  State<IndexRow> createState() => _IndexRowState();
}

class _IndexRowState extends BaseStatefulState<IndexRow> {

  @override
  Widget? buildBody() {
    int week = widget.index?.id ?? 0;
    Color bgColor = week %2 != 0 ? AppColors.mainColor.withOpacity(0.3) : Colors.white;

    return Container(
      color: bgColor,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                height: 60,
                child: Text('Tuần ${widget.index?.id}').w600().text14().center(),
              )
          ),
          Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                height: 60,
                child: Text('${widget.index?.bpdAverage}').w500().text14().center(),
              )
          ),
          Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                height: 60,
                child: Text('${widget.index?.flAverage}').w500().text14().center(),
              )
          ),
          Expanded(
              flex: 1,
              child: Text('${widget.index?.efwAverage}').center()
          )
        ],
      ),
    );
  }
}