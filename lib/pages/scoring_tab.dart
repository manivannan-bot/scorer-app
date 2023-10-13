import 'dart:math';
import 'dart:ui';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scorer/models/scoring_detail_response_model.dart';

import 'package:scorer/widgets/custom_vertical_dottedLine.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';

import '../models/score_update_request_model.dart';

import '../out_screens/retired _hurt_screen.dart';
import '../out_screens/run_out_screens.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import '../widgets/cancel_btn.dart';
import '../widgets/custom_horizondal_dottedLine.dart';
import '../widgets/dialog_others.dart';
import '../widgets/ok_btn.dart';
import '../out_screens/out_method_dialog.dart';
import 'bottom_sheet.dart';



class ScoringTab extends StatefulWidget {
  final String matchId;
  const ScoringTab(this.matchId, {super.key});

  @override
  State<ScoringTab> createState() => _ScoringTabState();
}

class _ScoringTabState extends State<ScoringTab> {

  ScoringDeatailResponseModel? scoringData;
  int index1=0;
  int index2=1;
  int totalBallId = 0;
  int overNumber=0;
  int ballNumber=0;
  ScoringDeatailResponseModel scoringDeatailResponseModel=ScoringDeatailResponseModel();
  ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();

  ScoreUpdateResponseModel scoreUpdateResponseModel=ScoreUpdateResponseModel();

  void receiveDataFromScoreBottomSheet(ScoreUpdateResponseModel data1) {
    setState(() {
      scoreUpdateResponseModel = data1;
    });
  }
  RefreshController _refreshController = RefreshController();


  void _refreshData() {
    ScoringProvider()
        .getScoringDetail(widget.matchId)
        .then((value) async {
      setState(() {
        scoringData = value;

      });
      _refreshController.refreshCompleted();
    });
  }


  @override
  void initState() {
    scoringData=null;
    super.initState();
    ScoringProvider().getScoringDetail(widget.matchId).then((value) async{
      setState(() {
        scoringData=value;
      });

    } );
  }

