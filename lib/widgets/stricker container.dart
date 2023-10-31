import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/styles.dart';

class ChooseContainer extends StatelessWidget {
  final String label;
  const ChooseContainer(this.label,{super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 36.w,
      padding: EdgeInsets.symmetric(
        vertical: 5.h,
        horizontal: 3.w
      ),
      decoration: BoxDecoration(
        border: RDottedLineBorder.all(
          color: const Color(0xffCCCCCC),
          width: 1,
        ),
        color: const Color(0xffF8F9FA),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(label == "Striker" || label == "Non-Striker" || label == "Bowler" || label == "Wicket Keeper")...[
            SvgPicture.asset(Images.plusIcon, width: 10.w,),
          ] else ...[
            Icon(Icons.person, color: AppColor.primaryColor, size: 10.w,),
          ],
          SizedBox(height: 2.h,),
          FittedBox(
            child: Text(label,
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
              fontSize: 14.sp,
              color: const Color(0xff444444),
            ),),
          ),
        ],
      ),
    );
  }
}
