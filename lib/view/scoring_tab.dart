import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laravel_flutter_pusher/laravel_flutter_pusher.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scorer/models/scoring_detail_response_model.dart';
import 'package:scorer/provider/score_update_provider.dart';
import 'package:scorer/view/batsman_list_bottom_sheet.dart';
import 'package:scorer/view/bonus_bottom_sheet.dart';
import 'package:scorer/view/bowler_list_bottom_sheet.dart';
import 'package:scorer/view/deliveries/byes_bottom_sheet.dart';
import 'package:scorer/view/deliveries/no_ball_bottom_sheet.dart';
import 'package:scorer/view/deliveries/wide_bottom_sheet.dart';
import 'package:scorer/view/more_runs_bottom_sheet.dart';
import 'package:scorer/view/score_update_bottom_sheet.dart';
import 'package:scorer/view/settings_bottom_sheet.dart';
import 'package:scorer/view/widgets/boundary.dart';
import 'package:scorer/view/widgets/bowler_current_over_data.dart';
import 'package:scorer/view/widgets/runs_scored_and_balls_faced_text.dart';
import 'package:scorer/view/widgets/scorer_grid_four.dart';
import 'package:scorer/view/widgets/scorer_grid_item.dart';
import 'package:scorer/view/widgets/scorer_grid_out.dart';
import 'package:scorer/view/widgets/sixer.dart';
import 'package:scorer/view/widgets/swap_button.dart';
import 'package:scorer/view/widgets/wicket.dart';

import 'package:scorer/widgets/custom_vertical_dottedLine.dart';
import 'package:scorer/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';


import '../Scoring screens/wicket_options_bottom_sheet.dart';
import '../models/player_list_model.dart';

import '../models/save_batsman_request_model.dart';
import '../out_screens/caught_out_screen.dart';
import '../out_screens/obstruct_field_screen.dart';
import '../Scoring screens/retired_screen.dart';

import '../models/score_update_request_model.dart';

import '../models/score_update_response_model.dart';
import '../out_screens/retired _hurt_screen.dart';
import '../out_screens/run_out_screens.dart';
import '../out_screens/timeout_absence.dart';
import '../out_screens/undo_screen.dart';
import '../provider/player_selection_provider.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import '../widgets/cancel_btn.dart';
import '../widgets/custom_horizondal_dottedLine.dart';
import '../widgets/dialog_others.dart';
import '../widgets/ok_btn.dart';
import '../out_screens/out_method_dialog.dart';
import 'deliveries/leg_bye_bottom_sheet.dart';

class ScoringTab extends StatefulWidget {
  final String matchId;
  final String team1Id;
  final String team2Id;

  final VoidCallback fetchData;
  const ScoringTab(this.matchId, this.team1Id, this.team2Id, this.fetchData, {super.key});

  @override
  State<ScoringTab> createState() => _ScoringTabState();
}

class _ScoringTabState extends State<ScoringTab> {

  ScoringDetailResponseModel? scoringData;
  int index1=0;
  int index2=1;
  int totalBallId = 0;

  List<BowlingPlayers>? itemsBowler= [];
  List<BattingPlayers>? itemsBatsman = [];
  int? selectedBowler;
  String? selectedBTeamName ="";
  String selectedBowlerName = "";
  String? selectedTeamName ="";
  int? selectedBatsman;
  String selectedBatsmanName = "";
  bool showError=false;
  int bowlerPosition=0;

  bool searching = false;
  bool isResultEmpty = false;
  String searchedText = "";
  TextEditingController searchController = TextEditingController();
  List<BowlingPlayers> searchedList = [];
  List<BattingPlayers>? searchedBatsman = [];

  ScoringDetailResponseModel scoringDeatailResponseModel=ScoringDetailResponseModel();
  ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();

  ScoreUpdateResponseModel scoreUpdateResponseModel=ScoreUpdateResponseModel();

  void receiveDataFromScoreBottomSheet(ScoreUpdateResponseModel data1) {
    setState(() {
      scoreUpdateResponseModel = data1;
    });
  }
  RefreshController _refreshController = RefreshController();
  String eventData = 'No event received yet';

  @override
  void initState() {
    scoringData=null;
    super.initState();
    _refreshData();
    //setUpServices();
  }

