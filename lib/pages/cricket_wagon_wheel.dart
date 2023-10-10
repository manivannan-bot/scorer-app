import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ThreeCircles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // ClipOval(child: Image.network("https://i.pinimg.com/736x/25/16/fe/2516fe2678a70c7a4112367a67a4fe6f--grasses.jpg", fit: BoxFit.cover,
          // width: MediaQuery.of(context).size.width / 1, height: MediaQuery.of(context).size.height / 2.2,)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomPaint(
              painter: CirclePainter(),
              size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
              child: Center(
                child: Container(
                  width: 40,
                  height: 100,
                  color: Colors.orangeAccent,
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            width: 1.5,
            color: Colors.white,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: 1.5,
              color: Colors.white,
            ),
          ),
          Transform.rotate(
            angle: 45 * 3.14159 / 180,
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: 1.5,
              color: Colors.white,
            ),
          ),
          Transform.rotate(
            angle: 135 * 3.14159 / 180,
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: 1.5,
              color: Colors.white,
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2.6,
            top: MediaQuery.of(context).size.height / 2.6,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Short Third Man", context);
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
            left: MediaQuery.of(context).size.width / 3.4,
            top: MediaQuery.of(context).size.height / 2.2,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Point", context);
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
            left: MediaQuery.of(context).size.width / 1.9,
            top: MediaQuery.of(context).size.height / 2.6,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Fine Leg", context);
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
            right: MediaQuery.of(context).size.width / 3.6,
            top: MediaQuery.of(context).size.height / 2.2,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Square Leg", context);
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
            left: MediaQuery.of(context).size.width / 2.5,
            bottom: MediaQuery.of(context).size.height / 2.5,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Mid Off", context);
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
            left: MediaQuery.of(context).size.width / 3.6,
            bottom: MediaQuery.of(context).size.height / 2.15,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Cover", context);
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
            left: MediaQuery.of(context).size.width / 1.8,
            bottom: MediaQuery.of(context).size.height / 2.5,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Mid On", context);
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
            right: MediaQuery.of(context).size.width / 3.6,
            bottom: MediaQuery.of(context).size.height / 2.2,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Mid Wicket", context);
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
            right: MediaQuery.of(context).size.width / 3.1,
            bottom: MediaQuery.of(context).size.height / 3.1,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Long On", context);
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
            left: MediaQuery.of(context).size.width / 3.1,
            bottom: MediaQuery.of(context).size.height / 3.1,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Long Off", context);
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
            right: MediaQuery.of(context).size.width / 9,
            bottom: MediaQuery.of(context).size.height / 2.4,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Deep Mid Wicket", context);
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
            left: MediaQuery.of(context).size.width / 8,
            bottom: MediaQuery.of(context).size.height / 2.4,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Deep Cover", context);
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
            right: MediaQuery.of(context).size.width / 3.3,
            top: MediaQuery.of(context).size.height / 3,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Deep Fine Leg", context);
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
            left: MediaQuery.of(context).size.width / 3.2,
            top: MediaQuery.of(context).size.height / 3,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Third Man", context);
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
            right: MediaQuery.of(context).size.width / 9,
            top: MediaQuery.of(context).size.height / 2.4,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Deep Square Leg", context);
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
            left: MediaQuery.of(context).size.width / 8,
            top: MediaQuery.of(context).size.height / 2.4,
            child: GestureDetector(
              onTap: (){
                openConfirmDialog("Deep Point", context);
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
}

openConfirmDialog(String position, BuildContext context){
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text("Confirm Position?"),
      content: Text("You chose $position"),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          child: const Text("Ok"),
        ),
      ],
    ),
  );
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
