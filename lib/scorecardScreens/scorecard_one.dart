import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorer/utils/colours.dart';
import 'package:sizer/sizer.dart';

import '../utils/images.dart';
import '../utils/sizes.dart';

class ScoreCardOne extends StatefulWidget {
  const ScoreCardOne({super.key});

  @override
  State<ScoreCardOne> createState() => _ScoreCardOneState();
}

class _ScoreCardOneState extends State<ScoreCardOne> {
  List<Map<String,dynamic>> itemList=[
    {
      "image":'assets/images/req_list.png',
      "name":"Akash",
      "team":"(Toss and Tails)",
      "dot":".",
      "batsman":"Right hand batsman",
      "button":"Connect",
    },
    {
      "image":'assets/images/req_list.png',
      "name":"Vigneswaran",
      "team":"(Royal Kings)",
      "dot":".",
      "batsman":"All rounder",
      "button":"Connect",
    },
    {
      "image":'assets/images/req_list.png',
      "name":"Akash",
      "team":"(Toss and Tails)",
      "dot":".",
      "batsman":"Right hand batsman",
      "button":"Connect",
    },
    {
      "image":'assets/images/req_list.png',
      "name":"Vigneswaran",
      "team":"(Royal Kings)",
      "dot":".",
      "batsman":"All rounder",
      "button":"Connect",
    },
    {
      "image":'assets/images/req_list.png',
      "name":"Akash",
      "team":"(Toss and Tails)",
      "dot":".",
      "batsman":"Right hand batsman",
      "button":"Connect",
    },
    {
      "image":'assets/images/req_list.png',
      "name":"Vigneswaran",
      "team":"(Royal Kings)",
      "dot":".",
      "batsman":"All rounder",
      "button":"Connect",
    },

  ];
  List<Map<String,dynamic>> gridList=[
    {
      "image":'assets/images/req_list.png',
      "name":"Akash",
      "team":"(Toss and Tails)",
      "dot":".",
      "batsman":"Right hand batsman",
      "button":"Connect",
    },
    {
      "image":'assets/images/req_list.png',
      "name":"Vigneswaran",
      "team":"(Royal Kings)",
      "dot":".",
      "batsman":"All rounder",
      "button":"Connect",
    },
    {
      "image":'assets/images/req_list.png',
      "name":"Akash",
      "team":"(Toss and Tails)",
      "dot":".",
      "batsman":"Right hand batsman",
      "button":"Connect",
    },
    {
      "image":'assets/images/req_list.png',
      "name":"Vigneswaran",
      "team":"(Royal Kings)",
      "dot":".",
      "batsman":"All rounder",
      "button":"Connect",
    },
    {
      "image":'assets/images/req_list.png',
      "name":"Akash",
      "team":"(Toss and Tails)",
      "dot":".",
      "batsman":"Right hand batsman",
      "button":"Connect",
    },
    {
      "image":'assets/images/req_list.png',
      "name":"Vigneswaran",
      "team":"(Royal Kings)",
      "dot":".",
      "batsman":"All rounder",
      "button":"Connect",
    },

  ];
  List<Map<String,dynamic>> itemsList=[
    {
      "image":'assets/images/req_list.png',
      "name":"Akash",
      "team":"(Toss and Tails)",
      "dot":".",
      "batsman":"Right hand batsman",
      "button":"Connect",
    },
    {
      "image":'assets/images/req_list.png',
      "name":"Vigneswaran",
      "team":"(Royal Kings)",
      "dot":".",
      "batsman":"All rounder",
      "button":"Connect",
    },
    {
      "image":'assets/images/req_list.png',
      "name":"Akash",
      "team":"(Toss and Tails)",
      "dot":".",
      "batsman":"Right hand batsman",
      "button":"Connect",
    },
    {
      "image":'assets/images/req_list.png',
      "name":"Vigneswaran",
      "team":"(Royal Kings)",
      "dot":".",
      "batsman":"All rounder",
      "button":"Connect",
    },
    {
      "image":'assets/images/req_list.png',
      "name":"Akash",
      "team":"(Toss and Tails)",
      "dot":".",
      "batsman":"Right hand batsman",
      "button":"Connect",
    },


  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 4.w),
      child: ListView(
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
          SizedBox(height: 2.h,),
          Row(
            children: [
              SizedBox(
                width: 35.w,
                child: Text("Batsman",style: fontRegular.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.pri,
                ),),
              ),
              SizedBox(width: 5.w,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("R",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                    Text("B",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                    Text("4s",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                    Text("6s",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                    Text("SR",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          ListView.separated(
            shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, _) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 0.5.h),
                  child: const DottedLine(
                    dashColor: Color(0xffD2D2D2),
                  ),
                );
              },
              itemCount: itemList.length,
              itemBuilder: (BuildContext, int index) {
                final item = itemList[index];
                return Row(
                  children: [
                    SizedBox(
                      width: 35.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Prasanth",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                              SizedBox(width: 1.w,),
                              SvgPicture.asset(Images.batIcon,width: 4.w,color: AppColor.blackColour,),
                            ],
                          ),
                          SizedBox(height: 0.5.h,),
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: ("c Lasith malinga\n"),
                                    style: fontRegular.copyWith(
                                      fontSize: 11.sp,
                                        color: const Color(0xff777777),
                                    )),
                                TextSpan(
                                    text: "b Sachin tendulkar",
                                    style: fontRegular.copyWith(
                                        fontSize: 11.sp,
                                        color: const Color(0xff777777)
                                    )),
                              ])),
                          SizedBox(height: 1.h,),
                        ],
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("129",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff777777),
                          ),),
                          Text("50",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff777777),
                          ),),
                          Text("10",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff777777),
                          ),),
                          Text("10",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff777777),
                          ),),
                          Text("200",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff777777),
                          ),),
                        ],
                      ),
                    ),
                  ],
                );
              }),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          Row(
            children: [
              SizedBox(
                width: 35.w,
                child: Text("Extras:",style: fontRegular.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.blackColour,
                ),),
              ),
              const Spacer(),
              Row(
                children: [
                  Text("9",style: fontMedium.copyWith(
                    fontSize: 12.sp,
                    color: AppColor.blackColour,
                  ),),
                  SizedBox(width: 2.w,),
                  Text("2lb,",style: fontRegular.copyWith(
                    fontSize: 12.sp,
                    color: const Color(0xff777777),
                  ),),
                  SizedBox(width: 2.w,),
                  Text("4w,",style: fontRegular.copyWith(
                    fontSize: 12.sp,
                    color: const Color(0xff777777),
                  ),),
                  SizedBox(width: 2.w,),
                  Text("1nb",style: fontRegular.copyWith(
                    fontSize: 12.sp,
                    color: const Color(0xff777777),
                  ),),
                ],
              ),
            ],
          ),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          SizedBox(height: 1.h,),



          //yet to bat
          Row(
            children: [
              Text("Yet to bat",style: fontMedium.copyWith(
                fontSize: 14.sp,
                color: AppColor.blackColour,
              ),),
              SizedBox(width: 1.w,),
              SvgPicture.asset(Images.helmetIcon,width: 5.w,),
            ],
          ),
         SizedBox(height: 1.h,),
         GridView.builder(
           physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 1 column
        childAspectRatio: 2.5, // Adjust the aspect ratio as needed
      ),
      itemCount: gridList.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        final item = gridList[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           ClipOval(child: Image.asset(Images.profileImage,width: 12.w,)),
            SizedBox(width: 2.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30.w,
                  child: Text("Sachin",style: fontRegular.copyWith(
                    fontSize: 12.sp,
                    color: AppColor.blackColour,
                  ),),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColor.pri,
                      radius: 4,
                    ),
                    SizedBox(width: 1.w,),
                    Text("RHB",style: fontRegular.copyWith(
                      fontSize: 11.sp,
                      color: Color(0xff666666)
                    ),),


                  ],
                )
              ],
            ),

          ],
        );
      },
    ),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          SizedBox(height: 2.h,),



          //bowling
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
          SizedBox(height: 1.h,),
          Row(
            children: [
              SizedBox(
                width: 35.w,
                child: Text("Bowling",style: fontRegular.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.pri,
                ),),
              ),
              SizedBox(width: 5.w,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("O",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                    Text("M",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                    Text("R",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                    Text("W",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                    Text("Eco",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, _) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 0.5.h),
                  child: const DottedLine(
                    dashColor: Color(0xffD2D2D2),
                  ),
                );
              },
              itemCount: itemsList.length,
              itemBuilder: (BuildContext, int index) {
                final item = itemsList[index];
                return Row(
                  children: [
                    SizedBox(
                      width: 35.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(top: 0.5.h,bottom: 0.5.h),
                                child: Text("Prasanth",style: fontRegular.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.blackColour,
                                ),),
                              ),
                              SizedBox(width: 1.w,),
                              SvgPicture.asset(Images.ballBlackIcon,width: 4.w,color: AppColor.blackColour,),
                            ],
                          ),
                          SizedBox(height: 1.h,),
                        ],
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("2.0",style: fontMedium.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackColour,
                          ),),
                          Text("1",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff777777),
                          ),),
                          Text("8",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff777777),
                          ),),
                          Text("2",style: fontMedium.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackColour,
                          ),),
                          Text("2.00",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff777777),
                          ),),
                        ],
                      ),
                    ),
                  ],
                );
              }),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          SizedBox(height: 2.h,),



          //fall of wickets
          Row(
            children: [
              Text("Fall of wickets",style: fontMedium.copyWith(
                fontSize: 14.sp,
                color: AppColor.blackColour,
              ),),
              SizedBox(width: 1.w,),
              SvgPicture.asset(Images.stupmsIconss,width: 5.w,),
            ],
          ),
          SizedBox(height: 1.h,),
          Row(
            children: [
              SizedBox(
                width: 50.w,
                child: Text("Bowling",style: fontRegular.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.pri,
                ),),
              ),
              SizedBox(width: 5.w,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Score",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                    Text("Over",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, _) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 0.5.h),
                  child: const DottedLine(
                    dashColor: Color(0xffD2D2D2),
                  ),
                );
              },
              itemCount: itemsList.length,
              itemBuilder: (BuildContext, int index) {
                final item = itemsList[index];
                return Row(
                  children: [
                    SizedBox(
                      width: 50.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(top: 0.5.h,bottom: 0.5.h),
                                child: Text("Prasanth",style: fontRegular.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.blackColour,
                                ),),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h,),
                        ],
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("2-0",style: fontMedium.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackColour,
                          ),),
                          Text("1.0",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff777777),
                          ),),
                        ],
                      ),
                    ),
                  ],
                );
              }),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          SizedBox(height: 2.h,),


          //patrnership
          Row(
            children: [
              Text("Partnerships",style: fontMedium.copyWith(
                fontSize: 14.sp,
                color: AppColor.blackColour,
              ),),
              SizedBox(width: 1.w,),
              SvgPicture.asset(Images.partnerShipIcon,width: 5.w,),
            ],
          ),
          SizedBox(height: 1.h,),
          Row(
            children: [
              Text("Batsman 1",style: fontRegular.copyWith(
                fontSize: 12.sp,
                color: AppColor.pri,
              ),),
            Spacer(),
              Text("Batsman 2",style: fontRegular.copyWith(
                fontSize: 12.sp,
                color: AppColor.pri,
              ),),


            ],
          ),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, _) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 0.5.h),
                  child: const DottedLine(
                    dashColor: Color(0xffD2D2D2),
                  ),
                );
              },
              itemCount: itemsList.length,
              itemBuilder: (BuildContext, int index) {
                final item = itemsList[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: 0.5.h,bottom: 1.h),
                      child: Row(
                        children: [
                          Text("1st",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: Color(0xff666666)
                          ),),
                          SizedBox(width: 1.w,),
                          Text("Wicket",style: fontRegular.copyWith(
                              fontSize: 12.sp,
                              color: Color(0xff666666)
                          ),),

                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 0.5.h,bottom: 1.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text("Prasanth",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                              SizedBox(height: 0.5.h),
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: ("14"),
                                        style: fontMedium.copyWith(
                                          fontSize: 11.sp,
                                          color: AppColor.blackColour
                                        )),
                                    TextSpan(
                                        text: "(7)",
                                        style: fontRegular.copyWith(
                                            fontSize: 11.sp,
                                            color: const Color(0xff666666)
                                        )),
                                  ])),
                            ],
                          ),
                          Column(
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: ("14"),
                                        style: fontMedium.copyWith(
                                            fontSize: 11.sp,
                                            color: AppColor.blackColour
                                        )),
                                    TextSpan(
                                        text: "(7)",
                                        style: fontRegular.copyWith(
                                            fontSize: 11.sp,
                                            color: const Color(0xff666666)
                                        )),
                                  ])),
                              SizedBox(height: 0.5.h),
                              Container(
                                height:1.h,
                                width:10.w,
                                decoration: BoxDecoration(
                                  color: AppColor.pri,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Prasanth",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                              SizedBox(height: 0.5.h),
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: ("14"),
                                        style: fontMedium.copyWith(
                                            fontSize: 11.sp,
                                            color: AppColor.blackColour
                                        )),
                                    TextSpan(
                                        text: "(7)",
                                        style: fontRegular.copyWith(
                                            fontSize: 11.sp,
                                            color: const Color(0xff666666)
                                        )),
                                  ])),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                );
              }),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
    ],
      ),
    );
  }
}