  void setUpServices() {
    var options = PusherOptions(
        host: '64.227.139.48', port: 6001, encrypted: false, cluster: 'mt1');

    LaravelFlutterPusher pusher =
    LaravelFlutterPusher('app-key', options, enableLogging: true);
    pusher.subscribe('public.match.list').bind('matches', (event){
      setState(() {
        eventData = 'Event Data: $event';
      });
      print(eventData);

    });
  }

  void _refreshData() {
    widget.fetchData();
    ScoringProvider().getScoringDetail(widget.matchId).then((value) async {
      setState(() {
        scoringData = value;
        selectedBowlerName=scoringData!.data!.bowling!.playerName.toString();
      });
      final player = Provider.of<PlayerSelectionProvider>(context, listen: false);
      if(value.data?.batting?.first.striker == 1){
        player.setStrikerId(value.data!.batting!.first.playerId.toString(), value.data!.batting!.first.playerName.toString());
        player.setBowlerId(value.data!.bowling!.playerId.toString(), value.data!.bowling!.playerName.toString());
        player.setWicketKeeperId(value.data!.over!.last.wicketKeeperId.toString(), "");
      } else {
        player.setNonStrikerId(value.data!.batting!.first.playerId.toString(), value.data!.batting!.first.playerName.toString());
        player.setBowlerId(value.data!.bowling!.playerId.toString(), value.data!.bowling!.playerName.toString());
        player.setWicketKeeperId(value.data!.over!.last.wicketKeeperId.toString(), "");
      }

      if(value.data?.batting?.last.striker == 1){
        player.setStrikerId(value.data!.batting!.last.playerId.toString(), value.data!.batting!.last.playerName.toString());
        player.setBowlerId(value.data!.bowling!.playerId.toString(), value.data!.bowling!.playerName.toString());
        player.setWicketKeeperId(value.data!.over!.last.wicketKeeperId.toString(), "");
      } else {
        player.setNonStrikerId(value.data!.batting!.last.playerId.toString(), value.data!.batting!.last.playerName.toString());
        player.setBowlerId(value.data!.bowling!.playerId.toString(), value.data!.bowling!.playerName.toString());
        player.setWicketKeeperId(value.data!.over!.last.wicketKeeperId.toString(), "");
      }
      _refreshController.refreshCompleted();
    });
  }

