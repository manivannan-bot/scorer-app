import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class MatchPreviewBottomSheet extends StatelessWidget {
  const MatchPreviewBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      decoration: const BoxDecoration(
          color: AppColor.lightColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 4.w,)+EdgeInsets.only(top: 2.h,bottom: 0.5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back,size: 7.w,)),
                Text("Match Preview",style: fontMedium.copyWith(
                  fontSize: 17.sp,
                  color: AppColor.blackColour,
                ),),
                SizedBox(width: 7.w,),
              ],
            ),
          ),
          SizedBox(height: 1.h,),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Text("Teams",style: fontMedium.copyWith(
                    fontSize: 14.sp,
                    color: AppColor.blackColour,
                  ),),
                  SizedBox(height: 1.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            ClipOval(child: Image.asset(Images.teamPreviewlogoA,width: 20.w,)),
                            SizedBox(height: 1.h,),
                            Text("Toss & Tails",style: fontMedium.copyWith(
                              fontSize: 14.sp,
                              color: AppColor.blackColour,
                            ),),
                          ],
                        ),
                        Column(
                          children: [
                            ClipOval(child: Image.asset(Images.teamPreviewlogoA,width: 20.w,)),
                            SizedBox(height: 1.h,),
                            Text("Toss & Tails",style: fontMedium.copyWith(
                              fontSize: 14.sp,
                              color: AppColor.blackColour,
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h,),
                  Text("Match Information",style: fontMedium.copyWith(
                    fontSize: 14.sp,
                    color: AppColor.blackColour,
                  ),),
                  SizedBox(height: 2.h,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xffF8F9FA)
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                          child: Row(
                            children: [
                              SvgPicture.asset(Images.dateIcon,width: 6.w,),
                              SizedBox(width: 2.w,),
                              Text("Date",style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: const Color(0xff666666),
                              ),),
                              const Spacer(),
                              Text("Aug 21, 2023 ",style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xffD2D2D2),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                          child: Row(
                            children: [
                              SvgPicture.asset(Images.clockIcon,width: 6.w,),
                              SizedBox(width: 2.w,),
                              Text("Slot",style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: const Color(0xff666666),
                              ),),
                              const Spacer(),
                              Text("6:00 AM",style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xffD2D2D2),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                          child: Row(
                            children: [
                              SvgPicture.asset(Images.groundIcon,width: 6.w,),
                              SizedBox(width: 2.w,),
                              Text("Organizer & \nGround",style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: const Color(0xff666666),
                              ),),
                              const Spacer(),
                              Text("JK Organizer \n Square out fighters"
                                ,style: fontMedium.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.blackColour,
                                ),),
                            ],
                          ),
                        ),
                        const DottedLine(
                          dashColor: Color(0xffD2D2D2),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                          child: Row(
                            children: [
                              SvgPicture.asset(Images.locationsIcon,width: 6.w,),
                              SizedBox(width: 2.w,),
                              Text("Location",style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: const Color(0xff666666),
                              ),),
                              const Spacer(),
                              Text("Chrompet"
                                ,style: fontMedium.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.blackColour,
                                ),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  Text("Professionals",style: fontMedium.copyWith(
                    fontSize: 14.sp,
                    color: AppColor.blackColour,
                  ),),
                  SizedBox(height: 1.h,),
                  Wrap(
                    spacing: 3.w,
                    runSpacing: 2.h,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text("Umpire 2",style: fontRegular.copyWith(
                              fontSize: 12.sp,
                              color: AppColor.blackColour,
                            ),),
                            SizedBox(height: 1.h,),
                            Container(
                              width: 42.w,
                              height: 16.h,
                              padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xffF8F9FA),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipOval(child: Image.asset(Images.umpireImage,width: 16.w,)),
                                  SizedBox(height: 0.5.h,),
                                  Text("ArunKumar",style: fontMedium.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColor.blackColour,
                                  ),),
                                ],
                              ),

                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("Umpire 2",style: fontRegular.copyWith(
                              fontSize: 12.sp,
                              color: AppColor.blackColour,
                            ),),
                            SizedBox(height: 1.h,),
                            Container(
                              width: 42.w,
                              height: 16.h,
                              padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xffF8F9FA),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipOval(child: Image.asset(Images.umpireImage,width: 16.w,)),
                                  SizedBox(height: 0.5.h,),
                                  Text("vinayagam\nMoorthy",style: fontMedium.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColor.blackColour,
                                  ),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text("Scorer",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackColour,
                          ),),
                          SizedBox(height: 1.h,),
                          Container(
                            width: 42.w,
                            height: 16.h,
                            padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xffF8F9FA),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipOval(child: Image.asset(Images.umpireImage,width: 16.w,)),
                                SizedBox(height: 0.5.h,),
                                Text("ArunKumar",style: fontMedium.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.blackColour,
                                ),),
                              ],
                            ),

                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: const Color(0xffF8F9FA),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.w)+EdgeInsets.only(top: 1.5.h,bottom: 1.h),
              child: Row(
                children: [
                  Text('Match Details',style: fontRegular.copyWith(
                      fontSize: 14.sp,
                      color: const Color(0xffD3810C)
                  ),),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 0.8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.blackColour,
                    ),
                    child:  Text('Do Scoring',style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: AppColor.lightColor,
                    ),),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

