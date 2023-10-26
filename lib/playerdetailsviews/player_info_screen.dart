import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/sizes.dart';

class PlayerInfoScreen extends StatefulWidget {
  const PlayerInfoScreen({super.key});

  @override
  State<PlayerInfoScreen> createState() => _PlayerInfoScreenState();
}

class _PlayerInfoScreenState extends State<PlayerInfoScreen> {
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
               Text("Player Information",style: fontMedium.copyWith(
                 fontSize: 14.sp,
                 color: AppColor.blackColour,
               ),),
               SizedBox(height: 2.h,),
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
                     _buildRow("Role", "Batting"),
                     _buildDivider(),
                     _buildRow("Batting Style", "Right hand batsman"),
                     _buildDivider(),
                     _buildRow("Batting Order", "Top Order"),
                     _buildDivider(),
                     _buildRow("Bowling action", "Left arm"),
                     _buildDivider(),
                     _buildRow("Bowling Style", "Off Spin"),
                     _buildDivider(),
                     _buildRow("Bowling Proficiency", "Others"),
                     _buildDivider(),
                     _buildRow("Date of Birth", "28/09/1994"),
                     _buildDivider(),
                     _buildRow("Location", "Medavakkam"),

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

//ase replace the basic styles with your specific styles, and make sure you are not applying conflicting styles or padding/margin properties elsewhere in your code that could cause misalignment.







}
