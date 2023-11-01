// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../models/score_update_request_model.dart';
// import '../../models/score_update_response_model.dart';
// import '../../models/scoring_detail_response_model.dart';
// import '../../provider/player_selection_provider.dart';
// import '../../provider/score_update_provider.dart';
// import '../../provider/scoring_provider.dart';
// import '../widgets/scorer_grid_item.dart';
//
// class DotBall extends StatefulWidget {
//   final String matchId;
//   final VoidCallback refreshData;
//   final Function(String) changeBatsman;
//   const DotBall(this.matchId, this.refreshData, this.changeBatsman, {super.key});
//
//   @override
//   State<DotBall> createState() => _DotBallState();
// }
//
// class _DotBallState extends State<DotBall> {
//
//   ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
//   ScoringDetailResponseModel? scoringData;
//   ScoreUpdateResponseModel scoreUpdateResponseModel=ScoreUpdateResponseModel();
//   int bowlerPosition=0;
//   int index1=0;
//
//   @override
//   Widget build(BuildContext context) {
//     final player = Provider.of<PlayerSelectionProvider>(context, listen: false);
//     final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
//     return GestureDetector(
//         onTap:()async {
//
//           print("striker id ${player.selectedStrikerId}");
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           var oversBowled=prefs.getInt('overs_bowled')??0;
//
//           scoreUpdateRequestModel.ballTypeId=0;
//           scoreUpdateRequestModel.matchId=int.parse(widget.matchId);
//           scoreUpdateRequestModel.scorerId=1;
//           scoreUpdateRequestModel.strikerId=int.parse(player.selectedStrikerId.toString());
//           scoreUpdateRequestModel.nonStrikerId=int.parse(player.selectedNonStrikerId.toString());
//           scoreUpdateRequestModel.wicketKeeperId=int.parse(player.selectedWicketKeeperId.toString());
//           scoreUpdateRequestModel.bowlerId=int.parse(player.selectedBowlerId.toString());
//           scoreUpdateRequestModel.overNumber=int.parse(score.overNumberInnings.toString());
//           scoreUpdateRequestModel.ballNumber=int.parse(score.ballNumberInnings.toString());
//           scoreUpdateRequestModel.runsScored=0;
//           scoreUpdateRequestModel.extras=0;
//           scoreUpdateRequestModel.wicket=0;
//           scoreUpdateRequestModel.dismissalType=0;
//           scoreUpdateRequestModel.commentary=0;
//           scoreUpdateRequestModel.innings=1;
//           scoreUpdateRequestModel.battingTeamId=scoringData!.data!.batting![index1].teamId??0;
//           scoreUpdateRequestModel.bowlingTeamId=scoringData!.data!.bowling!.teamId??0;
//           scoreUpdateRequestModel.overBowled=oversBowled;
//           scoreUpdateRequestModel.totalOverBowled=0;
//           scoreUpdateRequestModel.outByPlayer=0;
//           scoreUpdateRequestModel.outPlayer=0;
//           scoreUpdateRequestModel.totalWicket=0;
//           scoreUpdateRequestModel.fieldingPositionsId=0;
//           scoreUpdateRequestModel.endInnings=false;
//           scoreUpdateRequestModel.bowlerPosition=bowlerPosition;
//           print("updating score");
//           ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value)async {
//             setState(() {
//               scoreUpdateResponseModel=value;
//             });
//             print("after score update");
//             print(value.data!.overNumber.toString());
//             print(value.data!.ballNumber.toString());
//             print(value.data!.bowlerChange.toString());
//             print("score update print end");
//             print("setting values to provider from score update response");
//             score.setOverNumber(value.data!.overNumber??0);
//             score.setBallNumber(value.data!.ballNumber??0);
//             score.setBowlerChangeValue(value.data!.bowlerChange??0);
//             player.setStrikerId(value.data!.strikerId.toString(), "");
//             player.setNonStrikerId(value.data!.nonStrikerId.toString(), "");
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             await prefs.setInt('bowlerPosition', 0);
//             //if both striker and non-striker are not present - change batsman
//             if(value.data!.strikerId==0 || value.data!.nonStrikerId==0){
//               String player = (value.data!.strikerId==0) ? 'striker_id':'non_striker_id';
//               widget.changeBatsman(player);
//             }
//             widget.refreshData();
//           });
//         },
//         child: const ScorerGridItem('0','DOT'));
//   }
//
// }