  @override
  Widget build(BuildContext context) {
    if(scoringData==null || scoringData!.data ==null){
      return const SizedBox(
          height: 100,
          width: 100,
          child: Center(child: CircularProgressIndicator()));
    }
    if(scoringData!.data!.batting!.isEmpty || scoringData!.data!.bowling==null){
      return scoringData!.data!.batting!.isEmpty? const SizedBox(
          height: 100,
          width: 100,
          child: Center(child: Text('Please Select Batsman'))): const SizedBox(
            height: 100,
            width: 100,
            child: Center(child: Text('Please Select Bowler')));
    }
    int totalBallId = 0;
    for (int index = 0; index < scoringData!.data!.over!.length; index++) {
      totalBallId += int.parse(scoringData!.data!.over![index].runsScored==null?'0':scoringData!.data!.over![index].runsScored.toString()); // Sum the ballIds
    }

    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      onRefresh: _refreshData,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(1.h),
            child: SizedBox(
                height: 30.h,
                width: 100.w,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Padding(
                                padding:  EdgeInsets.all(0.4.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      const Text(
                                        'Batsman',
                                        style: TextStyle(
                                            color: Colors.orange, fontSize: 24),
                                      ),
                                      Container(
                                        width: 0.5.w,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          print('index changed');
                                          setState(() {
                                            if(index1==1){
                                            index2=1;
                                            index1=0;
                                            }else{
                                              index2=0;
                                              index1=1;
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                        child: const Text(
                                          'swap',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    Text('${scoringData!.data!.batting![index1].playerName??'-'}    ${scoringData!.data!.batting![index1].runsScored??'0'}(${scoringData!.data!.batting![index1].ballsFaced??'0'})',
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 16)),
                                    Text((scoringData!.data!.batting?[index2]!=null)?'${scoringData!.data!.batting![index2].playerName??'-'}    ${scoringData!.data!.batting![index2].runsScored??'0'}(${scoringData!.data!.batting![index2].ballsFaced??'0'})':'-',
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                            const CustomVerticalDottedLine(),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      const Text('Bowler',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 24)),
                                      Container(
                                        width: 0.5.w,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Handle button press here
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                        child: const Text(
                                          'change',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    Text('${scoringData!.data!.bowling!.playerName??'-'}    ${scoringData!.data!.bowling!.totalBalls??'0'}(${scoringData!.data!.bowling!.wickets??'0'})',
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 16)),

                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      height: 0.5.h,
                    ),
                    Column(
                      children: [
                        Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    height: 12.h,
                                    width: 90.w,
                                    color: Colors.yellow,
                                    child:(scoringData!.data!.over!.isNotEmpty)? ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        for (int index = 0; index < scoringData!.data!.over!.length; index++)

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                margin: EdgeInsets.symmetric(horizontal: 5),
                                                decoration: const BoxDecoration(
                                                  color: Colors.black,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    scoringData!.data!.over![index].runsScored.toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                         Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text('=',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                              ),
                                            ),
                                            Text(totalBallId.toString() ?? 'N/A',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ):const Text(''),
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Container(
                                color: Colors.yellow,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(
                                  'over ${(scoringData!.data!.over!.isNotEmpty)?scoringData!.data!.over!.first.overNumber:'0'}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )),
          ),

          Expanded(
            child: Container(
              height: 100.h,
              width: 100.w,
              color: Colors.black,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                          children:[
                            GestureDetector(
                              onTap:()async {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                overNumber= prefs.getInt('over_number')??0;
                                ballNumber= prefs.getInt('ball_number')??0;
                                var strikerId=prefs.getInt('striker_id')??0;
                                var nonStrikerId=prefs.getInt('non_striker_id')??0;

                                scoreUpdateRequestModel.ballTypeId=1;
                                scoreUpdateRequestModel.matchId=int.parse(widget.matchId);
                                scoreUpdateRequestModel.scorerId=1;
                                scoreUpdateRequestModel.strikerId=strikerId;
                                scoreUpdateRequestModel.nonStrikerId=nonStrikerId;
                                scoreUpdateRequestModel.wicketKeeperId=23;
                                scoreUpdateRequestModel.bowlerId=scoringData!.data!.bowling!.playerId??0;
                                scoreUpdateRequestModel.overNumber=overNumber;
                                scoreUpdateRequestModel.ballNumber=ballNumber;
                                scoreUpdateRequestModel.runsScored=0;
                                scoreUpdateRequestModel.extras=0;
                                scoreUpdateRequestModel.wicket=0;
                                scoreUpdateRequestModel.dismissalType=0;
                                scoreUpdateRequestModel.commentary=0;
                                scoreUpdateRequestModel.innings=1;
                                scoreUpdateRequestModel.battingTeamId=scoringData!.data!.batting![index1].teamId??0;
                                scoreUpdateRequestModel.bowlingTeamId=scoringData!.data!.bowling!.teamId??0;
                                scoreUpdateRequestModel.overBowled=0;
                                scoreUpdateRequestModel.totalOverBowled=0;
                                scoreUpdateRequestModel.outByPlayer=0;
                                scoreUpdateRequestModel.outPlayer=0;
                                scoreUpdateRequestModel.totalWicket=0;
                                scoreUpdateRequestModel.fieldingPositionsId=0;
                                scoreUpdateRequestModel.endInnings=false;
                                ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value)async {
                                  setState(() {
                                    scoreUpdateResponseModel=value;
                                  });
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  await prefs.setInt('over_number', value.data!.overNumber??0);
                                  await prefs.setInt('ball_number', value.data!.ballNumber??1);
                                  await prefs.setInt('striker_id', value.data!.strikerId??0);
                                  await prefs.setInt('non_striker_id', value.data!.nonStrikerId??0);

                                });
                                },
                                child: _buildGridItem('0','DOT', context)),

                            const CustomHorizantalDottedLine(),]),

                      const CustomVerticalDottedLine(),
                      Column(
                          children:[
                            GestureDetector(onTap:(){
                              _displayBottomSheet(context,1,scoringData);
                            }, child: _buildGridItem('1','', context)),

                            const CustomHorizantalDottedLine(),]),
                      const CustomVerticalDottedLine(),
                      Column(
                          children:[
                            GestureDetector(onTap:(){
                              _displayBottomSheet(context,2,scoringData);
                            }, child:_buildGridItem('2','', context)),
                            const CustomHorizantalDottedLine(),]),
                      const CustomVerticalDottedLine(),
                      Column(
                          children:[
                            GestureDetector(onTap:(){
                              _displayBottomSheet(context,3,scoringData);
                            }, child:_buildGridItem('3','', context)),
                            const CustomHorizantalDottedLine(),]),
                      const CustomVerticalDottedLine(),
                      Column(
                          children:[
                            GestureDetector(onTap:(){
                              _displayBottomSheet(context,4,scoringData);
                            }, child:_buildGridItemFour(Images.four,'FOUR', context)),
                            const CustomHorizantalDottedLine(),]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                          children:[  GestureDetector(onTap:(){
                            _displayBottomSheet(context,6,scoringData);
                          }, child:_buildGridItemFour(Images.six,'SIX', context)),
                            const CustomHorizantalDottedLine(),]),
                      const CustomVerticalDottedLine(),
                      Column(
                          children:[ GestureDetector(
                            onTap: (){
                              _displayBottomSheetWide(context,7,scoringData);
                            },
                              child: _buildGridItem('WD','WIDE', context)),
                            const CustomHorizantalDottedLine(),]),
                      const CustomVerticalDottedLine(),
                      Column(
                          children:[ GestureDetector(
                            onTap: (){
                              _displayBottomSheetNoBall(context,8,scoringData);
                            },
                              child: _buildGridItem('NB','NO BALL', context)),
                            const CustomHorizantalDottedLine(),]),
                      const CustomVerticalDottedLine(),
                      Column(
                          children:[ GestureDetector(
                            onTap:(){
                              _displayBottomSheetLegBye(context,9,scoringData);
                            },
                              child: _buildGridItem('LB','LEG-BYE', context)),
                            const CustomHorizantalDottedLine(),]),
                      const CustomVerticalDottedLine(),
                      Column(
                          children:[ GestureDetector(
                            onTap: (){
                              _displayBottomSheetByes(context,10,scoringData);
                            },
                              child: _buildGridItem('BYE','', context)),
                            const CustomHorizantalDottedLine(),]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(onTap:(){
                        _displayBottomSheetBonus(context,11,scoringData);
                      },
                          child: _buildGridItem('B/P','B/P', context)),
                      const CustomVerticalDottedLine(),
                      GestureDetector(onTap: (){
                        _displayBottomSheetMoreRuns(context,5,scoringData);
                      },
                          child: _buildGridItem('5,7..','RUNS', context)),
                      const CustomVerticalDottedLine(),
                      _buildGridItem('','UNDO', context),
                      const CustomVerticalDottedLine(),
                      GestureDetector(
                          onTap: (){_displayBottomSheetOther(context);},
                          child: _buildGridItem('','OTHER', context)),
                      const CustomVerticalDottedLine(),
                      GestureDetector(
                          onTap: (){_displayBottomOut(context);},
                          child: _buildGridItemOut('OUT','', context)),
                    ],
                  ),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }

  Future<ScoreUpdateResponseModel?> _displayBottomSheet(BuildContext context, int run, ScoringDeatailResponseModel? scoringData) async {
    double screenHeight = MediaQuery.of(context).size.height;
    double sheetHeight = screenHeight * 0.9;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {

        return SizedBox(height: sheetHeight,
          child: ScoreBottomSheet(run,scoringData!,onSave: (value){
            setState(() {
              scoreUpdateResponseModel=value;
            });

          },),
        ); // Create and return the GroundCircle widget here.
      },
    );
  }

}

Widget _buildGridItem(String index,String text, BuildContext context) {
  return Container(
    height: 10.h,
    width: 19.w,
    decoration: const BoxDecoration(shape: BoxShape.rectangle,color: Colors.black,),
    child: Column(
      children: [
         SizedBox(height: 0.5.h,),
          CircleAvatar(
          radius: 6.w, // Adjust the radius as needed for the circle size
          backgroundColor: Colors.white,
          child: Text(
            "$index",
            style:  TextStyle(color: Colors.black, fontSize: 2.h),
          ),
        ),
         SizedBox(height:  0.5.h,),
        Text('$text', style: const TextStyle(color: Colors.white)),
      ],
    ),
  );
}
Widget _buildGridItemFour(String index,String text, BuildContext context) {
  return Container(
    height: 10.h,
    width: 19.w,
    decoration: const BoxDecoration(shape: BoxShape.rectangle,color: Colors.black,),
    child: Column(
      children: [
         SizedBox(height: 0.5.h,),
        CircleAvatar(
          radius: 6.w, // Adjust the radius as needed for the circle size
          backgroundColor: Colors.white,
          child: Image.asset(index)
        ),
         SizedBox(height: 0.5.h,),
        Text('$text', style: const TextStyle(color: Colors.white)),
      ],
    ),
  );
}

Widget _buildGridItemOut(String index,String text, BuildContext context) {
  return Container(
    height: 10.h,
    width: 19.w,
    decoration: const BoxDecoration(shape: BoxShape.rectangle,color: Colors.black,),
    child: Column(
      children: [
         SizedBox(height: 0.5.h,),
        CircleAvatar(
          radius: 6.w, // Adjust the radius as needed for the circle size
          backgroundColor: Colors.red,
          child: Text(
            "$index",
            style:  TextStyle(color: Colors.white, fontSize: 2.h),
          ),
        ),
         SizedBox(height: 0.5.h,),
        Text('$text', style:  TextStyle(color: Colors.white)),
      ],
    ),
  );
}


Future<void> _displayBottomSheetWide (BuildContext context, int balltype, ScoringDeatailResponseModel? scoringData) async{
  int? isOffSideSelected ;
  int? isWideSelected ;
  List<Map<String, dynamic>> chipData =[
    {
      'label': 'Wd',
    },
    {
      'label': '1 + Wd',
    },
    {
      'label': '2 + Wd',
    },
    {
      'label': '3 + Wd',
    },
    {
      'label': '4 + Wd',
    },
    {
      'label': '5 + Wd',
    },
    {
      'label': '6 + Wd',
    },
  ];
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context)=> StatefulBuilder(builder: (context, setState){
        return Container(
          height: 45.h,
          // padding: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: BoxDecoration(
              color: AppColor.lightColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w,)+EdgeInsets.only(top: 2.h,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,size: 7.w,)),
                    Text("Wide",style: fontMedium.copyWith(
                      fontSize: 17.sp,
                      color: AppColor.blackColour,
                    ),),
                    SizedBox(width: 7.w,),
                  ],
                ),
              ),
              SizedBox(height: 1.h,),
              Divider(
                color: Color(0xffD3D3D3),
              ),
              SizedBox(height: 1.h,),
              Padding(
                padding:  EdgeInsets.only(left: 10.w,right: 10.w),
                child: Wrap(
                  spacing: 2.5.w, // Horizontal spacing between items
                  runSpacing: 0.5.h, // Vertical spacing between lines
                  alignment: WrapAlignment.center, // Alignment of items
                  children:chipData.map((data) {
                    final index = chipData.indexOf(data);
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          isWideSelected=index;
                        });
                      },
                      child: Chip(
                        padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.5.h),
                        label: Text(data['label'],style: fontSemiBold.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackColour
                        ),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(
                            color: Color(0xffDADADA),
                          ),
                        ),
                        backgroundColor: isWideSelected==index? AppColor.primaryColor : Color(0xffF8F9FA),
                        // backgroundColor:AppColor.lightColor
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 1.h,),
              DottedLine(
                dashColor: Color(0xffD2D2D2),
              ),
              SizedBox(height: 1.5.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text("Which side?",style: fontMedium.copyWith(
                  fontSize: 16.sp,
                  color: AppColor.blackColour,
                ),),
              ),
              SizedBox(height: 1.5.h,),
              //offside leg side
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isOffSideSelected=0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xffDADADA),
                          ),
                          color: isOffSideSelected==0 ? AppColor.primaryColor : null,
                        ),
                        child: Text("Off side",style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.blackColour,
                        ),),
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isOffSideSelected=1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                        decoration: BoxDecoration(
                            color: isOffSideSelected==1?AppColor.primaryColor:null,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color(0xffDADADA),
                            )
                        ),
                        child: Text("Leg side",style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.blackColour,
                        ),),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap:()async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            var overNumber= prefs.getInt('over_number')??0;
                            var ballNumber= prefs.getInt('ball_number')??0;
                            var strikerId=prefs.getInt('striker_id')??0;
                            var nonStrikerId=prefs.getInt('non_striker_id')??0;

                            ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
                            scoreUpdateRequestModel.ballTypeId=1;
                            scoreUpdateRequestModel.matchId=scoringData!.data!.batting![0].matchId;
                            scoreUpdateRequestModel.scorerId=1;
                            scoreUpdateRequestModel.strikerId=strikerId;
                            scoreUpdateRequestModel.nonStrikerId=nonStrikerId;
                            scoreUpdateRequestModel.wicketKeeperId=23;
                            scoreUpdateRequestModel.bowlerId=scoringData!.data!.bowling!.playerId??0;
                            scoreUpdateRequestModel.overNumber=overNumber;
                            scoreUpdateRequestModel.ballNumber=ballNumber;

                            scoreUpdateRequestModel.runsScored=isWideSelected??0;
                            scoreUpdateRequestModel.extras=0;
                            scoreUpdateRequestModel.wicket=0;
                            scoreUpdateRequestModel.dismissalType=0;
                            scoreUpdateRequestModel.commentary=0;
                            scoreUpdateRequestModel.innings=1;
                            scoreUpdateRequestModel.battingTeamId=scoringData!.data!.batting![0].teamId??0;
                            scoreUpdateRequestModel.bowlingTeamId=scoringData!.data!.bowling!.teamId??0;
                            scoreUpdateRequestModel.overBowled=0;
                            scoreUpdateRequestModel.totalOverBowled=0;
                            scoreUpdateRequestModel.outByPlayer=0;
                            scoreUpdateRequestModel.outPlayer=0;
                            scoreUpdateRequestModel.totalWicket=0;
                            scoreUpdateRequestModel.fieldingPositionsId=0;
                            scoreUpdateRequestModel.endInnings=false;
                            ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value) async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setInt('over_number', value.data!.overNumber??0);
                              await prefs.setInt('ball_number', value.data!.ballNumber??1);
                              await prefs.setInt('striker_id', value.data!.strikerId??0);
                              await prefs.setInt('non_striker_id', value.data!.nonStrikerId??0);
                              Navigator.pop(context);
                            });


                          },
                          child: OkBtn("Save")),
                    ],
                  ),
                ),
              )

            ],
          ),
        );
      })
  );
}


