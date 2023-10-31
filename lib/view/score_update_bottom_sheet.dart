
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorer/models/scoring_detail_response_model.dart';
import 'package:scorer/provider/score_update_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../models/score_update_request_model.dart';
import '../models/score_update_response_model.dart';
import '../provider/player_selection_provider.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import 'cricket_wagon_wheel.dart';

class ScoreBottomSheet extends StatefulWidget {
  final int run;
  final ScoringDetailResponseModel scoringData;
  final void Function(ScoreUpdateResponseModel) onSave;
  const ScoreBottomSheet(this.run, this.scoringData, {super.key,required this.onSave});

  @override
  State<ScoreBottomSheet> createState() => _ScoreBottomSheetState();
}

class _ScoreBottomSheetState extends State<ScoreBottomSheet> {

  ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();

  List<Color> rowColors = [
    const Color(0xff797873),
    const Color(0xffF7B199),
    const Color(0xffF48F6D),
    const Color(0xffBC8BA0),
    const Color(0xffCAB59A),
  ];

  int selectedRow = -1;
  int selectedColumn = -1;
  int fieldPositionId=0;
   int? isFourOrSix;
   int? isBowlingArea=1;
   bool _isSwitch=false ;


  List<String> partNumbers = List.generate(8, (index) => 'Part ${index + 1}');
  String tappedPart = '';

  void onTap(int partNumberIndex) {
    setState(() {
      tappedPart = partNumbers[partNumberIndex];
    });
    print('Tapped on $tappedPart');
  }

  void callbackFunction(int value) {
    setState(() {
      fieldPositionId=value;
    });
    print("Received value from ThreeCircles: $value");

  }
  @override
  void initState() {
    super.initState();
    getSwitch();
  }

