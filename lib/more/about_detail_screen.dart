import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/models/matches/user_information_model.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class AboutDetailScreen extends StatefulWidget {
  final List<Data>? userData;
  const AboutDetailScreen(this.userData, {super.key});

  @override
  State<AboutDetailScreen> createState() => _AboutDetailScreenState();
}

class _AboutDetailScreenState extends State<AboutDetailScreen> {
  @override
  Widget build(BuildContext context) {
    if(widget.userData==null){
      return const SizedBox(height: 100,width: 100,
          child: Center(child: CircularProgressIndicator(),));
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
              width: double.infinity,
              height: 70.h,
              decoration: const BoxDecoration(
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
                  const Divider(
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
                        _buildRow("Name", "${widget.userData!.first.name??'-'}"),
                        _buildDivider(),
                        _buildRow("Matches Umpired", "${widget.userData!.first.matches??'-'}"),
                        _buildDivider(),
                        _buildRow("Phone number", "${widget.userData!.first.mobileNo??'-'}"),
                        _buildDivider(),
                        _buildRow("Experience", "${widget.userData!.first.experience??'-'}"),
                        _buildDivider(),
                        _buildRow("Date of birth", "${widget.userData!.first.dob??'-'}"),
                        _buildDivider(),
                        _buildRow("Location", "${widget.userData!.first.location??'-'}"),
                        _buildDivider(),
                        _buildRow("State", "${widget.userData!.first.state??'-'}"),
                        _buildDivider(),
                        _buildRow("City", "${widget.userData!.first.city??'-'}"),
                        _buildDivider(),
                        _buildRow("Pincode", "${widget.userData!.first.pincode??'-'}"),

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
