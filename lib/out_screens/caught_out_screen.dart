import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:scorer/widgets/cancel_btn.dart';
import 'package:scorer/widgets/ok_btn.dart';
import 'package:scorer/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../Scoring screens/home_screen.dart';
import '../models/player_list_model.dart';
import '../models/score_update_request_model.dart';
import '../models/scoring_detail_response_model.dart';
import '../provider/player_selection_provider.dart';
import '../provider/score_update_provider.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class CaughtOutScreen extends StatefulWidget {
  final int ballType;
  final ScoringDetailResponseModel? scoringData;
  final VoidCallback refresh;
  const CaughtOutScreen({required this.ballType,required this.scoringData, required this.refresh,super.key});

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
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: statusBarHeight + 2.h,),
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
          // SizedBox(height: 2.h,),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.h),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20),
          //       color: AppColor.lightColor,
          //     ),
          //     child: Padding(
          //       padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.2.h),
          //       child: Row(
          //         children: [
          //           Text("Search players",style: fontRegular.copyWith(
          //             fontSize: 12.sp,
          //             color: const Color(0xff707B81),
          //           ),),
          //           const Spacer(),
          //           SvgPicture.asset(Images.searchIcon)
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 4.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text('$selectedBTeamName',style: fontMedium.copyWith(
                fontSize:14.sp,
                color: AppColor.pri
            ),),
          ),
          Expanded(
            child: FadeIn(
              child: ListView.separated(
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
                            child: const Center(
                              child: Icon(
                                Icons.circle_outlined, // You can change the icon as needed
                                color: Colors.white, // Icon color
                                size: 20.0, // Icon size
                              ),
                            ),
                          ), SizedBox(width: 3.w,),
                          Image.network(Images.playersImage,width: 10.w,),
                          SizedBox(width: 2.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(itemsBowler![index].playerName??'-',style: fontMedium.copyWith(
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
                                      color: const Color(0xff555555)
                                  ),),
                                ],
                              ),

                            ],
                          ),
                          const Spacer(),
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
                    child: const CancelBtn("Cancel")),
                SizedBox(width: 2.w,),
                GestureDetector(onTap:()async {
                  final player = Provider.of<PlayerSelectionProvider>(context, listen: false);
                  final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
                  print("striker id ${player.selectedStrikerId}");
                  print("non striker id ${player.selectedNonStrikerId}");
                  print("passing over number to score update api ${score.overNumberInnings}");
                  print("passing ball number to score update api ${score.ballNumberInnings}");
                  print("passing overs bowled to score update api ${score.oversBowled}");
                  score.trackOvers(score.overNumberInnings, score.ballNumberInnings);

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  var bowlerPosition=prefs.getInt('bowlerPosition')??0;

                  if(selectedBowlerId!=0) {
                    ScoreUpdateRequestModel scoreUpdateRequestModel = ScoreUpdateRequestModel();
                    scoreUpdateRequestModel.ballTypeId = 14;
                    scoreUpdateRequestModel.matchId = widget.scoringData!
                        .data!.batting![0].matchId;
                    scoreUpdateRequestModel.scorerId = 46;
                    scoreUpdateRequestModel.strikerId = int.parse(player.selectedStrikerId.toString());
                    scoreUpdateRequestModel.nonStrikerId = int.parse(player.selectedNonStrikerId.toString());
                    scoreUpdateRequestModel.wicketKeeperId = int.parse(player.selectedWicketKeeperId.toString());
                    scoreUpdateRequestModel.bowlerId = int.parse(player.selectedBowlerId.toString());
                    scoreUpdateRequestModel.overNumber = score.overNumberInnings;
                    scoreUpdateRequestModel.ballNumber = score.ballNumberInnings;
                    scoreUpdateRequestModel.runsScored = 0;
                    scoreUpdateRequestModel.extras = 0;
                    scoreUpdateRequestModel.wicket = 0;
                    scoreUpdateRequestModel.extrasSlug=0;
                    scoreUpdateRequestModel.dismissalType = widget.ballType;
                    scoreUpdateRequestModel.commentary = 0;
                    scoreUpdateRequestModel.innings = score.innings;
                    scoreUpdateRequestModel.battingTeamId = widget
                        .scoringData!.data!.batting![0].teamId ?? 0;
                    scoreUpdateRequestModel.bowlingTeamId = widget
                        .scoringData!.data!.bowling!.teamId ?? 0;
                    scoreUpdateRequestModel.overBowled=score.oversBowled;
                    scoreUpdateRequestModel.totalOverBowled = 0;
                    scoreUpdateRequestModel.outByPlayer = selectedBowlerId;
                    scoreUpdateRequestModel.outPlayer = int.parse(player.selectedStrikerId.toString());
                    scoreUpdateRequestModel.totalWicket = 0;
                    scoreUpdateRequestModel.fieldingPositionsId = 0;
                    scoreUpdateRequestModel.endInnings = false;
                    scoreUpdateRequestModel.bowlerPosition =  bowlerPosition;
                    ScoringProvider()
                        .scoreUpdate(scoreUpdateRequestModel)
                        .then((value) async {
                      if(value.data?.innings == 3){
                        Dialogs.snackBar("Match Ended", context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      } else if(value.data?.inningCompleted == true){
                        print("end of innings");
                        print("navigating to home screen");
                        Dialogs.snackBar(value.data!.inningsMessage.toString(), context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      } else {
                        print("striker and non striker id - ${value.data?.strikerId.toString()} ${value.data?.nonStrikerId.toString()}");

                        print("after wicket update - caught");
                        print(value.data?.overNumber);
                        print(value.data?.ballNumber);
                        print(value.data?.bowlerChange);
                        print("score wicket print end - caught");

                        print("setting over number ${value.data?.overNumber} and ball number ${value.data?.ballNumber} and bowler change ${value.data?.bowlerChange} to provider after wicket update");
                        score.setOverNumber(value.data?.overNumber??0);
                        score.setBallNumber(value.data?.ballNumber??0);
                        score.setBowlerChangeValue(value.data?.bowlerChange??0);
                        player.setStrikerId(value.data!.strikerId.toString(), "");
                        player.setNonStrikerId(value.data!.nonStrikerId.toString(), "");
                        widget.refresh();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                      }
                    });
                  }
                  else{
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Dialogs.snackBar("Select one player", context, isError: true);
                    });
                  }

                },child: const OkBtn("Ok")),
              ],
            ),
          ),

        ],
      ),
    );
  }


}
