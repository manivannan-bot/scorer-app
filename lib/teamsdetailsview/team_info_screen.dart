import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:scorer/models/teams/team_info_model.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/sizes.dart';

class TeamInfoScreen extends StatefulWidget {
  final TeamsDetails? teamsDetails;
  const TeamInfoScreen(this.teamsDetails, {super.key});

  @override
  State<TeamInfoScreen> createState() => _TeamInfoScreenState();
}

class _TeamInfoScreenState extends State<TeamInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 5.w),
              width: double.infinity,
              height: 70.h,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                  color: AppColor.lightColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Details",style: fontMedium.copyWith(
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
                        _buildRow("State", "${widget.teamsDetails!.teamCity}"),
                        _buildDivider(),
                        _buildRow("City", "${widget.teamsDetails!.teamState}"),
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
    return const DottedLine(
      dashColor: Color(0xffD2D2D2),
    );
  }
}
