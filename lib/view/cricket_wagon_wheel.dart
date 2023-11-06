import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:sizer/sizer.dart';

class ThreeCircles extends StatefulWidget {
   final Function(int) onOkButtonPressed;
  ThreeCircles({super.key, required this.onOkButtonPressed}) ;

  @override
  State<ThreeCircles> createState() => _ThreeCirclesState();
}

class _ThreeCirclesState extends State<ThreeCircles> {
  int? fieldType=0;

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
                  height: 10.h,
                  color: Colors.orangeAccent,
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
          //horizondal line
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
            left: width / 2.6,
            top: height / 2.6,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Short Third Man",1, context);
              },
              child: const Text("SHORT\nTHIRD\nMAN",
                textAlign: TextAlign.center,
                style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w700
              ),),
            ),
          ),
          Positioned(
            left: width / 3.4,
            top: height / 2.2,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Point",2, context);
              },
              child: const Text("POINT",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                ),),
            ),
          ),
          Positioned(
            left: width / 1.9,
            top: height / 2.6,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Fine Leg",3, context);
              },
              child: const Text("FINE\nLEG",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                ),),
            ),
          ),
          Positioned(
            right: width / 3.6,
            top: height / 2.2,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Square Leg",4, context);
              },
              child: const Text("SQUARE\nLEG",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                ),),
            ),
          ),

          Positioned(
            left: width / 2.5,
            bottom: height / 2.5,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Mid Off",5, context);
              },
              child: const Text("MID\nOFF",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                ),),
            ),
          ),
          Positioned(
            left: width / 3.6,
            bottom: height / 2.15,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Cover",6, context);
              },
              child: const Text("COVER",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                ),),
            ),
          ),
          Positioned(
            left: width / 1.8,
            bottom: height / 2.5,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Mid On",7, context);
              },
              child: const Text("MID\nON",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                ),),
            ),
          ),
          Positioned(
            right: width / 3.6,
            bottom: height / 2.2,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Mid Wicket",8, context);
              },
              child: const Text("MID\nWICKET",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                ),),
            ),
          ),
          //OUTER CIRCLE

          Positioned(
            right: width / 3.1,
            bottom: height / 3.1,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Long On",9, context);
              },
              child: const Text("LONG\nON",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                ),),
            ),
          ),
          Positioned(
            left: width / 3.1,
            bottom: height / 3.1,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Long Off",10, context);
              },
              child: const Text("LONG\nOFF",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                ),),
            ),
          ),
          Positioned(
            right: width / 9,
            bottom: height / 2.4,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Deep Mid Wicket",11, context);
              },
              child: const Text("DEEP MID\nWICKET",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                ),),
            ),
          ),
          Positioned(
            left: width / 8,
            bottom: height / 2.4,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Deep Cover",12, context);
              },
              child: const Text("DEEP\nCOVER",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                ),),
            ),
          ),

          Positioned(
            right: width / 3.3,
            top: height / 3,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Deep Fine Leg",13, context);
              },
              child: const Text("DEEP FINE\nLEG",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                ),),
            ),
          ),
          Positioned(
            left: width / 3.2,
            top: height / 3,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Third Man",14, context);
              },
              child: const Text("THIRD\nMAN",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                ),),
            ),
          ),
          Positioned(
            right: width / 9,
            top: height / 2.4,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Deep Square Leg",15, context);
              },
              child: const Text("DEEP\nSQUARE\nLEG",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                ),),
            ),
          ),
          Positioned(
            left: width / 8,
            top: height / 2.4,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Deep Point",16, context);
              },
              child: const Text("DEEP\nPOINT",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                ),),
            ),
          ),
        ],
      ),
    );
  }

  openConfirmDialog(String position,int fieldType, BuildContext context){
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Position?"),
        content: Text("You chose $position"),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              widget.onOkButtonPressed(fieldType);
              Navigator.of(ctx).pop();
            },
            child: const Text("Ok"),
          ),
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

    // final image = await loadImageFromNetwork("https://i.pinimg.com/736x/25/16/fe/2516fe2678a70c7a4112367a67a4fe6f--grasses.jpg");
    // final srcRect = Offset(image.width.toDouble(), image.height.toDouble());
    // final dstRect = Rect.fromLTWH(0, 0, size.width, size.height);
    // canvas.drawImage(image, srcRect, Paint());


    final greenPaint = Paint()
      ..color = Colors.lightGreen
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

  // Future<ui.Image> loadImageFromNetwork(String imageUrl) async {
  //   final completer = Completer<ui.Image>();
  //   final img = NetworkImage(imageUrl);
  //   img.resolve(const ImageConfiguration()).addListener(
  //       (ImageStreamListener((ImageInfo info, bool _) => completer.complete(info.image))));
  //   return completer.future;
  // }

}