Future<void> _displayBottomSheetLegBye (BuildContext context, int ballType,ScoringDeatailResponseModel? scoringData) async{
  int? isOffSideSelected ;
  int? isWideSelected ;
  List<Map<String, dynamic>> chipData =[
    {
      'label': '1LB',
    },
    {
      'label': '2LB',
    },
    {
      'label': '3LB',
    },
    {
      'label': '4LB',
    },
    {
      'label': '5LB',
    },
    {
      'label': '6LB',
    },
    {
      'label': '7LB',
    },
  ];
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context)=> StatefulBuilder(builder: (context, setState){
        return Container(
          height: 33.h,
          // padding: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: BoxDecoration(
              color: AppColor.lightColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w,)+EdgeInsets.only(top: 2.h,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,size: 7.w,)),
                    Text("Leg Byes",style: fontMedium.copyWith(
                      fontSize: 17.sp,
                      color: AppColor.blackColour,
                    ),),
                    SizedBox(width: 7.w,),
                  ],
                ),
              ),
              SizedBox(height: 1.h,),
              Divider(
                color: Color(0xffD3D3D3),
              ),
              SizedBox(height: 1.h,),
              Padding(
                padding:  EdgeInsets.only(left: 15.w,right: 5.w),
                child: Wrap(
                  spacing: 8.w, // Horizontal spacing between items
                  runSpacing: 1.h, // Vertical spacing between lines
                  alignment: WrapAlignment.center, // Alignment of items
                  children:chipData.map((data) {
                    final index = chipData.indexOf(data);
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          isWideSelected=index;
                        });
                      },
                      child: Chip(
                        padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.5.h),
                        label: Text(data['label'],style: fontSemiBold.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackColour
                        ),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(
                            color: Color(0xffDADADA),
                          ),
                        ),
                        backgroundColor: isWideSelected==index? AppColor.primaryColor : Color(0xffF8F9FA),
                        // backgroundColor:AppColor.lightColor
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(onTap:()async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var overNumber= prefs.getInt('over_number')??0;
                        var ballNumber= prefs.getInt('ball_number')??0;
                        var strikerId=prefs.getInt('striker_id')??0;
                        var nonStrikerId=prefs.getInt('non_striker_id')??0;

                        ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
                        scoreUpdateRequestModel.ballTypeId=ballType??0;
                        scoreUpdateRequestModel.matchId=scoringData!.data!.batting![0].matchId;
                        scoreUpdateRequestModel.scorerId=1;
                        scoreUpdateRequestModel.strikerId=strikerId;
                        scoreUpdateRequestModel.nonStrikerId=nonStrikerId;
                        scoreUpdateRequestModel.wicketKeeperId=23;
                        scoreUpdateRequestModel.bowlerId=scoringData!.data!.bowling!.playerId??0;
                        scoreUpdateRequestModel.overNumber=overNumber;
                        scoreUpdateRequestModel.ballNumber=ballNumber;
                        scoreUpdateRequestModel.runsScored=isWideSelected??0;
                        scoreUpdateRequestModel.extras=0;
                        scoreUpdateRequestModel.wicket=0;
                        scoreUpdateRequestModel.dismissalType=0;
                        scoreUpdateRequestModel.commentary=0;
                        scoreUpdateRequestModel.innings=1;
                        scoreUpdateRequestModel.battingTeamId=scoringData!.data!.batting![0].teamId??0;
                        scoreUpdateRequestModel.bowlingTeamId=scoringData!.data!.bowling!.teamId??0;
                        scoreUpdateRequestModel.overBowled=0;
                        scoreUpdateRequestModel.totalOverBowled=0;
                        scoreUpdateRequestModel.outByPlayer=0;
                        scoreUpdateRequestModel.outPlayer=0;
                        scoreUpdateRequestModel.totalWicket=0;
                        scoreUpdateRequestModel.fieldingPositionsId=0;
                        scoreUpdateRequestModel.endInnings=false;
                        ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value) async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setInt('over_number', value.data!.overNumber??0);
                          await prefs.setInt('ball_number', value.data!.ballNumber??1);
                          await prefs.setInt('striker_id', value.data!.strikerId??0);
                          await prefs.setInt('non_striker_id', value.data!.nonStrikerId??0);

                          Navigator.pop(context);
                        });
                      },child: OkBtn("Save")),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      })
  );
}

