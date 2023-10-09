import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:sizer/sizer.dart';

import '../utils/images.dart';
import '../utils/styles.dart';

class ChooseContainer extends StatelessWidget {
  final String label;
  const ChooseContainer(this.label,{super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 18.h,
      width: 36.w,
      decoration: BoxDecoration(
        border: RDottedLineBorder.all(
          color: Color(0xffCCCCCC),
          width: 1,
        ),
        color: Color(0xffF8F9FA),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 5.h,bottom: 2.h),
            child: SvgPicture.asset(Images.plusIcon,width: 10.w,),
          ),
          SizedBox(height: 2.h,),
          Text(label,style: fontMedium.copyWith(
            fontSize: 14.sp,
            color: Color(0xff444444),
          ),),
        ],
      ),
    );
  }
}
