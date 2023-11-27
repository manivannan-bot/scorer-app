import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/view/widgets/pitch_container.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class SetBallPitchArea extends StatefulWidget {
  final bool rightHandBatsman;
  final Function(int) onChooseArea;
  const SetBallPitchArea(this.rightHandBatsman, this.onChooseArea, {super.key});

  @override
  State<SetBallPitchArea> createState() => _SetBallPitchAreaState();
}

class _SetBallPitchAreaState extends State<SetBallPitchArea> {

  int? selectedPitchArea;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.7],
              colors: [
                Color(0xff4DB14F),
                Color(0xff216A28),
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 15.w,
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                      child: Center(
                        child: Text(
                          'F.TOSS',
                          style: fontMedium.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                      child: Center(
                        child: Text(
                          'YORKER',
                          style: fontMedium.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                      child: Center(
                        child: Text(
                          'FULL',
                          style: fontMedium.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                      child: Center(
                        child: Text(
                          'GOOD',
                          style: fontMedium.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                      child: Center(
                        child: Text(
                          'SHORT',
                          style: fontMedium.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 1.w,),
              Column(
                children: [
                  //full toss
                  Row(
                    children: [
                      InkWell(
                          onTap:(){
                            if(widget.rightHandBatsman){
                              setState(() {
                                selectedPitchArea = 1;
                              });
                              widget.onChooseArea(1);
                            } else {
                              setState(() {
                                selectedPitchArea = 3;
                              });
                              widget.onChooseArea(3);
                            }
                          },
                          child: PitchContainer(12.w, 5.h, Colors.grey, selectedPitchArea, widget.rightHandBatsman ? 1 : 3)),
                      InkWell(
                          onTap:(){
                            setState(() {
                              selectedPitchArea = 2;
                            });
                            widget.onChooseArea(2);
                          },
                          child: PitchContainer(12.w, 5.h, Colors.grey, selectedPitchArea, 2)),
                      InkWell(
                          onTap:(){
                            if(widget.rightHandBatsman){
                              setState(() {
                                selectedPitchArea = 3;
                              });
                              widget.onChooseArea(3);
                            } else {
                              setState(() {
                                selectedPitchArea = 1;
                              });
                              widget.onChooseArea(1);
                            }
                          },
                          child: PitchContainer(12.w, 5.h, Colors.grey, selectedPitchArea, widget.rightHandBatsman ? 3 : 1)),
                    ],
                  ),
                  //yorker
                  Row(
                    children: [
                      InkWell(
                          onTap:(){
                            if(widget.rightHandBatsman){
                              setState(() {
                                selectedPitchArea = 4;
                              });
                              widget.onChooseArea(4);
                            } else {
                              setState(() {
                                selectedPitchArea = 6;
                              });
                              widget.onChooseArea(6);
                            }
                          },
                          child: PitchContainer(12.w, 5.h, const Color(0xffF7B199), selectedPitchArea, widget.rightHandBatsman ? 4 : 6)),
                      InkWell(
                          onTap:(){
                            setState(() {
                              selectedPitchArea = 5;
                            });
                            widget.onChooseArea(5);
                          },
                          child: PitchContainer(12.w, 5.h, const Color(0xffF7B199), selectedPitchArea, 5)),
                      InkWell(
                          onTap:(){
                            if(widget.rightHandBatsman){
                              setState(() {
                                selectedPitchArea = 6;
                              });
                              widget.onChooseArea(6);
                            } else {
                              setState(() {
                                selectedPitchArea = 4;
                              });
                              widget.onChooseArea(4);
                            }
                          },
                          child: PitchContainer(12.w, 5.h, const Color(0xffF7B199), selectedPitchArea, widget.rightHandBatsman ? 6 : 4)),
                    ],
                  ),
                  //full
                  Row(
                    children: [
                      InkWell(
                          onTap:(){
                            if(widget.rightHandBatsman){
                              setState(() {
                                selectedPitchArea = 7;
                              });
                              widget.onChooseArea(7);
                            } else {
                              setState(() {
                                selectedPitchArea = 9;
                              });
                              widget.onChooseArea(9);
                            }
                          },
                          child: PitchContainer(12.w, 7.h, const Color(0xffF48F6D), selectedPitchArea, widget.rightHandBatsman ? 7 : 9)),
                      InkWell(
                          onTap:(){
                            setState(() {
                              selectedPitchArea = 8;
                            });
                            widget.onChooseArea(8);
                          },
                          child: PitchContainer(12.w, 7.h, const Color(0xffF48F6D), selectedPitchArea, 8)),
                      InkWell(
                          onTap:(){
                            if(widget.rightHandBatsman){
                              setState(() {
                                selectedPitchArea = 9;
                              });
                              widget.onChooseArea(9);
                            } else {
                              setState(() {
                                selectedPitchArea = 7;
                              });
                              widget.onChooseArea(7);
                            }
                          },
                          child: PitchContainer(12.w, 7.h, const Color(0xffF48F6D), selectedPitchArea, widget.rightHandBatsman ? 9 : 7)),
                    ],
                  ),
                  //good
                  Row(
                    children: [
                      InkWell(
                          onTap:(){
                            if(widget.rightHandBatsman){
                              setState(() {
                                selectedPitchArea = 10;
                              });
                              widget.onChooseArea(10);
                            } else {
                              setState(() {
                                selectedPitchArea = 12;
                              });
                              widget.onChooseArea(12);
                            }
                          },
                          child: PitchContainer(12.w, 5.h, const Color(0xffBC8BA0), selectedPitchArea, widget.rightHandBatsman ? 10 : 12)),
                      InkWell(
                          onTap:(){
                            setState(() {
                              selectedPitchArea = 11;
                            });
                            widget.onChooseArea(11);
                          },
                          child: PitchContainer(12.w, 5.h, const Color(0xffBC8BA0), selectedPitchArea, 11)),
                      InkWell(
                          onTap:(){
                            if(widget.rightHandBatsman){
                              setState(() {
                                selectedPitchArea = 12;
                              });
                              widget.onChooseArea(12);
                            } else {
                              setState(() {
                                selectedPitchArea = 10;
                              });
                              widget.onChooseArea(10);
                            }
                          },
                          child: PitchContainer(12.w, 5.h, const Color(0xffBC8BA0), selectedPitchArea, widget.rightHandBatsman ? 12 : 10)),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap:(){
                            if(widget.rightHandBatsman){
                              setState(() {
                                selectedPitchArea = 13;
                              });
                              widget.onChooseArea(13);
                            } else {
                              setState(() {
                                selectedPitchArea = 15;
                              });
                              widget.onChooseArea(15);
                            }
                          },
                          child: PitchContainer(12.w, 15.h, const Color(0xffCAB59A), selectedPitchArea, widget.rightHandBatsman ? 13 : 15)),
                      InkWell(
                          onTap:(){
                            setState(() {
                              selectedPitchArea = 14;
                            });
                            widget.onChooseArea(14);
                          },
                          child: PitchContainer(12.w, 15.h, const Color(0xffCAB59A), selectedPitchArea, 14)),
                      InkWell(
                          onTap:(){
                            if(widget.rightHandBatsman){
                              setState(() {
                                selectedPitchArea = 15;
                              });
                              widget.onChooseArea(15);
                            } else {
                              setState(() {
                                selectedPitchArea = 13;
                              });
                              widget.onChooseArea(13);
                            }
                          },
                          child: PitchContainer(12.w, 15.h, const Color(0xffCAB59A), selectedPitchArea, widget.rightHandBatsman ? 15 : 13)),
                    ],
                  ),
                  Row(
                    children: [
                      PitchContainer(45.w, 5.h, Colors.grey, selectedPitchArea, 0),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 1.w,),
              SizedBox(
                width: 15.w,
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 2.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w,
                                vertical: 0.25.h
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white, // White background
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                '0m',
                                style: fontMedium.copyWith(
                                  fontSize: 8.sp,
                                  color: Colors.black, // Black text color
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 2.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w,
                                vertical: 0.2.h
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white, // White background
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                '3m',
                                style: fontMedium.copyWith(
                                  fontSize: 8.sp,
                                  color: Colors.black, // Black text color
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 2.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w,
                                vertical: 0.2.h
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white, // White background
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                '6m',
                                style: fontMedium.copyWith(
                                  fontSize: 8.sp,
                                  color: Colors.black, // Black text color
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 2.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w,
                                vertical: 0.2.h
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white, // White background
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                '8m',
                                style: fontMedium.copyWith(
                                  fontSize: 8.sp,
                                  color: Colors.black, // Black text color
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 2.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w,
                                vertical: 0.2.h
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white, // White background
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                '10m',
                                style: fontMedium.copyWith(
                                  fontSize: 8.sp,
                                  color: Colors.black, // Black text color
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: -3.h,
            child: SvgPicture.asset(Images.stumpImage)),
        Positioned(
            bottom: 0.0,
            child: SvgPicture.asset(Images.stumpImage)),
        Positioned(
          top: -30.0,
          left: 30.w,
          child: Text(widget.rightHandBatsman ? "OFF" : "LEG",
            style: fontMedium.copyWith(
                fontSize: 12.sp,
                color: AppColor.textColor
            ),),
        ),
        Positioned(
          top: -30.0,
          right: 30.w,
          child: Text(widget.rightHandBatsman ? "LEG" : "OFF",
            style: fontMedium.copyWith(
                fontSize: 12.sp,
                color: AppColor.textColor
            ),),
        ),
      ],
    );
  }
}
