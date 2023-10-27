import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../teamsdetailsview/team_detail_view_screens.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class TeamListScreen extends StatefulWidget {
  const TeamListScreen({super.key});

  @override
  State<TeamListScreen> createState() => _TeamListScreenState();
}

class _TeamListScreenState extends State<TeamListScreen> {
  List<Map<String,dynamic>> itemList=[
    {
      "image":'assets/images/req_list.png',
      "name":"Akash",
      "team":"(Toss and Tails)",
      "dot":".",
      "batsman":"Right hand batsman",
      "button":"Connect",
    },
    {}, {}, {}, {},{}, {}, {}, {},


  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => TeamDetailViewScreens()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                    color: AppColor.lightColor
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Teams",style: fontMedium.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.blackColour,
                    ),),
                    SizedBox(height: 2.h,),
                    MediaQuery.removePadding(
                      context: context,
                      removeTop: true,  // Set this to true to remove top padding
                      removeBottom: true,
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, _) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 1.h)
                            );
                          },
                          itemCount: itemList.length,
                          itemBuilder: (BuildContext, int index) {
                            final item = itemList[index];
                            return   Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.5.h),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffF8F9FA),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Image.asset(Images.teamListImage,width: 20.w,),
                                      ),
                                      SizedBox(width: 2.w,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Toss & Tails", style: fontMedium.copyWith(
                                              fontSize: 14.sp,
                                              color: AppColor.blackColour,
                                            )),
                                            SizedBox(height: 1.h,),
                                            DottedLine(
                                              dashColor: Color(0xffD2D2D2),
                                            ),
                                            SizedBox(height: 1.h,),
                                            Wrap(
                                              children: [
                                                RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: "Played : ",
                                                          style: fontMedium.copyWith(
                                                            fontSize: 12.sp,
                                                            color: AppColor.textGrey,
                                                          )),
                                                      TextSpan(
                                                          text: " 30",
                                                          style: fontRegular.copyWith(
                                                            fontSize: 12.sp,
                                                            color: AppColor.blackColour,
                                                          )),
                                                    ])),
                                                SizedBox(width: 1.5.w,),
                                                RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: "Won : ",
                                                          style: fontMedium.copyWith(
                                                            fontSize: 12.sp,
                                                            color: AppColor.textGrey,
                                                          )),
                                                      TextSpan(
                                                          text: " 30",
                                                          style: fontRegular.copyWith(
                                                            fontSize: 12.sp,
                                                            color: AppColor.blackColour,
                                                          )),
                                                    ])),
                                                SizedBox(width: 1.5.w,),
                                                RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: "Lost : ",
                                                          style: fontMedium.copyWith(
                                                            fontSize: 12.sp,
                                                            color: AppColor.textGrey,
                                                          )),
                                                      TextSpan(
                                                          text: " 30",
                                                          style: fontRegular.copyWith(
                                                            fontSize: 12.sp,
                                                            color: AppColor.blackColour,
                                                          )),
                                                    ])),
                                              ],

                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }
}
