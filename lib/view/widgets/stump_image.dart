import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';

class StumpImage extends StatelessWidget {
  final int bowlerPosition;
  const StumpImage(this.bowlerPosition, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(Images.stumpIcon1,width:4.w, color: bowlerPosition == 1 ? AppColor.pri : AppColor.textMildColor,);
  }
}