Future<void> _displayBottomSheetNoBall (BuildContext context,int ballType,ScoringDeatailResponseModel? scoringData) async{
  int? isOffSideSelected ;
  int? isWideSelected ;
  List<Map<String, dynamic>> chipData =[
    {
      'label': 'NB',
    },
    {
      'label': '1 + NB',
    },
    {
      'label': '2 + NB',
    },
    {
      'label': '3 + NB',
    },
    {
      'label': '4 + NB',
    },
    {
      'label': '5 + NB',
    },
    {
      'label': '6 + NB',
    },
    {
      'label': '7 + NB',
    },
  ];
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context)=> StatefulBuilder(builder: (context, setState){
        return Container(
          height: 45.h,
          // padding: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: BoxDecoration(
              color: AppColor.lightColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w,)+EdgeInsets.only(top: 2.h,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,size: 7.w,)),
                    Text("No ball",style: fontMedium.copyWith(
                      fontSize: 17.sp,
                      color: AppColor.blackColour,
                    ),),
                    SizedBox(width: 7.w,),
                  ],
                ),
              ),
              SizedBox(height: 1.h,),
              Divider(
                color: Color(0xffD3D3D3),
              ),
              SizedBox(height: 1.h,),
              Padding(
                padding:  EdgeInsets.only(left: 5.w,right: 5.w),
                child: Wrap(
                  spacing: 2.5.w, // Horizontal spacing between items
                  runSpacing: 0.5.h, // Vertical spacing between lines
                  alignment: WrapAlignment.center, // Alignment of items
                  children:chipData.map((data) {
                    final index = chipData.indexOf(data);
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          isWideSelected=index;
                        });
                      },
                      child: Chip(
                        padding: EdgeInsets.symmetric(horizontal: 1.5.w,vertical: 0.5.h),
                        label: Text(data['label'],style: fontSemiBold.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackColour
                        ),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(
                            color: Color(0xffDADADA),
                          ),
                        ),
                        backgroundColor: isWideSelected==index? AppColor.primaryColor : Color(0xffF8F9FA),
                        // backgroundColor:AppColor.lightColor
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 1.h,),
              DottedLine(
                dashColor: Color(0xffD2D2D2),
              ),
              SizedBox(height: 1.5.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text("Type of No ball?",style: fontMedium.copyWith(
                  fontSize: 16.sp,
                  color: AppColor.blackColour,
                ),),
              ),
              SizedBox(height: 1.5.h,),
              //offside leg side
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isOffSideSelected=0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xffDADADA),
                          ),
                          color: isOffSideSelected==0 ? AppColor.primaryColor : Color(0xffF8F9FA),
                        ),
                        child: Text("Grease",style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.blackColour,
                        ),),
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isOffSideSelected=1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                        decoration: BoxDecoration(
                            color: isOffSideSelected==1?AppColor.primaryColor:Color(0xffF8F9FA),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color(0xffDADADA),
                            )
                        ),
                        child: Text("Waist",style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.blackColour,
                        ),),
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isOffSideSelected=2;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                        decoration: BoxDecoration(
                            color: isOffSideSelected==2?AppColor.primaryColor:Color(0xffF8F9FA),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color(0xffDADADA),
                            )
                        ),
                        child: Text("Shoulder",style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.blackColour,
                        ),),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(onTap:()async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var overNumber= prefs.getInt('over_number')??0;
                        var ballNumber= prefs.getInt('ball_number')??0;
                        var strikerId=prefs.getInt('striker_id')??0;
                        var nonStrikerId=prefs.getInt('non_striker_id')??0;

                        ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
                        scoreUpdateRequestModel.ballTypeId=ballType??0;
                        scoreUpdateRequestModel.matchId=scoringData!.data!.batting![0].matchId;
                        scoreUpdateRequestModel.scorerId=1;
                        scoreUpdateRequestModel.strikerId=strikerId;
                        scoreUpdateRequestModel.nonStrikerId=nonStrikerId;
                        scoreUpdateRequestModel.wicketKeeperId=23;
                        scoreUpdateRequestModel.bowlerId=scoringData!.data!.bowling!.playerId??0;
                        scoreUpdateRequestModel.overNumber=overNumber;
                        scoreUpdateRequestModel.ballNumber=ballNumber;
                        scoreUpdateRequestModel.runsScored=isWideSelected??0;
                        scoreUpdateRequestModel.extras=0;
                        scoreUpdateRequestModel.wicket=0;
                        scoreUpdateRequestModel.dismissalType=0;
                        scoreUpdateRequestModel.commentary=0;
                        scoreUpdateRequestModel.innings=1;
                        scoreUpdateRequestModel.battingTeamId=scoringData!.data!.batting![0].teamId??0;
                        scoreUpdateRequestModel.bowlingTeamId=scoringData!.data!.bowling!.teamId??0;
                        scoreUpdateRequestModel.overBowled=0;
                        scoreUpdateRequestModel.totalOverBowled=0;
                        scoreUpdateRequestModel.outByPlayer=0;
                        scoreUpdateRequestModel.outPlayer=0;
                        scoreUpdateRequestModel.totalWicket=0;
                        scoreUpdateRequestModel.fieldingPositionsId=0;
                        scoreUpdateRequestModel.endInnings=false;
                        ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value) async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setInt('over_number', value.data!.overNumber??0);
                          await prefs.setInt('ball_number', value.data!.ballNumber??1);
                          await prefs.setInt('striker_id', value.data!.strikerId??0);
                          await prefs.setInt('non_striker_id', value.data!.nonStrikerId??0);

                          Navigator.pop(context);
                        });
                      },child: OkBtn("Save")),
                    ],
                  ),
                ),
              )

            ],
          ),
        );
      })
  );
}

