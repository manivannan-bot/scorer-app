import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/playerdetailsviews/player_batting_details.dart';
import 'package:scorer/playerdetailsviews/player_bowling_details.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class OverviewPlayerScreen extends StatefulWidget {
  const OverviewPlayerScreen({super.key});

  @override
  State<OverviewPlayerScreen> createState() => _OverviewPlayerScreenState();
}

class _OverviewPlayerScreenState extends State<OverviewPlayerScreen>with SingleTickerProviderStateMixin {
  late TabController tabController;


  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);

  }
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
                  Container(
                    padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffF8F9FA)
                    ), child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Batting",style: fontMedium.copyWith(
                            fontSize: 14.sp,
                            color: AppColor.blackColour,
                          ),),
                          SizedBox(width: 1.w,),
                          SvgPicture.asset(Images.batIcon,width: 5.w,),
                        ],
                      ),
                      SizedBox(height: 1.5.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text("Runs",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.textGrey,
                              ),),
                              SizedBox(height: 0.6.h,),
                              Text("245",style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Highest score",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.textGrey,
                              ),),
                              SizedBox(height: 0.6.h,),
                              Text("205",style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Average",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.textGrey,
                              ),),
                              SizedBox(height: 0.6.h,),
                              Text("24.5",style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                            ],
                          ),
                          Column(
                            children: [
                              Text("SR",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.textGrey,
                              ),),
                              SizedBox(height: 0.6.h,),
                              Text("122",style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h,),
                    ],
                  ),
                  ),
                  SizedBox(height: 2.h,),
                  Container(
                    padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffF8F9FA)
                    ), child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Bowling",style: fontMedium.copyWith(
                            fontSize: 14.sp,
                            color: AppColor.blackColour,
                          ),),
                          SizedBox(width: 1.w,),
                          SvgPicture.asset(Images.ballIcon,width: 5.w,),
                        ],
                      ),
                      SizedBox(height: 1.5.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text("Wickets",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.textGrey,
                              ),),
                              SizedBox(height: 0.6.h,),
                              Text("25",style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Best",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.textGrey,
                              ),),
                              SizedBox(height: 0.6.h,),
                              Text("5-10",style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Maidens",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.textGrey,
                              ),),
                              SizedBox(height: 0.6.h,),
                              Text("1",style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Average",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.textGrey,
                              ),),
                              SizedBox(height: 0.6.h,),
                              Text("10.2",style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h,),

                    ],
                  ),
                  ),
                  SizedBox(height: 2.h,),
                  Center(
                    child: TabBar(
                        labelPadding: EdgeInsets.symmetric(vertical: 0.5.h,horizontal: 5.w),
                        labelColor: Colors.white,
                        // unselectedLabelColor: AppColor.textColor,
                        // unselectedLabelStyle: TextStyle(
                        //   backgroundColor: Colors.grey, // Background color of inactive tabs
                        // ),
                        isScrollable: true,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.primaryColor
                        ),
                        // dividerColor: Colors.transparent,
                        // labelPadding: EdgeInsets.only
                        //   (bottom: 0.5.h) + EdgeInsets.symmetric(
                        //     horizontal: 4.w
                        // ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        // indicatorColor: AppColor.secondaryColor,
                        controller: tabController,
                        tabs: [
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 0.4.h),
                            child: Text('Batting',style: fontMedium.copyWith(fontSize: 12.sp,color: AppColor.blackColour),),
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 5.w),
                            child: Text('Bowling',style: fontMedium.copyWith(fontSize: 12.sp,color: AppColor.blackColour),),
                          ),
                        ]
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                        controller: tabController,
                        children:  [
                          PlayerBattingDetails(),
                          PlayerBowlingDetails(),
                        ]),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}