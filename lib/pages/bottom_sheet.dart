import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scorer/models/scoring_detail_response_model.dart';
import 'package:sizer/sizer.dart';

import '../models/score_update_request_model.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import 'cricket_wagon_wheel.dart';

class ScoreBottomSheet extends StatefulWidget {
  final int run;
  final Data data;
  const ScoreBottomSheet(this.run, this.data, {super.key});

  @override
  State<ScoreBottomSheet> createState() => _ScoreBottomSheetState();
}

class _ScoreBottomSheetState extends State<ScoreBottomSheet> {
  ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();


  List<Color> rowColors = [
    Color(0xff797873),
    Color(0xffF7B199),
    Color(0xffF48F6D),
    Color(0xffBC8BA0),
    Color(0xffCAB59A),
  ];

  int selectedRow = -1;
  int selectedColumn = -1;


  List<String> partNumbers = List.generate(8, (index) => 'Part ${index + 1}');
  String tappedPart = ''; // Initialize with an empty string

  void onTap(int partNumberIndex) {
    setState(() {
      tappedPart = partNumbers[partNumberIndex];
    });
    print('Tapped on $tappedPart');
  }

  @override
  Widget build(BuildContext context) {
    bool _isSwitch = false;
    double screenHeight = MediaQuery.of(context).size.height;
    double sheetHeight = screenHeight * 0.9;
    if(widget.data.batting!.isEmpty){
      return const Center(child: Text('Please Select Batsman'));
    }
    if(widget.data.bowling ==null){
      return const Center(child: Text('Please Select Bowler'));
    }
    return Container(
      height: sheetHeight,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30))),
      child: ListView(
          shrinkWrap:
              true, // Allow the ListView to take only the required space
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      "Shot and Pitching Area",
                      style: fontMedium.copyWith(
                        fontSize: 18.sp,
                        color: AppColor.textColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: 100.w,
                  height: 2,
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    const Text(
                      'Wagon Wheel',
                      style: TextStyle(fontSize: 24),
                    ),
                    Spacer(),
                    const Text(
                      '4s & 6s',
                      style: TextStyle(color: AppColor.iconColour),
                    ),
                    Switch(value: _isSwitch, onChanged: (bool value) {}),
                  ],
                ),
                Container(
                  width: 600.0,
                  height: 100, // Adjust the width as needed
                  padding: EdgeInsets.all(20.0), // Spacing inside the card
                  decoration: BoxDecoration(
                    color: Colors.grey, // Grey background color
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Center(
                                  child: Text('Batsman Name',
                                      style: TextStyle(fontSize: 20))),
                            ],
                          ),
                          Column(
                            children: [
                              Center(
                                  child: Text(
                                'Runs',
                                style: TextStyle(fontSize: 20),
                              )),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                child: Center(
                                    child: Text('${widget.data.batting![0].playerName??'-'}',
                                        style: TextStyle(fontSize: 18))),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                child: Center(
                                    child: Text('${widget.data.batting![0].runsScored??'0'}',
                                        style: TextStyle(fontSize: 18))),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                const Row(
                  children: [
                    Text(
                      'skip match',
                      style: TextStyle(color: AppColor.iconColour),
                    ),
                    Spacer(),
                    Text(
                      'skip ball',
                      style: TextStyle(color: AppColor.iconColour),
                    )
                  ],
                ),

                SizedBox(
                  height: 550,
                  width:500,
                  child:Center(
                    child: ThreeCircles(),
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 2, // Button shadow
                    side: BorderSide(width: 1.0, color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Set the border radius to 12
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Images.undo,
                        height: 20,
                        width: 40,
                      ),
                      //Icon(Icons.undo, size: 24.0,color: Colors.black,), // Undo arrow icon
                      const SizedBox(
                          width: 4.0), // Spacing between icon and text
                      const Text('Undo',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black)), // "Undo" text
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  "Ball Pitching Area",
                  style: fontMedium.copyWith(
                    fontSize: 18.sp,
                    color: AppColor.textColor,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: 600.0,
                  height: 100, // Adjust the width as needed
                  padding: EdgeInsets.all(20.0), // Spacing inside the card
                  decoration: BoxDecoration(
                    color: Colors.grey, // Grey background color
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Center(
                                  child: Text('Bowler Name',
                                      style: TextStyle(fontSize: 20))),
                            ],
                          ),
                          Column(
                            children: [
                              Center(
                                  child: Text(
                                'Info',
                                style: TextStyle(fontSize: 20),
                              )),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Center(
                                  child: Text('${widget.data.bowling!.playerName??'-'}',
                                      style: TextStyle(fontSize: 18))),
                            ],
                          ),
                          Column(
                            children: [
                              Center(
                                  child: Text('${widget.data.bowling!.oversBowled}-${widget.data.bowling!.wickets}-${widget.data.bowling!.runsConceded}-${widget.data.bowling!.economy}',
                                      style: TextStyle(fontSize: 18))),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                const Row(
                  children: [
                    Text(
                      'skip match',
                      style: TextStyle(color: AppColor.iconColour),
                    ),
                    Spacer(),
                    Text(
                      'skip ball',
                      style: TextStyle(color: AppColor.iconColour),
                    )
                  ],
                ),
                Center(
                  widthFactor: 0.8.h,
                  child:  Container(
                    color: Colors.green,
                    child: SizedBox(
                      height: 500,
                      width: 310,
                      child:Column(
                        children: List.generate(5, // Number of rows
                              (rowIndex) => GestureDetector(
                            onTap: () {
                              setState(() {
                                // Update the selected cell and color it black
                                selectedRow = rowIndex;
                                selectedColumn = -1;
                              });
                            },
                            child: Row(
                              children: [
                                (rowIndex==0)? Row(
                                  children: [
                                    const SizedBox(
                                        width: 60,
                                        child: Text(
                                          'F.TOSS',
                                          style: TextStyle(color: Colors.white),
                                        )),

                                    Container(
                                      height: (rowIndex + 1) * 30.0,
                                      // Varying row heights
                                      color: rowColors[rowIndex],
                                      // Different row colors
                                      child: Row(
                                        children: List.generate(
                                          3, // Number of columns
                                              (columnIndex) {
                                            bool isSelected = rowIndex ==
                                                selectedRow &&
                                                columnIndex == selectedColumn;
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedRow = rowIndex;
                                                  selectedColumn = columnIndex;
                                                });
                                              },
                                              child: Container(
                                                width: 70.0,
                                                decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? Colors.black
                                                        : rowColors[rowIndex],
                                                    border: Border.all(width:1,color:Colors.white )
                                                ),

                                                // Change cell color to black when tapped
                                                child: Center(
                                                  child: Text(
                                                    'Cell $rowIndex-$columnIndex',
                                                    style: TextStyle(
                                                      color: isSelected ? Colors
                                                          .white : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    Container(
                                      width: 40, // Adjust the width as needed
                                      height: 20, // Adjust the height as needed
                                      decoration: const BoxDecoration(
                                        color: Colors.white, // White background
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              10), // Adjust the border radius as needed
                                          right: Radius.circular(
                                              10), // Adjust the border radius as needed
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '0m',
                                          style: TextStyle(
                                            color: Colors.black, // Black text color
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ):const Text(''),
                                (rowIndex==1)? Row(
                                  children: [
                                    const SizedBox(
                                        width: 60,
                                        child: Text(
                                          'YORKER',
                                          style: TextStyle(color: Colors.white),
                                        )),

                                    Container(
                                      height: (rowIndex + 1) * 30.0,
                                      // Varying row heights
                                      color: rowColors[rowIndex],
                                      // Different row colors
                                      child: Row(
                                        children: List.generate(
                                          3, // Number of columns
                                              (columnIndex) {
                                            bool isSelected = rowIndex ==
                                                selectedRow &&
                                                columnIndex == selectedColumn;
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedRow = rowIndex;
                                                  selectedColumn = columnIndex;
                                                });
                                              },
                                              child: Container(
                                                width: 70.0,
                                                decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? Colors.black
                                                        : rowColors[rowIndex],
                                                    border: Border.all(width:1,color:Colors.white )
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Cell $rowIndex-$columnIndex',
                                                    style: TextStyle(
                                                      color: isSelected ? Colors
                                                          .white : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    Container(
                                      width: 40, // Adjust the width as needed
                                      height: 20, // Adjust the height as needed
                                      decoration: const BoxDecoration(
                                        color: Colors.white, // White background
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              10), // Adjust the border radius as needed
                                          right: Radius.circular(
                                              10), // Adjust the border radius as needed
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '0m',
                                          style: TextStyle(
                                            color: Colors.black, // Black text color
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ):const Text(''),
                                (rowIndex==2)? Row(
                                  children: [
                                    const SizedBox(
                                        width: 60,
                                        child: Text(
                                          'FULL',
                                          style: TextStyle(color: Colors.white),
                                        )),

                                    Container(
                                      height: (rowIndex + 1) * 30.0,
                                      // Varying row heights
                                      color: rowColors[rowIndex],
                                      // Different row colors
                                      child: Row(
                                        children: List.generate(
                                          3, // Number of columns
                                              (columnIndex) {
                                            bool isSelected = rowIndex ==
                                                selectedRow &&
                                                columnIndex == selectedColumn;
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedRow = rowIndex;
                                                  selectedColumn = columnIndex;
                                                });
                                              },
                                              child: Container(
                                                width: 70.0,
                                                decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? Colors.black
                                                        : rowColors[rowIndex],
                                                    border: Border.all(width:1,color:Colors.white )
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Cell $rowIndex-$columnIndex',
                                                    style: TextStyle(
                                                      color: isSelected ? Colors
                                                          .white : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    Container(
                                      width: 40, // Adjust the width as needed
                                      height: 20, // Adjust the height as needed
                                      decoration: const BoxDecoration(
                                        color: Colors.white, // White background
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              10), // Adjust the border radius as needed
                                          right: Radius.circular(
                                              10), // Adjust the border radius as needed
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '0m',
                                          style: TextStyle(
                                            color: Colors.black, // Black text color
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ):const Text(''),
                                (rowIndex==3)? Row(
                                  children: [
                                    const SizedBox(
                                        width: 60,
                                        child: Text(
                                          'GOOD',
                                          style: TextStyle(color: Colors.white),
                                        )),

                                    Container(
                                      height: (rowIndex + 1) * 30.0,
                                      // Varying row heights
                                      color: rowColors[rowIndex],
                                      // Different row colors
                                      child: Row(
                                        children: List.generate(
                                          3, // Number of columns
                                              (columnIndex) {
                                            bool isSelected = rowIndex ==
                                                selectedRow &&
                                                columnIndex == selectedColumn;
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedRow = rowIndex;
                                                  selectedColumn = columnIndex;
                                                });
                                              },
                                              child: Container(
                                                width: 70.0,
                                                decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? Colors.black
                                                        : rowColors[rowIndex],
                                                    border: Border.all(width:1,color:Colors.white )
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Cell $rowIndex-$columnIndex',
                                                    style: TextStyle(
                                                      color: isSelected ? Colors
                                                          .white : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    Container(
                                      width: 40, // Adjust the width as needed
                                      height: 20, // Adjust the height as needed
                                      decoration: const BoxDecoration(
                                        color: Colors.white, // White background
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              10), // Adjust the border radius as needed
                                          right: Radius.circular(
                                              10), // Adjust the border radius as needed
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '0m',
                                          style: TextStyle(
                                            color: Colors.black, // Black text color
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ):const Text(''),
                                (rowIndex==4)? Row(
                                  children: [
                                    const SizedBox(
                                        width: 60,
                                        child: Text(
                                          'SHORT',
                                          style: TextStyle(color: Colors.white),
                                        )),

                                    Container(
                                      height: (rowIndex + 1) * 30.0,
                                      // Varying row heights
                                      color: rowColors[rowIndex],
                                      // Different row colors
                                      child: Row(
                                        children: List.generate(
                                          3, // Number of columns
                                              (columnIndex) {
                                            bool isSelected = rowIndex ==
                                                selectedRow &&
                                                columnIndex == selectedColumn;
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedRow = rowIndex;
                                                  selectedColumn = columnIndex;
                                                });
                                              },
                                              child: Container(
                                                width: 70.0,
                                                decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? Colors.black
                                                        : rowColors[rowIndex],
                                                    border: Border.all(width:1,color:Colors.white )
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Cell $rowIndex-$columnIndex',
                                                    style: TextStyle(
                                                      color: isSelected ? Colors
                                                          .white : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    Container(
                                      width: 40, // Adjust the width as needed
                                      height: 20, // Adjust the height as needed
                                      decoration: const BoxDecoration(
                                        color: Colors.white, // White background
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              10), // Adjust the border radius as needed
                                          right: Radius.circular(
                                              10), // Adjust the border radius as needed
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '0m',
                                          style: TextStyle(
                                            color: Colors.black, // Black text color
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ):const Text(''),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 2, // Button shadow
                    side: BorderSide(width: 1.0, color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Set the border radius to 12
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Images.undo,
                        height: 20,
                        width: 40,
                      ),
                      //Icon(Icons.undo, size: 24.0,color: Colors.black,), // Undo arrow icon
                      SizedBox(width: 4.0), // Spacing between icon and text
                      Text('Undo',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black)), // "Undo" text
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () {
                        scoreUpdateRequestModel.ballTypeId=1;
                        scoreUpdateRequestModel.matchId=widget.data!.batting![0].matchId;
                        scoreUpdateRequestModel.scorerId=1;
                        scoreUpdateRequestModel.strikerId=widget.data!.batting![0].playerId??0;
                        scoreUpdateRequestModel.nonStrikerId=widget.data!.batting![1].playerId??0;
                        scoreUpdateRequestModel.wicketKeeperId=23;
                        scoreUpdateRequestModel.bowlerId=widget.data!.bowling!.playerId??0;
                        scoreUpdateRequestModel.overNumber=(widget.data!.over!.isEmpty)?0:widget.data!.over!.first!.overNumber??1;
                        scoreUpdateRequestModel.ballNumber=(widget.data!.over!.isEmpty)?0:widget.data!.over!.first!.ballNumber??0;
                        scoreUpdateRequestModel.ballNumber=1;
                        scoreUpdateRequestModel.runsScored=widget.run;
                        scoreUpdateRequestModel.extras=0;
                        scoreUpdateRequestModel.wicket=0;
                        scoreUpdateRequestModel.dismissalType=0;
                        scoreUpdateRequestModel.commentary=0;
                        scoreUpdateRequestModel.innings=1;
                        scoreUpdateRequestModel.battingTeamId=widget.data!.batting![0].teamId??0;
                        scoreUpdateRequestModel.bowlingTeamId=widget.data!.bowling!.teamId??0;
                        scoreUpdateRequestModel.overBowled=0;
                        scoreUpdateRequestModel.totalOverBowled=0;
                        scoreUpdateRequestModel.outByPlayer=0;
                        scoreUpdateRequestModel.outPlayer=0;
                        scoreUpdateRequestModel.totalWicket=0;
                        scoreUpdateRequestModel.fieldingPositionsId=0;
                        scoreUpdateRequestModel.endInnings=false;
                        ScoringProvider().scoreUpdate(scoreUpdateRequestModel);

                       Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),



              ],
            ),
          ]),
    );
  }

  // Navigator.of(context).push(MaterialPageRoute(
  // builder: (context) => SlicedPizzaApp(),
  // ));
}



class PizzaSlice extends StatefulWidget {
  @override
  _PizzaSliceState createState() => _PizzaSliceState();
}

class _PizzaSliceState extends State<PizzaSlice> {
  bool isTapped = false;

  void toggleTapped() {
    setState(() {
      isTapped = !isTapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleTapped,
      child: CustomPaint(
        size: Size(200, 200),
        painter: PizzaSlicePainter(isTapped: isTapped),
        child: Center(
          child: Text(
            isTapped ? 'one' : '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class PizzaSlicePainter extends CustomPainter {
  final bool isTapped;

  PizzaSlicePainter({required this.isTapped});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = isTapped ? Colors.black : Colors.orange
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(100, 100)
      ..lineTo(100, 0)
      ..arcTo(Rect.fromCircle(center: Offset(100, 100), radius: 100), -0.25, 1.5, false)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