Future<void> _displayBottomSheetByes (BuildContext context,int ballType,ScoringDeatailResponseModel? scoringData) async{
  int? isOffSideSelected ;
  int? isWideSelected ;
  List<Map<String, dynamic>> chipData =[
    {
      'label': '1 B',
    },
    {
      'label': '2 B',
    },
    {
      'label': '3 B',
    },
    {
      'label': '4 B',
    },
    {
      'label': '5 B',
    },
    {
      'label': '6 B',
    },
    {
      'label': '7 B',
    },

  ];
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context)=> StatefulBuilder(builder: (context, setState){
        return Container(
          height: 33.h,
          // padding: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: BoxDecoration(
              color: AppColor.lightColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w,)+EdgeInsets.only(top: 2.h,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,size: 7.w,)),
                    Text("Byes",style: fontMedium.copyWith(
                      fontSize: 17.sp,
                      color: AppColor.blackColour,
                    ),),
                    SizedBox(width: 7.w,),
                  ],
                ),
              ),
              SizedBox(height: 1.h,),
              Divider(
                color: Color(0xffD3D3D3),
              ),
              SizedBox(height: 1.h,),
              Padding(
                padding:  EdgeInsets.only(left: 15.w,right: 15.w),
                child: Wrap(
                  spacing: 4.w, // Horizontal spacing between items
                  runSpacing: 1.h, // Vertical spacing between lines
                  alignment: WrapAlignment.center, // Alignment of items
                  children:chipData.map((data) {
                    final index = chipData.indexOf(data);
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          isWideSelected=index;
                        });
                      },
                      child: Chip(
                        padding: EdgeInsets.symmetric(horizontal: 1.5.w,vertical: 0.5.h),
                        label: Text(data['label'],style: fontSemiBold.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackColour
                        ),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(
                            color: Color(0xffDADADA),
                          ),
                        ),
                        backgroundColor: isWideSelected==index? AppColor.primaryColor : Color(0xffF8F9FA),
                        // backgroundColor:AppColor.lightColor
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 1.5.h,),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(onTap:()async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var overNumber= prefs.getInt('over_number')??0;
                        var ballNumber= prefs.getInt('ball_number')??0;
                        var strikerId=prefs.getInt('striker_id')??0;
                        var nonStrikerId=prefs.getInt('non_striker_id')??0;

                        ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
                        scoreUpdateRequestModel.ballTypeId=ballType??0;
                        scoreUpdateRequestModel.matchId=scoringData!.data!.batting![0].matchId;
                        scoreUpdateRequestModel.scorerId=1;
                        scoreUpdateRequestModel.strikerId=strikerId;
                        scoreUpdateRequestModel.nonStrikerId=nonStrikerId;
                        scoreUpdateRequestModel.wicketKeeperId=23;
                        scoreUpdateRequestModel.bowlerId=scoringData!.data!.bowling!.playerId??0;
                        scoreUpdateRequestModel.overNumber=overNumber;
                        scoreUpdateRequestModel.ballNumber=ballNumber;

                        scoreUpdateRequestModel.runsScored=isWideSelected??0;
                        scoreUpdateRequestModel.extras=0;
                        scoreUpdateRequestModel.wicket=0;
                        scoreUpdateRequestModel.dismissalType=0;
                        scoreUpdateRequestModel.commentary=0;
                        scoreUpdateRequestModel.innings=1;
                        scoreUpdateRequestModel.battingTeamId=scoringData!.data!.batting![0].teamId??0;
                        scoreUpdateRequestModel.bowlingTeamId=scoringData!.data!.bowling!.teamId??0;
                        scoreUpdateRequestModel.overBowled=0;
                        scoreUpdateRequestModel.totalOverBowled=0;
                        scoreUpdateRequestModel.outByPlayer=0;
                        scoreUpdateRequestModel.outPlayer=0;
                        scoreUpdateRequestModel.totalWicket=0;
                        scoreUpdateRequestModel.fieldingPositionsId=0;
                        scoreUpdateRequestModel.endInnings=false;
                        ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value)async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setInt('over_number', value.data!.overNumber??0);
                          await prefs.setInt('ball_number', value.data!.ballNumber??1);
                          await prefs.setInt('striker_id', value.data!.strikerId??0);
                          await prefs.setInt('non_striker_id', value.data!.nonStrikerId??0);
                          Navigator.pop(context);
                        });
                      },child: OkBtn("Save")),
                    ],
                  ),
                ),
              )

            ],
          ),
        );
      })
  );
}

