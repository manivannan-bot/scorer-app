import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomVerticalDottedLine extends StatelessWidget {
  const CustomVerticalDottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return const DottedLine(
      dashGapColor: Colors.grey,
      direction: Axis.vertical,
      lineLength: 100,
      lineThickness: 1,
      dashColor: Colors.black,
      dashLength: 5,
      dashGapLength: 2,
    );
  }
}
