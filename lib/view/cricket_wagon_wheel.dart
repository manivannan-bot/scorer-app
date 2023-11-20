import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scorer/utils/sizes.dart';
import 'package:scorer/widgets/ok_btn.dart';
import 'dart:ui' as ui;

import 'package:sizer/sizer.dart';

class ThreeCircles extends StatefulWidget {
  final Function(int) onOkButtonPressed;
  const ThreeCircles({super.key, required this.onOkButtonPressed}) ;

  @override
  State<ThreeCircles> createState() => _ThreeCirclesState();
}

class _ThreeCirclesState extends State<ThreeCircles> {
  int? fieldType=0;

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomPaint(
            painter: CirclePainter(),
            size: Size(width, height),
            child: Center(
              child: Container(
                width: 7.w,
                height: 7.h,
                color: const Color(0xffFFCD78),
              ),
            ),
          ),
        ),
        //vertical line
        Container(
          height: height / 2.5,
          width: 1.5,
          color: Colors.white,
        ),
        //horizontal line
        RotatedBox(
          quarterTurns: 3,
          child: Container(
            height: height / 2.5,
            width: 1.5,
            color: Colors.white,
          ),
        ),
        //left cross line
        Transform.rotate(
          angle: 45 * 3.14159 / 180,
          child: Container(
            height: height / 2.5,
            width: 1.5,
            color: Colors.white,
          ),
        ),
        //right cross line
        Transform.rotate(
          angle: 135 * 3.14159 / 180,
          child: Container(
            height: height / 2.5,
            width: 1.5,
            color: Colors.white,
          ),
        ),
        Positioned(
          left: width / 2.9,
          top: height / 6.2,
          child: GestureDetector(
            onTap: (){
              openConfirmDialog("Short Third Man",1, context);
            },
            child: Text("SHORT\nTHIRD\nMAN",
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 8.sp,
                  color: Colors.white,
              ),),
          ),
        ),
        Positioned(
          left: width / 3.7,
          bottom: height / 3.8,
          child: GestureDetector(
            onTap: (){
              openConfirmDialog("Point",2, context);
            },
            child: Text("POINT",
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 8.sp,
                  color: Colors.white,
              ),),
          ),
        ),
        Positioned(
          left: width / 2.1,
          top: height / 6,
          child: GestureDetector(
            onTap: (){
              openConfirmDialog("Fine Leg",3, context);
            },
            child: Text("FINE\nLEG",
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 8.sp,
                  color: Colors.white,
              ),),
          ),
        ),
        Positioned(
          right: width / 4,
          top: height / 4.8,
          child: GestureDetector(
            onTap: (){
              openConfirmDialog("Square Leg",4, context);
            },
            child: Text("SQUARE\nLEG",
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 8.sp,
                  color: Colors.white,
              ),),
          ),
        ),

        Positioned(
          right: width / 2.1,
          bottom: height / 6.2,
          child: GestureDetector(
            onTap: (){
              openConfirmDialog("Mid Off",5, context);
            },
            child: Text("MID\nOFF",
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 8.sp,
                  color: Colors.white,
              ),),
          ),
        ),
        Positioned(
          left: width / 3.8,
          bottom: height / 4.7,
          child: GestureDetector(
            onTap: (){
              openConfirmDialog("Cover",6, context);
            },
            child: Text("COVER",
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 8.sp,
                  color: Colors.white,
              ),),
          ),
        ),
        Positioned(
          left: width / 2.1,
          bottom: height / 6.1,
          child: GestureDetector(
            onTap: (){
              openConfirmDialog("Mid On",7, context);
            },
            child: Text("MID\nON",
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 8.sp,
                  color: Colors.white,
              ),),
          ),
        ),
        Positioned(
          right: width / 4.1,
          bottom: height / 4.9,
          child: GestureDetector(
            onTap: (){
              openConfirmDialog("Mid Wicket",8, context);
            },
            child: Text("MID\nWICKET",
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 8.sp,
                  color: Colors.white,
              ),),
          ),
        ),
        //OUTER CIRCLE

        Positioned(
          right: width / 3.5,
          bottom: height / 10,
          child: GestureDetector(
            onTap: (){
              openConfirmDialog("Long On",9, context);
            },
            child: Text("LONG\nON",
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 8.sp,
                  color: Colors.white,
              ),),
          ),
        ),
        Positioned(
          left: width / 3.5,
          bottom: height / 10,
          child: GestureDetector(
            onTap: (){
              openConfirmDialog("Long Off",10, context);
            },
            child: Text("LONG\nOFF",
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 8.sp,
                  color: Colors.white,
              ),),
          ),
        ),
        Positioned(
          right: width / 9,
          bottom: height / 6,
          child: GestureDetector(
            onTap: (){
              openConfirmDialog("Deep Mid Wicket",11, context);
            },
            child: Text("DEEP MID\nWICKET",
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 8.sp,
                  color: Colors.white,
              ),),
          ),
        ),
        Positioned(
          left: width / 8,
          bottom: height / 5.5,
          child: GestureDetector(
            onTap: (){
              openConfirmDialog("Deep Cover",12, context);
            },
            child: Text("DEEP\nCOVER",
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 8.sp,
                  color: Colors.white,
              ),),
          ),
        ),

        Positioned(
          right: width / 3.7,
          top: height / 10,
          child: GestureDetector(
            onTap: (){
              openConfirmDialog("Deep Fine Leg",13, context);
            },
            child: Text("DEEP FINE\nLEG",
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 8.sp,
                  color: Colors.white,
              ),),
          ),
        ),
        Positioned(
          left: width / 3.2,
          top: height / 10,
          child: GestureDetector(
            onTap: (){
              openConfirmDialog("Third Man",14, context);
            },
            child: Text("THIRD\nMAN",
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 8.sp,
                  color: Colors.white,
              ),),
          ),
        ),
        Positioned(
          right: width / 9,
          top: height / 5.4,
          child: GestureDetector(
            onTap: (){
              openConfirmDialog("Deep Square Leg",15, context);
            },
            child: Text("DEEP\nSQUARE\nLEG",
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 8.sp,
                  color: Colors.white,
              ),),
          ),
        ),
        Positioned(
          left: width / 8,
          top: height / 5.5,
          child: GestureDetector(
            onTap: (){
              openConfirmDialog("Deep Point",16, context);
            },
            child: Text("DEEP\nPOINT",
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 8.sp,
                  color: Colors.white,
              ),),
          ),
        ),
      ],
    );
  }

  openConfirmDialog(String position,int fieldType, BuildContext context){
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: 5.w
        ),
        title: const Text("Confirm Position?"),
        content: Text("You chose $position"),
        actions: <Widget>[
          InkWell(
              onTap: (){
                widget.onOkButtonPressed(fieldType);
                Navigator.of(ctx).pop();
              },
              child: const OkBtn("Ok")),
        ],
      ),
    );
  }

}


class CirclePainter extends CustomPainter {
  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;
    final innerRadius = size.width / 2 - 50;

    final greenPaint = Paint()
      ..color = const Color(0xff4DB14F)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, outerRadius, greenPaint);

    final outerPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final innerPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, outerRadius - 20, outerPaint);
    canvas.drawCircle(center, innerRadius - 35, innerPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}