Future<void> _displayBottomSheetMoreRuns (BuildContext context,int ballType,ScoringDeatailResponseModel? scoringData) async{
  int? isOffSideSelected ;
  int? isWideSelected ;
  List<Map<String, dynamic>> chipData =[
    {
      'label': "1",
    },
    {
      'label': '2',
    },
    {
      'label': '3',
    },
    {
      'label': '4',
    },
    {
      'label': '5',
    },
    {
      'label': '6',
    },
    {
      'label': '7',
    },

  ];
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context)=> StatefulBuilder(builder: (context, setState){
        return Container(
          height: 33.h,
          // padding: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: const BoxDecoration(
              color: AppColor.lightColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w,)+EdgeInsets.only(top: 2.h,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,size: 7.w,)),
                    Text("More Runs",style: fontMedium.copyWith(
                      fontSize: 17.sp,
                      color: AppColor.blackColour,
                    ),),
                    SizedBox(width: 7.w,),
                  ],
                ),
              ),
              SizedBox(height: 1.h,),
              const Divider(
                color: Color(0xffD3D3D3),
              ),
              SizedBox(height: 1.h,),
              Padding(
                padding:  EdgeInsets.only(left: 10.w,right: 5.w),
                child: Wrap(
                  spacing: 10.w, // Horizontal spacing between items
                  runSpacing: 1.h, // Vertical spacing between lines
                  alignment: WrapAlignment.center, // Alignment of items
                  children:chipData.map((data) {
                    final index = chipData.indexOf(data);
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          isWideSelected=index;
                        });
                      },
                      child: Chip(
                        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 0.8.h),
                        label: Text(data['label'],style: fontSemiBold.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackColour
                        ),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: const BorderSide(
                            color: Color(0xffDADADA),
                          ),
                        ),
                        backgroundColor: isWideSelected==index? AppColor.primaryColor : Color(0xffF8F9FA),
                        // backgroundColor:AppColor.lightColor
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 1.5.h,),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(onTap:()async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var overNumber= prefs.getInt('over_number')??0;
                        var ballNumber= prefs.getInt('ball_number')??0;
                        var strikerId=prefs.getInt('striker_id')??0;
                        var nonStrikerId=prefs.getInt('non_striker_id')??0;

                        ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
                        scoreUpdateRequestModel.ballTypeId=ballType??0;
                        scoreUpdateRequestModel.matchId=scoringData!.data!.batting![0].matchId;
                        scoreUpdateRequestModel.scorerId=1;
                        scoreUpdateRequestModel.strikerId=strikerId;
                        scoreUpdateRequestModel.nonStrikerId=nonStrikerId;
                        scoreUpdateRequestModel.wicketKeeperId=23;
                        scoreUpdateRequestModel.bowlerId=scoringData!.data!.bowling!.playerId??0;
                        scoreUpdateRequestModel.overNumber=overNumber;
                        scoreUpdateRequestModel.ballNumber=ballNumber;

                        scoreUpdateRequestModel.runsScored=isWideSelected??0;
                        scoreUpdateRequestModel.extras=0;
                        scoreUpdateRequestModel.wicket=0;
                        scoreUpdateRequestModel.dismissalType=0;
                        scoreUpdateRequestModel.commentary=0;
                        scoreUpdateRequestModel.innings=1;
                        scoreUpdateRequestModel.battingTeamId=scoringData!.data!.batting![0].teamId??0;
                        scoreUpdateRequestModel.bowlingTeamId=scoringData!.data!.bowling!.teamId??0;
                        scoreUpdateRequestModel.overBowled=0;
                        scoreUpdateRequestModel.totalOverBowled=0;
                        scoreUpdateRequestModel.outByPlayer=0;
                        scoreUpdateRequestModel.outPlayer=0;
                        scoreUpdateRequestModel.totalWicket=0;
                        scoreUpdateRequestModel.fieldingPositionsId=0;
                        scoreUpdateRequestModel.endInnings=false;
                        ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value) async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setInt('over_number', value.data!.overNumber??0);
                          await prefs.setInt('ball_number', value.data!.ballNumber??1);
                          await prefs.setInt('striker_id', value.data!.strikerId??0);
                          await prefs.setInt('non_striker_id', value.data!.nonStrikerId??0);
                          Navigator.pop(context);
                        });
                      },child: OkBtn("Save")),
                    ],
                  ),
                ),
              )

            ],
          ),
        );
      })
  );
}

