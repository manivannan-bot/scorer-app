import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class AboutDetailScreen extends StatefulWidget {
  const AboutDetailScreen({super.key});

  @override
  State<AboutDetailScreen> createState() => _AboutDetailScreenState();
}

class _AboutDetailScreenState extends State<AboutDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
              width: double.infinity,
              height: 70.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                  color: AppColor.lightColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Player Information",style: fontMedium.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.blackColour,
                      ),),
                      Spacer(),
                      Row(
                        children: [
                          Text("Edit",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: Color(0xff737373),
                          ),),SizedBox(width: 1.w,),
                          SvgPicture.asset(Images.editSymbolIcon)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h,),
                  Divider(
                    color: Color(0xffCCC6C6),
                  ),
                  SizedBox(height: 1.h,),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffF8F9FA),
                    ),
                    child: Column(
                      children: [
                        _buildRow("Name", "Sathish durai pandian"),
                        _buildDivider(),
                        _buildRow("Matches Umpired", "Batting"),
                        _buildDivider(),
                        _buildRow("Phone number", "Right hand batsman"),
                        _buildDivider(),
                        _buildRow("Experience", "Top Order"),
                        _buildDivider(),
                        _buildRow("Date of birth", "Left arm"),
                        _buildDivider(),
                        _buildRow("Location", "Off Spin"),
                        _buildDivider(),
                        _buildRow("State", "Others"),
                        _buildDivider(),
                        _buildRow("City", "28/09/1994"),
                        _buildDivider(),
                        _buildRow("Pincode", "Medavakkam"),

                      ],

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
          child: Text(
            label,
            style: fontRegular.copyWith(fontSize: 12.sp, color: Color(0xff555555)),
          ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.h),
          child: SizedBox(
            width: 30.w,
            child: Text(
              value,
              style: fontMedium.copyWith(fontSize: 12.sp, color: AppColor.blackColour),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return DottedLine(
      dashColor: Color(0xffD2D2D2),
    );
  }
}
