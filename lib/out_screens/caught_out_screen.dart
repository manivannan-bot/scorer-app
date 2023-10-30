import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:scorer/widgets/cancel_btn.dart';
import 'package:scorer/widgets/ok_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../models/player_list_model.dart';
import '../models/score_update_request_model.dart';
import '../models/scoring_detail_response_model.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class CaughtOutScreen extends StatefulWidget {
  final int ballType;
  final ScoringDetailResponseModel? scoringData;
  const CaughtOutScreen({required this.ballType,required this.scoringData,super.key});

  @override
  State<CaughtOutScreen> createState() => _CaughtOutScreenState();
}

class _CaughtOutScreenState extends State<CaughtOutScreen> {
  int? localBowlerIndex;
  int? selectedBowler;
  List<BowlingPlayers>? itemsBowler= [];
  String? selectedBTeamName ="";
  String selectedBowlerName = "";
  int? selectedBowlerId;
  @override
  void initState() {
    super.initState();
    fetchPlayers();
  }
 fetchPlayers()async{
   final response = await ScoringProvider().getPlayerList(widget.scoringData!.data!.bowling!.matchId.toString(), widget.scoringData!.data!.bowling!.teamId.toString(),'bowl');
   setState(() {
     itemsBowler = response.bowlingPlayers!;
     selectedBTeamName= response.team!.teamName??'-';

   });
 }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF8F9FA),
        body: Container(
          height: 90.h,
          padding: EdgeInsets.symmetric(vertical: 2.h),
          decoration: BoxDecoration(
              color: AppColor.lightColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,size: 7.w,)),
                    Text("Caught",style: fontMedium.copyWith(
                      fontSize: 18.sp,
                      color: AppColor.blackColour,
                    ),),
                    SizedBox(width: 7.w,),
                  ],
                ),
              ),
              SizedBox(height: 4.h,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.h),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffF8F9FA),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.2.h),
                    child: Row(
                      children: [
                        Text("Search players",style: fontRegular.copyWith(
                          fontSize: 12.sp,
                          color: Color(0xff707B81),
                        ),),
                        Spacer(),
                        SvgPicture.asset(Images.searchIcon)
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text('${selectedBTeamName}',style: fontMedium.copyWith(
                    fontSize:14.sp,
                    color: AppColor.pri
                ),),
              ),

              Divider(
                thickness:1,
                color: Color(0xffD3D3D3),
              ),
              Expanded(
                child:   ListView.separated(
                  separatorBuilder:(context ,_) {
                    return const Divider(
                      thickness: 0.6,
                    );
                  },
                  itemCount: itemsBowler!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {

                          if (localBowlerIndex  == index) {
                            localBowlerIndex  = null;
                            selectedBowlerId=0;
                          } else {
                            localBowlerIndex  = index;
                            selectedBowlerId=itemsBowler![localBowlerIndex!].playerId!;
                          }


                        });
                      },
                      child:Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.5.w,vertical: 1.h),
                        child: Row(
                          children: [
                            //circular button
                            Container(
                              height: 20.0, // Adjust the height as needed
                              width: 20.0,  // Adjust the width as needed
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: localBowlerIndex == index ? Colors.blue : Colors.grey, // Change colors based on selected index
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.circle_outlined, // You can change the icon as needed
                                  color: Colors.white, // Icon color
                                  size: 20.0, // Icon size
                                ),
                              ),
                            ), SizedBox(width: 3.w,),
                            Image.asset(Images.playersImage,width: 10.w,),
                            SizedBox(width: 2.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${itemsBowler![index].playerName??'-'}",style: fontMedium.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.blackColour,
                                ),),
                                Row(
                                  children: [
                                    Container(
                                      height:1.h,
                                      width: 2.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColor.pri,
                                      ),
                                    ),
                                    SizedBox(width: 2.w,),
                                    Text(itemsBowler![index].bowlingStyle??'-',style: fontMedium.copyWith(
                                        fontSize: 11.sp,
                                        color: Color(0xff555555)
                                    ),),
                                  ],
                                ),

                              ],
                            ),
                            Spacer(),
                            // Row(
                            //   children: [
                            //     Text("25 ",style: fontRegular.copyWith(
                            //       fontSize: 11.sp,
                            //       color: AppColor.blackColour,
                            //     ),),
                            //     Text("(10) ",style: fontRegular.copyWith(
                            //       fontSize: 11.sp,
                            //       color: AppColor.blackColour,
                            //     ),)
                            //   ],
                            // )
                          ],
                        ),
                      ),

                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 5.w),
                decoration: const BoxDecoration(
                  color: AppColor.lightColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(onTap:(){
                      Navigator.pop(context);
                    },
                        child: CancelBtn("Cancel")),
                    SizedBox(width: 2.w,),
                    GestureDetector(onTap:()async {

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      var overNumber= prefs.getInt('over_number');
                      var ballNumber= prefs.getInt('ball_number');
                      var strikerId=prefs.getInt('striker_id')??0;
                      var nonStrikerId=prefs.getInt('non_striker_id')??0;
                      var bowlerId=prefs.getInt('bowler_id')??0;
var oversBowled=prefs.getInt('overs_bowled')??0;
                      var keeperId=prefs.getInt('wicket_keeper_id')??0;
                      var bowlerPosition=prefs.getInt('bowlerPosition')??0;

                      if(selectedBowlerId==0) {
                        ScoreUpdateRequestModel scoreUpdateRequestModel = ScoreUpdateRequestModel();
                        scoreUpdateRequestModel.ballTypeId = 14;
                        scoreUpdateRequestModel.matchId = widget.scoringData!
                            .data!.batting![0].matchId;
                        scoreUpdateRequestModel.scorerId = 1;
                        scoreUpdateRequestModel.strikerId = strikerId;
                        scoreUpdateRequestModel.nonStrikerId = nonStrikerId;
                        scoreUpdateRequestModel.wicketKeeperId = keeperId;
                        scoreUpdateRequestModel.bowlerId = bowlerId;
                        scoreUpdateRequestModel.overNumber = overNumber;
                        scoreUpdateRequestModel.ballNumber = ballNumber;
                        scoreUpdateRequestModel.runsScored = 0;
                        scoreUpdateRequestModel.extras = 0;
                        scoreUpdateRequestModel.wicket = 0;
                        scoreUpdateRequestModel.dismissalType = widget.ballType;
                        scoreUpdateRequestModel.commentary = 0;
                        scoreUpdateRequestModel.innings = 1;
                        scoreUpdateRequestModel.battingTeamId = widget
                            .scoringData!.data!.batting![0].teamId ?? 0;
                        scoreUpdateRequestModel.bowlingTeamId = widget
                            .scoringData!.data!.bowling!.teamId ?? 0;
                        scoreUpdateRequestModel.overBowled=oversBowled;
                        scoreUpdateRequestModel.totalOverBowled = 0;
                        scoreUpdateRequestModel.outByPlayer = selectedBowlerId;
                        scoreUpdateRequestModel.outPlayer = strikerId;
                        scoreUpdateRequestModel.totalWicket = 0;
                        scoreUpdateRequestModel.fieldingPositionsId = 0;
                        scoreUpdateRequestModel.endInnings = false;
                        scoreUpdateRequestModel.bowlerPosition =  bowlerPosition;
                        ScoringProvider()
                            .scoreUpdate(scoreUpdateRequestModel)
                            .then((value) async {
                          SharedPreferences prefs = await SharedPreferences
                              .getInstance();
                          await prefs.setInt(
                              'over_number', value.data!.overNumber ?? 0);
                          await prefs.setInt(
                              'ball_number', value.data!.ballNumber ?? 1);
                          await prefs.setInt(
                              'striker_id', value.data!.strikerId ?? 0);
                          await prefs.setInt(
                              'non_striker_id', value.data!.nonStrikerId ?? 0);
                        });
                        Navigator.pop(context);
                      }else{
                        final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Please select one player',style: fontRegular.copyWith(color: Colors.white),),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                    },child: OkBtn("Ok")),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


}