Future<void> _displayBottomSheetBonus (BuildContext context, int? ballType, ScoringDeatailResponseModel? scoringData,) async{
  int? isOffSideSelected=1 ;
  int? isWideSelected ;
  List<Map<String, dynamic>> chipData=[
    {
      'label': "+ 1",
    },
    {
      'label': '+ 2',
    },
    {
      'label': '+ 3',
    },
    {
      'label': '+ 4',
    },
    {
      'label': '+ 5',
    },
    {
      'label': '+ 6',
    },
    {
      'label': '+ 7',
    },
  ];
  List<Map<String, dynamic>> displayedChipData = chipData;
  List<Map<String, dynamic>> chipData2 =[
    {
      'label': "- 1",
    },
    {
      'label': '- 2',
    },
    {
      'label': '- 3',
    },
    {
      'label': '- 4',
    },
    {
      'label': '- 5',
    },
    {
      'label': '- 6',
    },
    {
      'label': '- 7',
    },

  ];
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context)=> StatefulBuilder(builder: (context, setState){
        return Container(
          height: 33.h,
          // padding: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: BoxDecoration(
              color: AppColor.lightColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w,)+EdgeInsets.only(top: 2.h,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,size: 7.w,)),
                    Text("Bonus/Penalty",style: fontMedium.copyWith(
                      fontSize: 17.sp,
                      color: AppColor.blackColour,
                    ),),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              displayedChipData = chipData;
                              ballType=11;
                              isOffSideSelected=1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: AppColor.blackColour),
                              color: isOffSideSelected==1?AppColor.blackColour:AppColor.lightColor,
                            ),
                            child: Icon(Icons.add,color: isOffSideSelected==1?AppColor.lightColor:AppColor.blackColour,size: 30,),
                          ),
                        ),
                        SizedBox(width: 2.w,),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              displayedChipData = chipData2;
                              ballType=12;
                              isOffSideSelected=2;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: AppColor.blackColour),
                              color: isOffSideSelected==2?AppColor.blackColour:AppColor.lightColor,
                            ),
                            child: Icon(Icons.remove,color: isOffSideSelected==2?AppColor.lightColor:AppColor.blackColour,size:30,),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 1.h,),
              Divider(
                color: Color(0xffD3D3D3),
              ),
              SizedBox(height: 1.h,),
              Padding(
                padding:  EdgeInsets.only(left: 5.w,right: 4.w),
                child: Wrap(
                  spacing: 5.w, // Horizontal spacing between items
                  runSpacing: 0.5.h, // Vertical spacing between lines
                  alignment: WrapAlignment.center, // Alignment of items
                  children:displayedChipData.map((data) {
                    final index = displayedChipData.indexOf(data);
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          isWideSelected=index;
                        });
                      },
                      child: Chip(
                        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 0.8.h),
                        label: Text(data['label'],style: fontSemiBold.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackColour
                        ),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(
                            color: Color(0xffDADADA),
                          ),
                        ),
                        backgroundColor: isWideSelected==index? AppColor.primaryColor : Color(0xffF8F9FA),
                        // backgroundColor:AppColor.lightColor
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 1.5.h,),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(onTap:()async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var overNumber= prefs.getInt('over_number')??0;
                        var ballNumber= prefs.getInt('ball_number')??0;
                        var strikerId=prefs.getInt('striker_id')??0;
                        var nonStrikerId=prefs.getInt('non_striker_id')??0;

                        ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
                        scoreUpdateRequestModel.ballTypeId=ballType??0;
                        scoreUpdateRequestModel.matchId=scoringData!.data!.batting![0].matchId;
                        scoreUpdateRequestModel.scorerId=1;
                        scoreUpdateRequestModel.strikerId=strikerId;
                        scoreUpdateRequestModel.nonStrikerId=nonStrikerId;
                        scoreUpdateRequestModel.wicketKeeperId=23;
                        scoreUpdateRequestModel.bowlerId=scoringData!.data!.bowling!.playerId??0;
                        scoreUpdateRequestModel.overNumber=overNumber;
                        scoreUpdateRequestModel.ballNumber=ballNumber;

                        scoreUpdateRequestModel.runsScored=(isWideSelected??0)+1;
                        scoreUpdateRequestModel.extras=0;
                        scoreUpdateRequestModel.wicket=0;
                        scoreUpdateRequestModel.dismissalType=0;
                        scoreUpdateRequestModel.commentary=0;
                        scoreUpdateRequestModel.innings=1;
                        scoreUpdateRequestModel.battingTeamId=scoringData!.data!.batting![0].teamId??0;
                        scoreUpdateRequestModel.bowlingTeamId=scoringData!.data!.bowling!.teamId??0;
                        scoreUpdateRequestModel.overBowled=0;
                        scoreUpdateRequestModel.totalOverBowled=0;
                        scoreUpdateRequestModel.outByPlayer=0;
                        scoreUpdateRequestModel.outPlayer=0;
                        scoreUpdateRequestModel.totalWicket=0;
                        scoreUpdateRequestModel.fieldingPositionsId=0;
                        scoreUpdateRequestModel.endInnings=false;
                        ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value) async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setInt('over_number', value.data!.overNumber??0);
                          await prefs.setInt('ball_number', value.data!.ballNumber??1);
                          await prefs.setInt('striker_id', value.data!.strikerId??0);
                          await prefs.setInt('non_striker_id', value.data!.nonStrikerId??0);
                          Navigator.pop(context);
                        });
                      },child: OkBtn("Save")),
                    ],
                  ),
                ),
              )

            ],
          ),
        );
      })
  );
}

Future<void> _displayBottomSheetSettings (BuildContext context) async{
  bool value1=false;bool value2=false;bool value3=false;bool value4=false;
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context)=> StatefulBuilder(builder: (context, setState){
        return Container(
          height: 45.h,
          // padding: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: const BoxDecoration(
              color: AppColor.lightColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,size: 7.w,)),
                    Text("Settings",style: fontMedium.copyWith(
                      fontSize: 17.sp,
                      color: AppColor.blackColour,
                    ),),
                    SizedBox(width: 7.w,),
                  ],
                ),
                SizedBox(height: 1.h,),
                const Divider(
                  color: Color(0xffD3D3D3),
                ),
                SizedBox(height: 1.h,),
                Row(
                  children: [
                    Text("Scoring area",style: fontMedium.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.blackColour,
                    ),),
                    Spacer(),
                    Switch(value: value1,
                        onChanged:(bool newValue) {
                          setState(() {
                            value1 = newValue;
                          });
                        })
                  ],
                ),
                SizedBox(height: 0.5.h,),
                DottedLine(
                  dashColor: Color(0xffD2D2D2),
                ),
                Row(
                  children: [
                    Text("Bowling area",style: fontMedium.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.blackColour,
                    ),),
                    Spacer(),
                    Switch(value: value2,
                        onChanged:(bool newValue) {
                          setState(() {
                            value2 = newValue;
                          });
                        })
                  ],
                ),
                SizedBox(height: 0.5.h,),
                DottedLine(
                  dashColor: Color(0xffD2D2D2),
                ),
                Row(
                  children: [
                    Text("Extras wide",style: fontMedium.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.blackColour,
                    ),),
                    Spacer(),
                    Switch(value: value3,
                        onChanged:(bool newValue) {
                          setState(() {
                            value3 = newValue;
                          });
                        })
                  ],
                ),
                SizedBox(height: 0.5.h,),
                DottedLine(
                  dashColor: Color(0xffD2D2D2),
                ),
                Row(
                  children: [
                    Text("No ball run",style: fontMedium.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.blackColour,
                    ),),
                    Spacer(),
                    Switch(value: value4,
                        onChanged:(bool newValue) {
                          setState(() {
                            value4 = newValue;
                          });
                        })
                  ],
                ),
                SizedBox(height: 0.5.h,),
                DottedLine(
                  dashColor: Color(0xffD2D2D2),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap:(){
                            Navigator.pop(context);
                          },
                          child: CancelBtn("Reset")),
                      SizedBox(width: 4.w,),
                      OkBtn("Save"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      })
  );
}

