import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/models/teams/team_overview_model.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class TeamOverviewScreen extends StatefulWidget {
  final String teamId;
  const TeamOverviewScreen(this.teamId, {super.key});

  @override
  State<TeamOverviewScreen> createState() => _TeamOverviewScreenState();
}

class _TeamOverviewScreenState extends State<TeamOverviewScreen> {
  List<Map<String,dynamic>> itemList=[
    {
      "image":'assets/images/req_list.png',
      "name":"Akash",
      "team":"(Toss and Tails)",
      "dot":".",
      "batsman":"Right hand batsman",
      "button":"Connect",
    },
    {}, {}, {}, {},
  ];
  TeamOverview? teamOverview;
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  fetchData(){

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
          width: double.infinity,
          height: 75.h,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
              color: AppColor.lightColor
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.5.h,),
              Row(
                children: [
                  Row(
                    children: [
                      Text("Recent team form",style: fontMedium.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.blackColour,
                      ),),
                      SizedBox(width: 1.w,),
                      SvgPicture.asset(Images.batIcon,width: 5.w,),
                    ],
                  ),
                  Spacer(),
                  Text("(Last 5 matches)",style: fontMedium.copyWith(
                    fontSize: 11.sp,
                    color: AppColor.textGrey,
                  ),),
                ],
              ),
              SizedBox(height: 1.5.h,),
              SizedBox(
                height: 18.h,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, _) {
                      return Padding(
                        padding: EdgeInsets.only(right: 2.w),
                        child: Divider(
                          color: Color(0xffD3D3D3),
                        ),
                      );
                    },
                    itemCount: itemList.length,
                    itemBuilder: (BuildContext, int index) {
                      final item = itemList[index];
                      return   Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.5.h),
                            width: 25.w,
                            height: 15.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffF8F9FA),
                            ),
                            child: Column(
                              children: [
                                Text("Lost",style: fontMedium.copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.redColor,
                                ),),
                                SizedBox(height: 0.5.h,),
                                Text("vs",style: fontRegular.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.textGrey,
                                ),),
                                SizedBox(height: 0.5.h,),
                                Text("Spartans",style: fontRegular.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.textGrey,
                                ),),
                                SizedBox(height: 0.5.h,),
                                Text("28 Jun",style: fontRegular.copyWith(
                                  fontSize: 10.sp,
                                  color: AppColor.textGrey,
                                ),),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              Text("Team stats",style: fontMedium.copyWith(
                fontSize: 14.sp,
                color: AppColor.blackColour,
              ),),
              SizedBox(height: 1.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffF8F9FA),
                ),
                child: Row(
                  children: [
                    Text("Team stats",style: fontMedium.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.blackColour,
                    ),),
                    SizedBox(width: 10.w,),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Result",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                              Spacer(),
                              Text("Matches",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            color: Color(0xffD3D3D3),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 2.2.h,
                                      width: 5.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: Color(0xff008000)
                                      ),
                                    ),
                                    SizedBox(width: 4.w,),
                                    Text("Won",style: fontMedium.copyWith(
                                      fontSize: 14.sp,
                                        color: Color(0xff008000)
                                    ),),
                                    Spacer(),
                                    Text("57",style: fontMedium.copyWith(
                                        fontSize: 14.sp,
                                        color: AppColor.blackColour
                                    ),),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 1.h,),
                          DottedLine(
                            dashColor: Color(0xffD2D2D2),
                          ),
                          SizedBox(height: 1.h,),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 2.2.h,
                                      width: 5.w,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: AppColor.redColor
                                      ),
                                    ),
                                    SizedBox(width: 4.w,),
                                    Text("Lost",style: fontMedium.copyWith(
                                        fontSize: 14.sp,
                                        color: AppColor.redColor
                                    ),),
                                    Spacer(),
                                    Text("57",style: fontMedium.copyWith(
                                        fontSize: 14.sp,
                                        color: AppColor.blackColour
                                    ),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h,),
              Row(
                children: [
                  Container(
                    width: 44.w,
                    padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF8F9FA),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Most runs",style: fontRegular.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.blackColour,
                        ),),
                        SizedBox(height: 1.h,),
                        Row(
                          children: [
                            ClipOval(child: Image.asset(Images.profileImage,width: 14.w,)),
                            SizedBox(width: 2.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 20.w,
                                  child: Text('Prasanth',style: fontRegular.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColor.blackColour,
                                  ),),
                                ),
                                SizedBox(height: 0.5.h,),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppColor.pri,
                                      radius: 4,
                                    ),
                                    SizedBox(width: 1.w,),
                                    Text("LHB",style: fontRegular.copyWith(
                                      fontSize: 11.sp,
                                      color: Color(0xff666666),
                                    ),),
                                  ],
                                ),
                              ],),
                          ],
                        ),
                        SizedBox(height: 1.h,),
                        DottedLine(
                          dashColor: Color(0xffD2D2D2),
                        ),
                        SizedBox(height: 1.h,),
                        Row(
                          children: [
                            Text("14 matches",style: fontRegular.copyWith(
                              fontSize: 10.sp,
                              color: Color(0xff666666)
                            ),),
                            Spacer(),
                            Text("567",style: fontMedium.copyWith(
                              fontSize: 13.sp,
                              color: AppColor.blackColour,
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4.w,),
                  Container(
                    width: 44.w,
                    padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF8F9FA),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Most wickets",style: fontRegular.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.blackColour,
                        ),),
                        SizedBox(height: 1.h,),
                        Row(
                          children: [
                            ClipOval(child: Image.asset(Images.profileImage,width: 14.w,)),
                            SizedBox(width: 2.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 20.w,
                                  child: Text('Prasanth',style: fontRegular.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColor.blackColour,
                                  ),),
                                ),
                                SizedBox(height: 0.5.h,),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppColor.pri,
                                      radius: 4,
                                    ),
                                    SizedBox(width: 1.w,),
                                    Text("LHB",style: fontRegular.copyWith(
                                      fontSize: 11.sp,
                                      color: Color(0xff666666),
                                    ),),
                                  ],
                                ),
                              ],),
                          ],
                        ),
                        SizedBox(height: 1.h,),
                        DottedLine(
                          dashColor: Color(0xffD2D2D2),
                        ),
                        SizedBox(height: 1.h,),
                        Row(
                          children: [
                            Text("14 matches",style: fontRegular.copyWith(
                                fontSize: 10.sp,
                                color: Color(0xff666666)
                            ),),
                            Spacer(),
                            Text("567",style: fontMedium.copyWith(
                              fontSize: 13.sp,
                              color: AppColor.blackColour,
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),

    );
  }
}