  onSearchCategory(String search) {
    setState(() {
      searching = true;
      searchedText = search;
      searchedList = itemsBowler!.where((player) => player.playerName!.toLowerCase().toString().contains(search.toLowerCase())).toList();
      if (searchedList.isEmpty) {
        setState(() {
          isResultEmpty = true;
        });
      } else {
        setState(() {
          isResultEmpty = false;
        });
      }
      searching = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    if(scoringData==null || scoringData!.data ==null){
      return const SizedBox(
          height: 100,
          width: 100,
          child: Center(child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          )));
    }
    // if(scoringData!.data!.batting!.isEmpty || scoringData!.data!.bowling==null){
    //   return scoringData!.data!.batting!.isEmpty? const SizedBox(
    //       height: 100,
    //       width: 100,
    //       child: Center(child: Text('Please Select Batsman'))): const SizedBox(
    //       height: 100,
    //       width: 100,
    //       child: Center(child: Text('Please Select Bowler')));
    // }
    // if(scoringData!.data!.batting!.length<2){
    //   var player=scoringData!.data!.batting!.first.striker==1?'non_striker_id':'striker_id';
    //   // changeBatsman(player);
    //   return const SizedBox(height: 100, width: 100,
    //       child: Center(child: Text('Please Select Batsman')));
    // }
    int totalBallId = 0;
    showError=false;
    for (int index = 0; index < scoringData!.data!.over!.length; index++) {
      totalBallId += int.parse(scoringData!.data!.over![index].runsScored==null?'0':scoringData!.data!.over![index].runsScored.toString()); // Sum the ballIds
    }

    return Consumer<ScoreUpdateProvider>(
        builder: (context, innings, child) {
          if(innings.inningsCompleted == true){
            Navigator.pop(context);
          }
        return SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _refreshData,
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: SizedBox(
                        width: 100.w,
                        child: Column(
                          children: [
                            FadeIn(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:  EdgeInsets.only(right:4.w),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:EdgeInsets.only(bottom: 1.5.h),
                                            child: Row(
                                                children: [
                                                  Text(
                                                    'Batsman',
                                                    style: fontMedium.copyWith(
                                                        color: const Color(0xffD78108),
                                                        fontSize: 14.sp),
                                                  ),
                                                  const Spacer(),
                                                  GestureDetector(
                                                    onTap:()async{
                                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                                      var strikerId=prefs.getInt('striker_id')??0;
                                                      var nonStrikerId=prefs.getInt('non_striker_id')??0;
                                                      await prefs.setInt('non_striker_id',strikerId);
                                                      await prefs.setInt('striker_id',nonStrikerId);
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
                                                    child: SwapButton(),
                                                  ),
                                                ]),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text('${scoringData!.data!.batting![index1].playerName??'-'}',
                                                      style:  fontMedium.copyWith(
                                                          color: Colors.black, fontSize: 10.sp)),
                                                  SizedBox(width:1.w),
                                                  scoringData!.data!.batting![index1].striker == 1
                                                      ? SvgPicture.asset(Images.batIcon,
                                                      color: AppColor.locationIconColor) :  SizedBox(width:1.w),
                                                ],
                                              ),
                                              RunsScoredAndBallsFacedText(scoringData!.data!.batting![index1].runsScored.toString(), scoringData!.data!.batting![index1].ballsFaced.toString()),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.5.h,
                                          ),
                                          if(scoringData!.data!.batting!.length < 2)...[
                                            InkWell(
                                              onTap: (){
                                                if(scoringData!.data!.batting!.first.striker == 1){
                                                  changeBatsman("non_striker_id");
                                                } else {
                                                  changeBatsman("striker_id");
                                                }
                                              },
                                              child: Container(
                                                  width: double.maxFinite,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1.4.h
                                                  ),
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 5.w
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: AppColor.availableSlot.withOpacity(0.6),
                                                      borderRadius: BorderRadius.circular(10.0)
                                                  ),
                                                  child: Center(
                                                    child: Text("Choose Batsman",
                                                      style: fontMedium.copyWith(
                                                          color: AppColor.textColor,
                                                          fontSize: 10.sp
                                                      ),),
                                                  )
                                              ),
                                            )
                                          ] else ...[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text((scoringData!.data!.batting?.length == 2) ?'${scoringData!.data!.batting![index2].playerName??'-'} ':'-',
                                                        style: fontMedium.copyWith(
                                                            color: Colors.black, fontSize: 10.sp)),
                                                    SizedBox(width:1.w),
                                                    if(scoringData!.data!.batting?.length == 2)...[
                                                      scoringData!.data!.batting![index2].striker == 1
                                                          ? SvgPicture.asset(Images.batIcon,
                                                          color: AppColor.locationIconColor) :  SizedBox(width:1.w),
                                                    ] else ...[
                                                      const SizedBox()
                                                    ]
                                                  ],
                                                ),
                                                if(scoringData!.data!.batting?.length == 2)...[
                                                  RunsScoredAndBallsFacedText(
                                                      scoringData!.data!.batting![index2].runsScored.toString(),
                                                      scoringData!.data!.batting![index2].ballsFaced.toString()),
                                                ] else ...[
                                                  const SizedBox()
                                                ],

                                              ],
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                  const CustomVerticalDottedLine(),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left:4.w),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:EdgeInsets.only(bottom: 1.5.h),
                                            child: Row(children: [
                                              Text('Bowler',
                                                  style: fontMedium.copyWith(
                                                      color: const Color(0xffD78108),
                                                      fontSize: 14.sp)),
                                              const Spacer(),
                                              GestureDetector(onTap:()async{
                                                changeBowler();
                                              },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      shape: BoxShape.rectangle,
                                                      color: Colors.black

                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 0.5.h),
                                                  child: Text('Change',
                                                    style: fontMedium.copyWith(
                                                        color: Colors.white,fontSize: 9.sp),),),
                                              )
                                            ]),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              BowlerCurrentOverData('${selectedBowlerName.isEmpty?scoringData!.data!.bowling!.playerName??'-':selectedBowlerName}  ',
                                                  '${scoringData!.data!.bowling!.overBall??'0'}-'
                                                      '${scoringData!.data!.bowling!.maiden??'0'}-'
                                                      '${scoringData!.data!.bowling!.runsConceded??'0'}-'
                                                      '${scoringData!.data!.bowling!.wickets??'0'}'
                                              ),
                                              SizedBox(height: 1.5.h),
                                              Row(
                                                  children:[
                                                    GestureDetector(onTap:()async{
                                                      setState(() {
                                                        bowlerPosition=0;
                                                      });
                                                      SharedPreferences pref=await SharedPreferences.getInstance();
                                                      await pref.setInt('bowlerPosition', 0);
                                                    },
                                                      child: Row(children:[
                                                        SvgPicture.asset(Images.stumpIcon1,width:3.w,height: 3.h,),
                                                        Padding(padding: EdgeInsets.only(left: 2.w,),
                                                            child:  Text('OW',style: fontRegular.copyWith(fontSize: 10.sp),)),
                                                      ]),
                                                    ),
                                                    SizedBox(width:8.w),
                                                    GestureDetector(
                                                      onTap:()async{
                                                        setState(() {
                                                          bowlerPosition=1;
                                                        });
                                                        SharedPreferences pref=await SharedPreferences.getInstance();
                                                        await pref.setInt('bowlerPosition', 1);
                                                      },
                                                      child: Row(children:[
                                                        Padding(padding: EdgeInsets.only(right: 2.w,),
                                                            child:  Text('RW',style: fontRegular.copyWith(fontSize: 10.sp),)),
                                                        SvgPicture.asset(Images.stumpIcon2,width:3.w,height: 3.h,)
                                                      ]),
                                                    ),
                                                  ]),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            FadeIn(
                              child: Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        AppColor.gradient1,
                                        AppColor.gradient2
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SvgPicture.asset(Images.overCardBg, fit: BoxFit.cover, width: 90.w,),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3.w, vertical: 1.h),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Over ${(scoringData!.data!.over!.isNotEmpty)?scoringData!.data!.over!.first.overNumber:'0'}',
                                            style: fontMedium.copyWith(
                                              color: Colors.black,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          (scoringData!.data!.over!.isNotEmpty)
                                              ? SizedBox(
                                            height: 10.h,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(vertical: 2.h),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: ListView(
                                                      scrollDirection: Axis.horizontal,
                                                      physics: const BouncingScrollPhysics(),
                                                      children: <Widget>[
                                                        for (int index = 0; index < scoringData!.data!.over!.length; index++)
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              (scoringData!.data!.over![index].extras.toString() == "0" && scoringData!.data!.over![index].runsScored==4 || scoringData!.data!.over![index].extras.toString() == "0" && scoringData!.data!.over![index].runsScored==6)?
                                                              (scoringData!.data!.over![index].runsScored==4)
                                                                  ? const Boundary()
                                                                  :const Sixer()
                                                                  : Wicket(
                                                                  scoringData!.data!.over![index].slug.toString() == "OUT",
                                                                  scoringData!.data!.over![index].slug.toString()
                                                              )
                                                            ],
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text(' = ',
                                                        style: fontMedium.copyWith(
                                                          color: AppColor.textColor,
                                                          fontSize: 16.sp,
                                                        ),
                                                      ),
                                                      Text(totalBallId.toString() ?? 'N/A',
                                                        style: fontMedium.copyWith(
                                                          color: AppColor.textColor,
                                                          fontSize: 20.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                              : SizedBox(
                                            height: 10.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(height: 1.h,),
                  Consumer<ScoreUpdateProvider>(
                      builder: (context, change, child) {
                        return change.bowlerChange == 0
                            ? const SizedBox()
                            : InkWell(
                          onTap: (){
                            changeBowler();
                          },
                              child: Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.4.h
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5.w
                              ),
                              decoration: BoxDecoration(
                                  color: AppColor.availableSlot.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Center(
                                child: Text("Change Bowler",
                                  style: fontMedium.copyWith(
                                      color: AppColor.textColor,
                                      fontSize: 12.sp
                                  ),),
                              )
                        ),
                            );
                      }),
                  SizedBox(height: 1.h,),
                  Consumer<ScoreUpdateProvider>(
                    builder: (context, change, child) {
                      return change.bowlerChange == 1
                          ? const SizedBox()
                          : FadeIn(
                        child: Container(
                          width: 100.w,
                          color: Colors.black,
                          child: Consumer<ScoringProvider>(
                            builder: (context, updatedScore, child) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                          children:[
                                            GestureDetector(
                                                onTap:()async {
                                                  final player = Provider.of<PlayerSelectionProvider>(context, listen: false);
                                                  final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
                                                  bool continueOperations = await isBatsman();
                                                  if (!continueOperations) {
                                                    return;
                                                  } else {
                                                    print("striker id ${player.selectedStrikerId}");
                                                    print("non striker id ${player.selectedNonStrikerId}");
                                                    print("passing over number to score update api ${score.overNumberInnings}");
                                                    print("passing ball number to score update api ${score.ballNumberInnings}");
                                                    print("passing overs bowled to score update api ${score.oversBowled}");
                                                    score.trackOvers(score.overNumberInnings, score.ballNumberInnings);

                                                    scoreUpdateRequestModel.ballTypeId=0;
                                                    scoreUpdateRequestModel.matchId=int.parse(widget.matchId);
                                                    scoreUpdateRequestModel.scorerId=46;
                                                    scoreUpdateRequestModel.strikerId=int.parse(player.selectedStrikerId.toString());
                                                    scoreUpdateRequestModel.nonStrikerId=int.parse(player.selectedNonStrikerId.toString());
                                                    scoreUpdateRequestModel.wicketKeeperId=int.parse(player.selectedWicketKeeperId.toString());
                                                    scoreUpdateRequestModel.bowlerId=int.parse(player.selectedBowlerId.toString());
                                                    scoreUpdateRequestModel.overNumber=int.parse(score.overNumberInnings.toString());
                                                    scoreUpdateRequestModel.ballNumber=int.parse(score.ballNumberInnings.toString());
                                                    scoreUpdateRequestModel.runsScored=0;
                                                    scoreUpdateRequestModel.extras=0;
                                                    scoreUpdateRequestModel.extrasSlug=0;
                                                    scoreUpdateRequestModel.wicket=0;
                                                    scoreUpdateRequestModel.dismissalType=0;
                                                    scoreUpdateRequestModel.commentary=0;
                                                    scoreUpdateRequestModel.innings=1;
                                                    scoreUpdateRequestModel.battingTeamId=scoringData!.data!.batting![index1].teamId??0;
                                                    scoreUpdateRequestModel.bowlingTeamId=scoringData!.data!.bowling!.teamId??0;
                                                    scoreUpdateRequestModel.overBowled=score.oversBowled;
                                                    scoreUpdateRequestModel.totalOverBowled=0;
                                                    scoreUpdateRequestModel.outByPlayer=0;
                                                    scoreUpdateRequestModel.outPlayer=0;
                                                    scoreUpdateRequestModel.totalWicket=0;
                                                    scoreUpdateRequestModel.fieldingPositionsId=0;
                                                    scoreUpdateRequestModel.endInnings=false;
                                                    scoreUpdateRequestModel.bowlerPosition=bowlerPosition;
                                                    ScoringProvider().scoreUpdate(scoreUpdateRequestModel)
                                                        .then((value)async {
                                                          if(value.data?.inningCompleted == true){
                                                            Dialogs.snackBar(value.data!.inningsMessage.toString(), context);
                                                            await Future.delayed(const Duration(seconds: 2));
                                                            if(mounted){
                                                              Navigator.pop(context);
                                                              Navigator.pop(context);
                                                            }
                                                          } else {
                                                            setState(() {
                                                              scoreUpdateResponseModel=value;
                                                            });
                                                            print("striker and non striker id - ${value.data?.strikerId.toString()} ${value.data?.nonStrikerId.toString()}");

                                                            print("after score update - 0");
                                                            print(value.data?.overNumber);
                                                            print(value.data?.ballNumber);
                                                            print(value.data?.bowlerChange);
                                                            print("score update print end - 0");

                                                            print("0 - setting over number ${value.data?.overNumber} and ball number ${value.data?.ballNumber} and bowler change ${value.data?.bowlerChange} to provider after score update");
                                                            score.setOverNumber(value.data?.overNumber??0);
                                                            score.setBallNumber(value.data?.ballNumber??0);
                                                            score.setBowlerChangeValue(value.data?.bowlerChange??0);
                                                            player.setStrikerId(value.data!.strikerId.toString(), "");
                                                            player.setNonStrikerId(value.data!.nonStrikerId.toString(), "");
                                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                                            await prefs.setInt('bowlerPosition', 0);
                                                            await prefs.setInt('ball_number_check', value.data?.ballNumber ?? 0);
                                                            if(value.data?.strikerId==0 || value.data?.nonStrikerId==0){
                                                              String player = (value.data?.strikerId==0) ? 'striker_id':'non_striker_id';
                                                              changeBatsman(player);
                                                            }
                                                            _refreshData();
                                                          }

                                                    });
                                                  }

                                                },
                                                child: const ScorerGridItem('0','DOT')),

                                            const CustomHorizantalDottedLine(),]),
                                      const CustomVerticalDottedLine(),
                                      Column(
                                          children:[
                                            GestureDetector(onTap:()async {
                                              bool continueOperations = await isBatsman();
                                              if (!continueOperations) {
                                                return;
                                              }
                                              _displayScoreUpdateBottomSheet(1,scoringData);
                                            }, child: const ScorerGridItem('1','')),

                                            const CustomHorizantalDottedLine(),]),
                                      const CustomVerticalDottedLine(),
                                      Column(
                                          children:[
                                            GestureDetector(onTap:()async{
                                              bool continueOperations =  await isBatsman();
                                              if (!continueOperations) {
                                                return;
                                              }
                                              _displayScoreUpdateBottomSheet(2,scoringData);
                                            }, child:const ScorerGridItem('2','')),
                                            const CustomHorizantalDottedLine(),]),
                                      const CustomVerticalDottedLine(),
                                      Column(
                                          children:[
                                            GestureDetector(onTap:()async{
                                              bool continueOperations = await isBatsman();
                                              if (!continueOperations) {
                                                return;
                                              }
                                              _displayScoreUpdateBottomSheet(3,scoringData);
                                            }, child:const ScorerGridItem('3','')),
                                            const CustomHorizantalDottedLine(),]),
                                      const CustomVerticalDottedLine(),
                                      Column(
                                          children:[
                                            GestureDetector(onTap:()async{
                                              bool continueOperations = await isBatsman();
                                              if (!continueOperations) {
                                                return;
                                              }
                                              _displayScoreUpdateBottomSheet(4,scoringData);
                                            }, child:const ScorerGridFour(Images.four,'FOUR')),
                                            const CustomHorizantalDottedLine(),]),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                          children:[  GestureDetector(onTap:()async{
                                            bool continueOperations = await isBatsman();
                                            if (!continueOperations) {
                                              return;
                                            }
                                            _displayScoreUpdateBottomSheet(6,scoringData);
                                          }, child:const ScorerGridFour(Images.six,'SIX')),
                                            const CustomHorizantalDottedLine(),]),
                                      const CustomVerticalDottedLine(),
                                      Column(
                                          children:[ GestureDetector(
                                              onTap: ()async{
                                                bool continueOperations = await isBatsman();
                                                if (!continueOperations) {
                                                  return;
                                                }
                                                _displayBottomSheetWide(7,scoringData);
                                              },
                                              child: const ScorerGridItem('WD','WIDE')),
                                            const CustomHorizantalDottedLine(),]),
                                      const CustomVerticalDottedLine(),
                                      Column(
                                          children:[ GestureDetector(
                                              onTap: ()async{
                                                bool continueOperations = await isBatsman();
                                                if (!continueOperations) {
                                                  return;
                                                }
                                                _displayBottomSheetNoBall(8,scoringData);
                                              },
                                              child: const ScorerGridItem('NB','NO BALL')),
                                            const CustomHorizantalDottedLine(),]),
                                      const CustomVerticalDottedLine(),
                                      Column(
                                          children:[ GestureDetector(
                                              onTap:()async{
                                                bool continueOperations = await isBatsman();
                                                if (!continueOperations) {
                                                  return;
                                                }
                                                _displayBottomSheetLegBye(9,scoringData);
                                              },
                                              child: const ScorerGridItem('LB','LEG-BYE')),
                                            const CustomHorizantalDottedLine(),]),
                                      const CustomVerticalDottedLine(),
                                      Column(
                                          children:[ GestureDetector(
                                              onTap: ()async{
                                                bool continueOperations = await isBatsman();
                                                if (!continueOperations) {
                                                  return;
                                                }
                                                _displayBottomSheetByes(10,scoringData);
                                              },
                                              child: const ScorerGridItem('BYE','BYE')),
                                            const CustomHorizantalDottedLine(),]),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(onTap:()async{
                                        bool continueOperations = await isBatsman();
                                        if (!continueOperations) {
                                          return;
                                        }
                                        _displayBottomSheetBonus(11,scoringData);
                                      },
                                          child: const ScorerGridItem('B/P','B/P')),
                                      const CustomVerticalDottedLine(),
                                      GestureDetector(onTap: ()async{
                                        bool continueOperations =  await isBatsman();
                                        if (!continueOperations) {
                                          return;
                                        }
                                        _displayBottomSheetMoreRuns(5,scoringData);
                                      },
                                          child: const ScorerGridItem('5,7..','RUNS')),
                                      const CustomVerticalDottedLine(),
                                      GestureDetector(
                                          onTap: ()async {
                                            bool continueOperations =  await isBatsman();
                                            if (!continueOperations) {
                                              return;
                                            }
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return const UndoScreen();
                                              },
                                            );
                                          },
                                          child: const ScorerGridItem('','UNDO')),
                                      const CustomVerticalDottedLine(),
                                      GestureDetector(
                                          onTap: ()async{
                                            bool continueOperations = await isBatsman();
                                            if (!continueOperations) {
                                              return;
                                            }
                                            _displayBottomSheetOther();},
                                          child: const ScorerGridItem('','OTHER')),
                                      const CustomVerticalDottedLine(),
                                      GestureDetector(
                                          onTap: ()async{
                                            bool continueOperations = await isBatsman();
                                            if (!continueOperations) {
                                              return;
                                            }
                                            _displayBottomOut(scoringData);
                                          },
                                          child: const ScorerGridOut('OUT','')),
                                    ],
                                  ),
                                ],
                              );
                            }
                          ),
                        ),
                      );
                    }
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  isBatsman()async{
    var players = Provider.of<PlayerSelectionProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(players.selectedStrikerId=="" || players.selectedNonStrikerId=="" ) {
      String player=(players.selectedStrikerId=="")?'striker_id':'non_striker_id';
      changeBatsman(player);
      return false;
    }
    return true;
  }

  void changeBatsman(String player) async{
    _displaySelectBatsmanBottomSheet (context,selectedBatsman,(bowlerIndex) {
      setState(() {
        selectedBatsman = bowlerIndex;
        if (selectedBatsman != null) {
          selectedBatsmanName = itemsBatsman![selectedBatsman!].playerName ?? "";
        }
      });
    },player);
  }

  void changeBowler() {
    _displayBowlerBottomSheet (context,selectedBowler,(bowlerIndex) {
      setState(() {
        selectedBowler = bowlerIndex;
        if (selectedBowler != null) {
          selectedBowlerName = itemsBowler![selectedBowler!].playerName ?? "";
        }
      });
    });

  }

  Future<ScoreUpdateResponseModel?> _displayScoreUpdateBottomSheet(int run, ScoringDetailResponseModel? scoringData) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(height: 90.h,
          child: ScoreBottomSheet(run,scoringData!,onSave: (value){
            if(mounted){
              setState(() {
                scoreUpdateResponseModel=value;
              });
            }
          }, _refreshData),
        );
      },
    ).then((value) {
      _refreshData();
    });
  }

  _displayBowlerBottomSheet (BuildContext context, int? selectedBowler,Function(int?) onItemSelected) async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> StatefulBuilder(
          builder: (context, setState) {
            return BowlerListBottomSheet(widget.matchId, widget.team2Id, _refreshData);
            },
        )
    ).then((value) {
      final players = Provider.of<PlayerSelectionProvider>(context, listen: false);
      final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
      print(players.selectedBowlerId);
      print(score.bowlerChange);
    });
  }

  Future<void> _displaySelectBatsmanBottomSheet (BuildContext context, int? selectedBatsman,Function(int?) onItemSelected,String player) async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> StatefulBuilder(
          builder: (context, setState) {
            return BatsmanListBottomSheet(widget.matchId, widget.team1Id, player, _refreshData);
          },
        )
    );
  }

