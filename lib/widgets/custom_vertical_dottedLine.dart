import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';

class CustomVerticalDottedLine extends StatelessWidget {
  const CustomVerticalDottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return  DottedLine(
      dashGapColor: AppColor.lightColor,
      direction: Axis.vertical,
      lineLength: 10.h,
      lineThickness: 0.5,
      dashColor: const Color(0xffA8A5A5),
      dashLength: 5,
      dashGapLength: 2,
    );
  }
}
