import 'package:flutter/material.dart';

import '../../utils/colours.dart';

class PitchContainer extends StatelessWidget {
  final double width, height;
  final Color color;
  final int? selected;
  final int id;
  const PitchContainer(this.width, this.height, this.color, this.selected, this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: id == selected ? AppColor.textColor : color,
          border: Border.all(color: AppColor.lightColor)
      ),
    );
  }
}