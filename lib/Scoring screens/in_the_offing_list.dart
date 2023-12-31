import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import '../widgets/do_scoring_btn.dart';


class InTheOffingScreenList extends StatefulWidget {
  const InTheOffingScreenList({super.key});

  @override
  State<InTheOffingScreenList> createState() => _InTheOffingScreenListState();
}

class _InTheOffingScreenListState extends State<InTheOffingScreenList> {
  final List<Map<String,dynamic>>itemList=[
    {},{},
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, _) {
          return Padding(
            padding: EdgeInsets.only(bottom: 2.h),
          );
        },
        itemCount:itemList!.length ,
        itemBuilder: (context, int index) {
          final item = itemList![index];
          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: 3.w),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColor.lightColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(left: 2.w,top: 1.h),
                                child: Row(
                                  children: [
                                    Image.asset(Images.teamaLogo,width: 10.w,),
                                    SizedBox(width: 2.w,),
                                    Text(
                                       "T&T",
                                        style: fontMedium.copyWith(
                                          fontSize: 13.sp,
                                          color: AppColor.pri,
                                        )
                                    ),
                                    SizedBox(width: 2.w,),
                                    RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "28",
                                              style: fontMedium.copyWith(
                                                fontSize: 13.sp,
                                                color: AppColor.pri,
                                              )),
                                          TextSpan(
                                              text: "/",
                                              style: fontMedium.copyWith(
                                                  fontSize: 13.sp,
                                                  color: AppColor.pri
                                              )),
                                          TextSpan(
                                              text: "0",
                                              style: fontMedium.copyWith(
                                                  fontSize: 13.sp,
                                                  color: AppColor.pri
                                              )),
                                        ])),
                                    SizedBox(width: 2.w,),
                                    RichText(text: TextSpan(children: [
                                      TextSpan(
                                          text: "0.0",
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: const Color(0xff444444)
                                          )),
                                      TextSpan(
                                          text: "/",
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: const Color(0xff444444)
                                          )),
                                      TextSpan(
                                          text: "20",
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: const Color(0xff444444)
                                          )),
                                    ])),
                                    SizedBox(width: 1.w,),
                                    SvgPicture.asset(Images.batIcon,width: 5.w,),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 2.w,top: 1.h),
                                child: Row(
                                  children: [
                                    Image.asset(Images.teamblogo,width: 10.w,fit: BoxFit.fill,),
                                    SizedBox(width: 2.w,),
                                    Text("DCC", style: fontMedium.copyWith(
                                      fontSize: 13.sp,
                                      color:const Color(0xff555555),
                                    ),),
                                    SizedBox(width: 2.w,),
                                    // (matchlist![index].currentInnings==2)?
                                    // Row(children: [
                                    //   RichText(
                                    //       text: TextSpan(children: [
                                    //         TextSpan(
                                    //             text: ('${matchlist![index].teams![1].totalRuns??''}'),
                                    //             style: fontMedium.copyWith(
                                    //               fontSize: 13.sp,
                                    //               color: AppColor.pri,
                                    //             )),
                                    //         TextSpan(
                                    //             text: "/",
                                    //             style: fontMedium.copyWith(
                                    //                 fontSize: 13.sp,
                                    //                 color: AppColor.pri
                                    //             )),
                                    //         TextSpan(
                                    //             text: ("${matchlist![index].teams![1].totalWickets??''}"),
                                    //             style: fontMedium.copyWith(
                                    //                 fontSize: 13.sp,
                                    //                 color: AppColor.pri
                                    //             )),
                                    //       ])),
                                    //   SizedBox(width: 2.w,),
                                    //   RichText(text: TextSpan(children: [
                                    //     TextSpan(
                                    //         text: ("${matchlist![index].teams![1].currentOverDetails??'0'}"),
                                    //         style: fontMedium.copyWith(
                                    //             fontSize: 13.sp,
                                    //             color: const Color(0xff444444)
                                    //         )),
                                    //     TextSpan(
                                    //         text: "/",
                                    //         style: fontMedium.copyWith(
                                    //             fontSize: 13.sp,
                                    //             color: const Color(0xff444444)
                                    //         )),
                                    //     TextSpan(
                                    //         text: ("${matchlist![index].overs}"),
                                    //         style: fontMedium.copyWith(
                                    //             fontSize: 13.sp,
                                    //             color: const Color(0xff444444)
                                    //         )),
                                    //   ])),
                                    //   SizedBox(width: 1.w,),
                                    // ],):Text("Yet to bat", style: fontRegular.copyWith(
                                    //   fontSize: 12.sp,
                                    //   color:const Color(0xff666666),
                                    // ),),
                                    Text("Yet to bat", style: fontRegular.copyWith(
                                      fontSize: 12.sp,
                                      color:const Color(0xff666666),
                                    ),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: 2.h),
                            child: Dash(
                                direction: Axis.vertical,
                                length: 6.h,
                                dashGap: 1,
                                dashLength: 5,
                                dashColor: const Color(0xffEFEAEA)),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(right: 6.w),
                                child: Container(
                                  padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                                  decoration:  BoxDecoration(
                                      color: AppColor.primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(Images.liveIcon,width: 2.5.w,),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text("Live",style: fontRegular.copyWith(
                                        fontSize: 10.5.sp,
                                        color: const Color(0xff444444),
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h,),
                      const DottedLine(
                        dashColor: Color(0xffD2D2D2),
                      ),
                      SizedBox(height: 1.h,),
                      //toss line
                      Padding(
                        padding:  EdgeInsets.only(left: 2.w,bottom: 1.h),
                        child: Text("Toss and tails won the toss choose to bat",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.pri
                        ),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });;
  }
}