Future<void> _displayBottomSheetOther (BuildContext context) async{
  int? isOffSideSelected ;
  int? isWideSelected ;
  List<Map<String, dynamic>> chipData =[
    {
      'label': "Match break",
    },
    {
      'label': 'Settings',
    },
    {
      'label': 'End Innings',
    },
    {
      'label': 'D/L Method',
    },
    {
      'label': 'Change keeper',
    },
    {
      'label': 'Abandon',
    },
    {
      'label': 'Change target',
    },

  ];
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context)=> StatefulBuilder(builder: (context, setState){
        return Container(
          height: 33.h,
          // padding: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: const BoxDecoration(
              color: AppColor.lightColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w,)+EdgeInsets.only(top: 2.h,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,size: 7.w,)),
                    Text("Other",style: fontMedium.copyWith(
                      fontSize: 17.sp,
                      color: AppColor.blackColour,
                    ),),
                    SizedBox(width: 7.w,),
                  ],
                ),
              ),
              SizedBox(height: 1.h,),
              const Divider(
                color: Color(0xffD3D3D3),
              ),
              SizedBox(height: 1.h,),
              Padding(
                padding:  EdgeInsets.only(left: 2.w,right: 2.w),
                child: Wrap(
                  spacing: 2.w, // Horizontal spacing between items
                  runSpacing: 1.h, // Vertical spacing between lines
                  alignment: WrapAlignment.center, // Alignment of items
                  children:chipData.map((data) {
                    final index = chipData.indexOf(data);
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          isWideSelected=index;
                        });
                        if (data['label'] == 'Match break'){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DialogsOthers();
                            },
                          );
                        }
                        if (data['label'] == 'Change target'){
                        showDialog(
                        context: context,
                        builder: (BuildContext context) {
                        return ChangeTargetDialog();
                        },
                        );
                        }
                        if (data['label'] == 'D/L Method'){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DlMethodDialog();
                            },
                          );
                        }
                        if (data['label'] == 'Settings'){
                          _displayBottomSheetSettings(context);
                        }

                      },
                      child: Chip(
                        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 0.8.h),
                        label: Text(data['label'],style: fontSemiBold.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackColour
                        ),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: const BorderSide(
                            color: Color(0xffDADADA),
                          ),
                        ),
                        backgroundColor: isWideSelected==index? AppColor.primaryColor : Color(0xffF8F9FA),
                        // backgroundColor:AppColor.lightColor
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      })
  );
}

//Out
Future<void> _displayBottomOut (BuildContext context) async{
  int? isOffSideSelected ;
  int? isWideSelected ;
  List<Map<String, dynamic>> chipData =[
    {
      'label': "Bowled",
    },
    {
      'label': 'Caught',
    },
    {
      'label': 'Stumped',
    },
    {
      'label': 'LBW',
    },
    {
      'label': 'Caught Behind',
    },
    {
      'label': 'Caught & Bowled',
    },
    {
      'label': ' Run Out',
    },
    {
      'label': 'Run out (Mankaded)',
    },
    {
      'label': 'Retired Hurt',
    },
    {
      'label': 'Hit Wicket',
    },
    {
      'label': 'Retired',
    },
    {
      'label': 'Retired Out',
    },
    {
      'label': 'Handling the Ball',
    },
    {
      'label': 'Hit the Ball Twice',
    },
    {
      'label': 'Obstruct the field',
    },
    {
      'label': 'Timed Out',
    },
    {
      'label': 'Absence Hurt',
    },

  ];
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context)=> StatefulBuilder(builder: (context, setState){
        return Container(
          // height: 33.h,
          // padding: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: const BoxDecoration(
              color: AppColor.lightColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w,)+EdgeInsets.only(top: 2.h,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,size: 7.w,)),
                    Text("Select out method",style: fontMedium.copyWith(
                      fontSize: 17.sp,
                      color: AppColor.blackColour,
                    ),),
                    SizedBox(width: 7.w,),
                  ],
                ),
              ),
              SizedBox(height: 1.h,),
              const Divider(
                color: Color(0xffD3D3D3),
              ),
              SizedBox(height: 1.h,),
              Padding(
                padding:  EdgeInsets.only(left: 2.w,right: 2.w),
                child: Wrap(
                  spacing: 2.w, // Horizontal spacing between items
                  runSpacing: 1.h, // Vertical spacing between lines
                  alignment: WrapAlignment.center, // Alignment of items
                  children:chipData.map((data) {
                    final index = chipData.indexOf(data);
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          isWideSelected=index;
                        });
                        if (data['label'] == 'Bowled'){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return OutMethodDialog(label: 'Bowled',);
                            },
                          );
                        }
                        if (data['label'] == 'LBW'){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return OutMethodDialog(label: 'LBW',);
                            },
                          );
                        }
                        if (data['label'] == 'Caught Behind'){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return OutMethodDialog(label: 'Caught Behind',);
                            },
                          );
                        }
                        if (data['label'] == 'Caught & Bowled'){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return OutMethodDialog(label: 'Caught & Bowled',);
                            },
                          );
                        }
                        if (data['label'] == 'Run out (Mankaded)'){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return OutMethodDialog(label: 'Mankaded',);
                            },
                          );
                        }
                        if (data['label'] == 'Hit Wicket'){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return OutMethodDialog(label: 'Hit Wicket',);
                            },
                          );
                        }
                        if (data['label'] == 'Handling the Ball'){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return OutMethodDialog(label: 'Handling the Ball',);
                            },
                          );
                        }
                        if (data['label'] == 'Hit the Ball Twice'){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return OutMethodDialog(label: 'Hit the Ball Twice',);
                            },
                          );
                        }
                        if (data['label'] == ' Run Out'){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RunOutScreen()));
                        }
                        if (data['label'] == 'Retired Hurt'){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RetiredHurtScreen()));
                        }
                      },
                      child: Chip(
                        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 0.8.h),
                        label: Text(data['label'],style: fontSemiBold.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackColour
                        ),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: const BorderSide(
                            color: Color(0xffDADADA),
                          ),
                        ),
                        backgroundColor: isWideSelected==index? AppColor.primaryColor : Color(0xffF8F9FA),
                        // backgroundColor:AppColor.lightColor
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      })
  );
}


