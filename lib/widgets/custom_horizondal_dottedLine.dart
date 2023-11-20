import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';

class CustomHorizontalDottedLine extends StatelessWidget {
  const CustomHorizontalDottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      dashGapColor: Colors.grey,
      direction: Axis.horizontal,
      lineLength: 100.w,
      lineThickness: 1,
      dashColor:
      AppColor.scoreUpdateBg,
      dashLength: 5,
      dashGapLength: 2,
    );
  }
}
