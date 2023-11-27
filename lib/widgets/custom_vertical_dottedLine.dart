import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';

class CustomVerticalDottedLine extends StatelessWidget {
  final bool top;
  const CustomVerticalDottedLine(this.top, {super.key});

  @override
  Widget build(BuildContext context) {
    return  DottedLine(
      dashGapColor: Colors.transparent,
      direction: Axis.vertical,
      lineLength: top ? 9.h : 12.h,
      lineThickness: 0.5,
      dashColor:
      AppColor.verticalDividerColor,
      dashLength: 5,
      dashGapLength: 3,
    );
  }
}