//Out
  Future<void> _displayBottomOut (ScoringDetailResponseModel? scoringData) async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> StatefulBuilder(builder: (context, setState){
          return WicketOptionsBottomSheet(scoringData, _refreshData);
        })
    ).then((value)async {
      final player = Provider.of<PlayerSelectionProvider>(context, listen: false);
      var strikerId=player.selectedStrikerId;
      var nonStrikerId=player.selectedNonStrikerId;
      if(strikerId == "" || nonStrikerId == "" ) {
        String player=(strikerId == "" || strikerId == "null")?'striker_id':'non_striker_id';
        changeBatsman(player);
      }
    });


  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  Future<void> _displayBottomSheetOther () async{
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
      // {
      //   'label': 'Change target',
      // },
      // {
      //   'label': 'Change Batsman',
      // },

    ];
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        builder: (context)=> StatefulBuilder(builder: (context, setState){
          return Container(
            height: 40.h,
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
                    spacing: 2.w,
                    runSpacing: 1.h,
                    alignment: WrapAlignment.center,
                    children:chipData.map((data) {
                      final index = chipData.indexOf(data);
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            isWideSelected=index;
                          });
                          if (data['label'] == 'End Innings'){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return EndInnings(widget.matchId,);
                              },
                            ).whenComplete(() {
                              Navigator.pop(context);
                            });
                          }
                          if (data['label'] == 'Match break'){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DialogsOthers(widget.matchId,widget.team1Id,widget.team2Id);
                              },
                            ).whenComplete(() {
                              Navigator.pop(context);
                            });
                          }
                          if (data['label'] == 'Change keeper'){

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ChangeKeeper(widget.matchId,widget.team2Id);
                              },
                            );
                          }
                          // if (data['label'] == 'Change target'){
                          //   showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return ChangeTargetDialog();
                          //     },
                          //   );
                          // }
                          if (data['label'] == 'D/L Method'){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DlMethodDialog(widget.matchId);
                              },
                            );
                          }
                          if (data['label'] == 'Settings'){
                            _displayBottomSheetSettings(context);
                          }
                          if (data['label'] == 'Change Batsman'){
                            // String player=(value.data!.strikerId==0)?'striker_id':'non_striker_id';
                            // changeBatsman(player);
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
                          backgroundColor: isWideSelected==index? AppColor.primaryColor : const Color(0xffF8F9FA),
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

  Future<void> _displayBottomSheetWide (int ballType, ScoringDetailResponseModel? scoringData) async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> StatefulBuilder(builder: (context, setState){
          return WideBottomSheet(ballType, scoringData, _refreshData);
        })
    );
  }

  Future<void> _displayBottomSheetNoBall (int ballType,ScoringDetailResponseModel? scoringData) async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> StatefulBuilder(builder: (context, setState){
          return NoBallBottomSheet(ballType, scoringData, _refreshData);
        })
    );
  }

  Future<void> _displayBottomSheetLegBye (int ballType,ScoringDetailResponseModel? scoringData) async{

    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> StatefulBuilder(builder: (context, setState){
          return LegByeBottomSheet(ballType, scoringData, _refreshData, widget.matchId, widget.team1Id);
        })
    );
  }

  Future<void> _displayBottomSheetByes (int ballType,ScoringDetailResponseModel? scoringData) async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> StatefulBuilder(builder: (context, setState){
          return ByesBottomSheet(ballType, scoringData, _refreshData, widget.matchId, widget.team1Id);
        })
    );
  }

  Future<void> _displayBottomSheetBonus (int? ballType, ScoringDetailResponseModel? scoringData,) async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        builder: (context)=> StatefulBuilder(builder: (context, setState){
          return BonusBottomSheet(ballType, scoringData, _refreshData);
        })
    ).then((value) {
      _refreshData();
    });
  }

  Future<void> _displayBottomSheetMoreRuns(int ballType,ScoringDetailResponseModel? scoringData) async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        builder: (context)=> StatefulBuilder(builder: (context, setState){
          return MoreRunsBottomSheet(ballType, scoringData);
        })
    ).then((value) {
      _refreshData();
    });
  }


  Future<void> _displayBottomSheetSettings (BuildContext context) async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        builder: (context)=> StatefulBuilder(builder: (context, setState){
          return const SettingsBottomSheet();
        })
    );

  }

}