  void getSwitch()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
   isFourOrSix= pref.getInt('fourOrSix');
    isBowlingArea=pref.getInt('bowlingArea');
   if(isFourOrSix==1) {
     setState(() {
       _isSwitch = true;
     });
   }else{
     setState(() {
       _isSwitch = false;
     });
   }
  }

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double sheetHeight = screenHeight * 0.9;
    if(widget.scoringData.data!.batting!.isEmpty){
      return const Center(child: Text('Please Select Batsman'));
    }
    if(widget.scoringData.data!.bowling ==null){
      return const Center(child: Text('Please Select Bowler'));
    }
    return Container(
      height: sheetHeight,
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xff000000),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      "Shot and Pitching Area",
                      style: fontMedium.copyWith(
                        fontSize: 17.sp,
                        color: AppColor.textColor,
                      ),
                    ),
                    SizedBox(width: 10.w,),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: 100.w,
                  height: 2,
                  color: const Color(0xffF8F9FA),
                ),
                Row(
                  children: [
                     Text(
                      'Wagon Wheel',
                      style: fontMedium.copyWith(fontSize: 24),
                    ),
                    const Spacer(),
                     Text(
                      '4s & 6s',
                      style: fontMedium.copyWith(color: AppColor.iconColour),
                    ),
                    Switch(value: _isSwitch, onChanged: (bool value) async{

                      SharedPreferences pref=await SharedPreferences.getInstance();
                      isFourOrSix=pref.getInt('fourOrSix');
                      if(isFourOrSix==1){
                        await pref.setInt('fourOrSix',0);
                      }else{
                        await pref.setInt('fourOrSix',1);
                      }
                      setState(() {
                        _isSwitch=value;
                      });

                    }),
                  ],
                ),
                Container(
                  width: 600.0,
                  height: 100, // Adjust the width as needed
                  padding:  const EdgeInsets.all(20.0), // Spacing inside the card
                  decoration: BoxDecoration(
                    color: const Color(0xffF8F9FA),
                    borderRadius:
                        BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Center(
                                  child: Text('Batsman Name',
                                      style: fontMedium.copyWith(fontSize: 20))),
                            ],
                          ),
                          Column(
                            children: [
                              Center(
                                  child: Text(
                                'Runs',
                                style: fontMedium.copyWith(fontSize: 20),
                              )),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Expanded(
                        child: ListView.builder(
                          itemCount: widget.scoringData.data!.batting!.length,
                          itemBuilder: (context, index) {
                            final batsman = widget.scoringData.data!.batting![index];

                            if (batsman.striker == 1) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Center(
                                        child: Text('${batsman.playerName ?? '-'}',
                                          style: fontMedium.copyWith(fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Center(
                                        child: Text('${batsman.runsScored ?? '0'}',
                                          style: fontMedium.copyWith(fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              // If the batsman's striker value is not 1, return an empty container.
                              return Container();
                            }
                          },
                        ),
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Column(
                      //       children: [
                      //         Container(
                      //           child: Center(
                      //               child: Text('${widget.scoringData.data!.batting![0].playerName??'-'}',
                      //                   style: fontMedium.copyWith(fontSize: 18))),
                      //         ),
                      //       ],
                      //     ),
                      //     Column(
                      //       children: [
                      //         Container(
                      //           child: Center(
                      //               child: Text('${widget.scoringData.data!.batting![0].runsScored??'0'}',
                      //                   style: fontMedium.copyWith(fontSize: 18))),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                 Row(
                  children: [
                    Text(
                      'skip match',
                      style: fontMedium.copyWith(color: AppColor.iconColour),
                    ),
                    const Spacer(),
                    Text(
                      'skip ball',
                      style: fontMedium.copyWith(color: AppColor.iconColour),
                    )
                  ],
                ),
                ((widget.run==4 || widget.run==6)|| isFourOrSix!=1 )?Center(
                  child: SizedBox(
                    height: 550,
                    width:500,
                    child:ThreeCircles(onOkButtonPressed:callbackFunction,),
                  ),
                ):const Text(''),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 2, // Button shadow
                    side: const BorderSide(width: 1.0, color: Colors.black),
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
                       Text('Undo',
                          style: fontMedium.copyWith(
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
                  padding: const EdgeInsets.all(20.0), // Spacing inside the card
                  decoration: BoxDecoration(
                    color: const Color(0xffF8F9FA), // Grey background color
                    borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
                  ),
                  child: Column(
                    children: [
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Center(
                                  child: Text('Bowler Name',
                                      style: fontMedium.copyWith(fontSize: 20))),
                            ],
                          ),
                          Column(
                            children: [
                              Center(
                                  child: Text(
                                'Info',
                                style: fontMedium.copyWith(fontSize: 20),
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
                                  child: Text('${widget.scoringData.data!.bowling!.playerName??'-'}',
                                      style: fontMedium.copyWith(fontSize: 18))),
                            ],
                          ),
                          Column(
                            children: [
                              Center(
                                  child: Text('${widget.scoringData.data!.bowling!.oversBowled}-${widget.scoringData.data!.bowling!.wickets}-${widget.scoringData.data!.bowling!.runsConceded}-${widget.scoringData.data!.bowling!.economy}',
                                      style: fontMedium.copyWith(fontSize: 18))),
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
                 Row(
                  children: [
                    Text(
                      'skip match',
                      style: fontMedium.copyWith(color: AppColor.iconColour),
                    ),
                    const Spacer(),
                    Text(
                      'skip ball',
                      style: fontMedium.copyWith(color: AppColor.iconColour),
                    )
                  ],
                ),
                (isBowlingArea==1)?
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
                                     SizedBox(
                                        width: 60,
                                        child: Text(
                                          'F.TOSS',
                                          style: fontMedium.copyWith(color: Colors.white),
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
                                                    style: fontMedium.copyWith(
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
                                      child:  Center(
                                        child: Text(
                                          '0m',
                                          style: fontMedium.copyWith(
                                            color: Colors.black, // Black text color
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ):const Text(''),
                                (rowIndex==1)? Row(
                                  children: [
                                     SizedBox(
                                        width: 60,
                                        child: Text(
                                          'YORKER',
                                          style: fontMedium.copyWith(color: Colors.white),
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
                                                    style: fontMedium.copyWith(
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
                                      child:  Center(
                                        child: Text(
                                          '0m',
                                          style: fontMedium.copyWith(
                                            color: Colors.black, // Black text color
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ):const Text(''),
                                (rowIndex==2)? Row(
                                  children: [
                                     SizedBox(
                                        width: 60,
                                        child: Text(
                                          'FULL',
                                          style: fontMedium.copyWith(color: Colors.white),
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
                                                    style: fontMedium.copyWith(
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
                                      child:  Center(
                                        child: Text(
                                          '0m',
                                          style: fontMedium.copyWith(
                                            color: Colors.black, // Black text color
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ):const Text(''),
                                (rowIndex==3)? Row(
                                  children: [
                                     SizedBox(
                                        width: 60,
                                        child: Text(
                                          'GOOD',
                                          style: fontMedium.copyWith(color: Colors.white),
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
                                                    style: fontMedium.copyWith(
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
                                      child:  Center(
                                        child: Text(
                                          '0m',
                                          style: fontMedium.copyWith(
                                            color: Colors.black, // Black text color
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ):const Text(''),
                                (rowIndex==4)? Row(
                                  children: [
                                     SizedBox(
                                        width: 60,
                                        child: Text(
                                          'SHORT',
                                          style: fontMedium.copyWith(color: Colors.white),
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
                                                    style: fontMedium.copyWith(
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
                                      child:  Center(
                                        child: Text(
                                          '0m',
                                          style: fontMedium.copyWith(
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
                ):const Text(''),
                SizedBox(height: 3.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 2, // Button shadow
                    side: const BorderSide(width: 1.0, color: Colors.black),
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
                      const SizedBox(width: 4.0), // Spacing between icon and text
                      Text('Undo',
                          style: fontMedium.copyWith(
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
                      onPressed: () async{
                        final player = Provider.of<PlayerSelectionProvider>(context, listen: false);
                        final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
                        print("striker id ${player.selectedStrikerId}");
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var overNumber= prefs.getInt('over_number_innings');
                        var ballNumber= prefs.getInt('ball_number_innings');
                        var strikerId=prefs.getInt('striker_id')??0;
                        var nonStrikerId=prefs.getInt('non_striker_id')??0;
                        var bowlerId=prefs.getInt('bowler_id')??0;
                        var keeperId=prefs.getInt('wicket_keeper_id')??0;
                        var bowlerPosition=prefs.getInt('bowlerPosition')??0;

                        scoreUpdateRequestModel.ballTypeId=widget.run;
                        scoreUpdateRequestModel.matchId=widget.scoringData.data!.batting![0].matchId;
                        scoreUpdateRequestModel.scorerId=1;
                        scoreUpdateRequestModel.strikerId=int.parse(player.selectedStrikerId.toString());
                        scoreUpdateRequestModel.nonStrikerId=int.parse(player.selectedNonStrikerId.toString());
                        scoreUpdateRequestModel.wicketKeeperId=int.parse(player.selectedWicketKeeperId.toString());
                        scoreUpdateRequestModel.bowlerId=int.parse(player.selectedBowlerId.toString());
                        scoreUpdateRequestModel.overNumber=overNumber;
                        scoreUpdateRequestModel.ballNumber=ballNumber;
                        scoreUpdateRequestModel.runsScored=widget.run;
                        scoreUpdateRequestModel.extras=0;
                        scoreUpdateRequestModel.wicket=0;
                        scoreUpdateRequestModel.dismissalType=0;
                        scoreUpdateRequestModel.commentary=0;
                        scoreUpdateRequestModel.innings=1;
                        scoreUpdateRequestModel.battingTeamId=widget.scoringData.data!.batting![0].teamId??0;
                        scoreUpdateRequestModel.bowlingTeamId=widget.scoringData.data!.bowling!.teamId??0;
                        scoreUpdateRequestModel.overBowled=overNumber;
                        scoreUpdateRequestModel.totalOverBowled=0;
                        scoreUpdateRequestModel.outByPlayer=0;
                        scoreUpdateRequestModel.outPlayer=0;
                        scoreUpdateRequestModel.totalWicket=0;
                        scoreUpdateRequestModel.fieldingPositionsId=fieldPositionId;
                        scoreUpdateRequestModel.endInnings=false;
                        scoreUpdateRequestModel.bowlerPosition= bowlerPosition;
                        ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value) async{
                          widget.onSave(value);
                          score.setOverNumber(value.data!.overNumber??0);
                          score.setBallNumber(value.data!.ballNumber??0);
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setInt('over_number', value.data!.overNumber??0);
                          await prefs.setInt('ball_number', value.data!.ballNumber??0);
                          await prefs.setInt('striker_id', value.data!.strikerId??0);
                          await prefs.setInt('non_striker_id', value.data!.nonStrikerId??0);
                          await prefs.setInt('bowler_change', value.data!.bowlerChange??0);
                          await prefs.setInt('bowlerPosition', 0);

                        });
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pop(context);
                          });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
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

