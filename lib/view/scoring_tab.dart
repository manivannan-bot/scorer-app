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
import 'package:scorer/view/deliveries/byes_bottom_sheet.dart';
import 'package:scorer/view/deliveries/no_ball_bottom_sheet.dart';
import 'package:scorer/view/deliveries/wide_bottom_sheet.dart';
import 'package:scorer/view/more_runs_bottom_sheet.dart';
import 'package:scorer/view/score_update_bottom_sheet.dart';
import 'package:scorer/view/settings_bottom_sheet.dart';
import 'package:scorer/view/widgets/scorer_grid_four.dart';
import 'package:scorer/view/widgets/scorer_grid_item.dart';
import 'package:scorer/view/widgets/scorer_grid_out.dart';

import 'package:scorer/widgets/custom_vertical_dottedLine.dart';
import 'package:scorer/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';


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
    if(scoringData!.data!.batting!.isEmpty || scoringData!.data!.bowling==null){
      return scoringData!.data!.batting!.isEmpty? const SizedBox(
          height: 100,
          width: 100,
          child: Center(child: Text('Please Select Batsman'))): const SizedBox(
          height: 100,
          width: 100,
          child: Center(child: Text('Please Select Bowler')));
    }
    if(scoringData!.data!.batting!.length<2){
      var player=scoringData!.data!.batting!.first.striker==1?'non_striker_id':'striker_id';
      // changeBatsman(player);
      return const SizedBox(height: 100, width: 100,
          child: Center(child: Text('Please Select Batsman')));
    }
    int totalBallId = 0;
    showError=false;
    for (int index = 0; index < scoringData!.data!.over!.length; index++) {
      totalBallId += int.parse(scoringData!.data!.over![index].runsScored==null?'0':scoringData!.data!.over![index].runsScored.toString()); // Sum the ballIds
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
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      shape: BoxShape.rectangle,
                                                      color: Colors.black

                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 0.5.h),
                                                  child: Text('Swap',
                                                    style: fontMedium.copyWith(
                                                        color: Colors.white,
                                                        fontSize: 9.sp),),),
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
                                          RichText(
                                            text: TextSpan(
                                                text: scoringData!.data!.batting![index1].runsScored.toString()??'0',
                                                style: fontMedium.copyWith(
                                                    color: AppColor.textColor, fontSize: 10.sp),
                                                children: <TextSpan>[
                                                  TextSpan(text: ' (${scoringData!.data!.batting![index1].ballsFaced.toString()??'0'})',
                                                      style: fontRegular.copyWith(
                                                          color: AppColor.textColor, fontSize: 10.sp),
                                                  )
                                                ]
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text((scoringData!.data!.batting?[index2]!=null)?'${scoringData!.data!.batting![index2].playerName??'-'} ':'-',
                                                  style: fontMedium.copyWith(
                                                      color: Colors.black, fontSize: 10.sp)),
                                              SizedBox(width:1.w),
                                              scoringData!.data!.batting![index2].striker == 1
                                                  ? SvgPicture.asset(Images.batIcon,
                                                  color: AppColor.locationIconColor) :  SizedBox(width:1.w),
                                            ],
                                          ),
                                          RichText(
                                            text: TextSpan(
                                                text: scoringData!.data!.batting![index2].runsScored.toString()??'0',
                                                style: fontMedium.copyWith(
                                                    color: AppColor.textColor, fontSize: 10.sp),
                                                children: <TextSpan>[
                                                  TextSpan(text: ' (${scoringData!.data!.batting![index2].ballsFaced.toString()??'0'})',
                                                    style: fontRegular.copyWith(
                                                        color: AppColor.textColor, fontSize: 10.sp),
                                                  )
                                                ]
                                            ),
                                          ),
                                        ],
                                      ),
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
                                          Row(
                                            children: [
                                              Text('${selectedBowlerName.isEmpty?scoringData!.data!.bowling!.playerName??'-':selectedBowlerName}  ',
                                                  style: fontMedium.copyWith(
                                                      color: AppColor.textColor, fontSize: 10.sp)),
                                              SizedBox(width: 2.w),
                                              Text('${scoringData!.data!.bowling!.overBall??'0'}-'
                                                  '${scoringData!.data!.bowling!.maiden??'0'}-'
                                                  '${scoringData!.data!.bowling!.runsConceded??'0'}-'
                                                  '${scoringData!.data!.bowling!.wickets??'0'}',
                                                  style: fontRegular.copyWith(
                                                      color: AppColor.textColor, fontSize: 10.sp)),
                                            ],
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
                                                              ? Container(
                                                            width: 40,
                                                            height: 40,
                                                            margin: const EdgeInsets.symmetric(horizontal: 5),
                                                            decoration: const BoxDecoration(
                                                              color: Colors.black,
                                                              shape: BoxShape.circle,
                                                            ),
                                                            child:  CircleAvatar(
                                                                radius: 4.w, // Adjust the radius as needed for the circle size
                                                                backgroundColor: Colors.white,
                                                                child: Image.asset(Images.four)
                                                            ),
                                                          ):Container(
                                                            width: 40,
                                                            height: 40,
                                                            margin: const EdgeInsets.symmetric(horizontal: 5),
                                                            decoration: const BoxDecoration(
                                                              color: Colors.black,
                                                              shape: BoxShape.circle,
                                                            ),
                                                            child:  CircleAvatar(
                                                                radius: 4.w, // Adjust the radius as needed for the circle size
                                                                backgroundColor: Colors.white,
                                                                child: Image.asset(Images.six)
                                                            ),
                                                          ):
                                                          Container(
                                                            width: 40,
                                                            height: 40,
                                                            margin: const EdgeInsets.symmetric(horizontal: 5),
                                                            decoration: const BoxDecoration(
                                                              color: Colors.black,
                                                              shape: BoxShape.circle,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                scoringData!.data!.over![index].slug.toString(),
                                                                style:  fontRegular.copyWith(
                                                                  color: Colors.white,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
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

  isBatsman()async{
    var players = Provider.of<PlayerSelectionProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var strikerId=prefs.getInt('striker_id')??0;
    var nonStrikerId=prefs.getInt('non_striker_id')??0;
    // var isBowlerChange=prefs.getInt('bowler_change')??0;
    if(players.selectedStrikerId=="" || players.selectedNonStrikerId=="" ) {
      String player=(players.selectedStrikerId=="")?'striker_id':'non_striker_id';
      changeBatsman(player);
      return false;
    }
    // if(score.bowlerChange==1){
    //   changeBowler();
    //   return false;
    // }
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
    ScoringProvider().getPlayerList(widget.matchId,widget.team2Id,'bowl').then((value) {
      setState(() {
        itemsBowler=[];
        searchedList=value.bowlingPlayers!;
        itemsBowler = value.bowlingPlayers;
        selectedBTeamName= value.team!.teamName;
      });
      _displayBowlerBottomSheet (context,selectedBowler,(bowlerIndex) {
        setState(() {
          selectedBowler = bowlerIndex;
          if (selectedBowler != null) {
            selectedBowlerName = itemsBowler![selectedBowler!].playerName ?? "";
          }
        });
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

    int? localBowlerIndex ;
    isResultEmpty=true;
    String playerId = "";
    int? oversBowled;
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: 90.h,
              padding: EdgeInsets.symmetric(vertical: 2.h),
              decoration: const BoxDecoration(
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
                        Text("Select Bowler",style: fontMedium.copyWith(
                          fontSize: 18.sp,
                          color: AppColor.blackColour,
                        ),),
                        SizedBox(width: 7.w,),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  const Divider(
                    thickness: 1,
                    color: Color(0xffD3D3D3),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.h),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xffF8F9FA),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.2.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: searchController,
                                cursorColor: AppColor.secondaryColor,
                                onChanged: (value) {
                                  onSearchCategory(value);
                                  setState(() {
                                    if (value.isEmpty) {
                                      searching = false;
                                    }
                                    else{
                                      searching = true;
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: "Search for bowlers",
                                  hintStyle: fontRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.textMildColor
                                  ),),
                              ),
                            ),
                            searching
                                ? InkWell(
                                onTap: (){
                                  setState(() {
                                    searchController.clear();
                                    searching = false;
                                  });
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  onSearchCategory(" ");
                                },
                                child: Icon(Icons.close, color: AppColor.iconColour, size: 5.w,))
                                : SvgPicture.asset(Images.searchIcon, color: AppColor.iconColour, width: 3.5.w,),
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
                  // Divider(
                  //   color: Color(0xffD3D3D3),
                  // ),
                  const Divider(
                    thickness: 0.5,
                    color: Color(0xffD3D3D3),
                  ),
                  if(isResultEmpty && searching)...[
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Text(
                        "No players found",
                        style: fontBold.copyWith(
                            color: AppColor.redColor, fontSize: 14.sp),
                      ),
                    )
                  ]
                  else if(!isResultEmpty&&searching)...[
                    Expanded(
                      child:   ListView.separated(
                        separatorBuilder:(context ,_) {
                          return const Divider(
                            thickness: 0.6,
                          );
                        },
                        itemCount: searchedList.length,
                        itemBuilder: (context, index) {
                          final isActive=searchedList[index].active??0;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                playerId = searchedList[index].playerId.toString();
                                oversBowled = searchedList[index].oversBowled;
                                if (localBowlerIndex  == index) {
                                  localBowlerIndex  = null; // Deselect the item if it's already selected
                                } else {
                                  localBowlerIndex  = index; // Select the item if it's not selected
                                }
                                onItemSelected(localBowlerIndex);
                              });
                            },
                            child:Opacity(opacity: isActive==1?0.5:1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.5.w,vertical: 1.h),
                                child: Row(
                                  children: [
                                    //circular button
                                    Container(
                                      height: 20.0, // Adjust the height as needed
                                      width: 20.0,  // Adjust the width as needed
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: localBowlerIndex  == index ? Colors.blue : Colors.grey, // Change colors based on selected index
                                      ),
                                      child: const Center(
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
                                        Text("${searchedList![index].playerName??'-'}",style: fontMedium.copyWith(
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
                                            Text(searchedList![index].bowlingStyle??'-',style: fontMedium.copyWith(
                                                fontSize: 11.sp,
                                                color: const Color(0xff555555)
                                            ),),
                                          ],
                                        ),

                                      ],
                                    ),
                                    const Spacer(),

                                  ],
                                ),
                              ),
                            ),

                          );
                        },
                      ),
                    ),
                  ]
                  else...[
                      Expanded(
                        child:   ListView.separated(
                          separatorBuilder:(context ,_) {
                            return const Divider(
                              thickness: 0.6,
                            );
                          },
                          itemCount: searchedList.length,
                          itemBuilder: (context, index) {
                            final isActive=searchedList[index].active??0;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  playerId = searchedList[index].playerId.toString();
                                  oversBowled = searchedList[index].oversBowled;
                                  if (localBowlerIndex  == index) {
                                    localBowlerIndex  = null; // Deselect the item if it's already selected
                                  } else {
                                    localBowlerIndex  = index; // Select the item if it's not selected
                                  }
                                  onItemSelected(localBowlerIndex);
                                });
                              },
                              child:Opacity(opacity: isActive==1?0.5:1,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2.5.w,vertical: 1.h),
                                  child: Row(
                                    children: [
                                      //circular button
                                      Container(
                                        height: 20.0, // Adjust the height as needed
                                        width: 20.0,  // Adjust the width as needed
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: localBowlerIndex  == index ? Colors.blue : Colors.grey, // Change colors based on selected index
                                        ),
                                        child: const Center(
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
                                          Text(searchedList[index].playerName??'-',style: fontMedium.copyWith(
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
                                              Text(searchedList[index].bowlingStyle??'-',style: fontMedium.copyWith(
                                                  fontSize: 11.sp,
                                                  color: const Color(0xff555555)
                                              ),),
                                            ],
                                          ),

                                        ],
                                      ),
                                      const Spacer(),

                                    ],
                                  ),
                                ),
                              ),

                            );
                          },
                        ),
                      ),
                    ],
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

                          if(localBowlerIndex!=null){
                            final players = Provider.of<PlayerSelectionProvider>(context, listen: false);
                            final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
                            players.setBowlerId(playerId, "");
                            score.setBowlerChangeValue(0);
                            print("setting overs bowled value for the bowler $oversBowled");
                            score.setOversBowledValue(oversBowled ?? 0);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setInt('bowler_id', searchedList[localBowlerIndex!].playerId!);
                            await prefs.setInt('bowler_change', 0);
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.pop(context);
                            });
                          }else{
                           Dialogs.snackBar("Select a bowler", context, isError: true);
                          }
                        },child: const OkBtn("Ok")),
                      ],
                    ),
                  ),

                ],
              ),
            );},
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
            return BatsmanListBottomSheet(widget.matchId, widget.team1Id, player);
          },
        )
    );
  }

//Out
  Future<void> _displayBottomOut (ScoringDetailResponseModel? scoringData) async{
    int? isOffSideSelected ;
    int? isWideSelected ;
    List<Map<String, dynamic>> chipData =[
      { 'id':15,
        'label': "Bowled",
      },
      { 'id':32,
        'label': 'Caught',
      },
      { 'id':16,
        'label': 'Stumped',
      },
      { 'id':17,
        'label': 'LBW',
      },
      {  'id':18,
        'label': 'Caught Behind',
      },
      { 'id':19,
        'label': 'Caught & Bowled',
      },
      { 'id':20,
        'label': ' Run Out',
      },
      {  'id':21,
        'label': 'Run out (Mankaded)',
      },
      { 'id':22,
        'label': 'Retired Hurt',
      },
      { 'id':23,
        'label': 'Hit Wicket',
      },
      { 'id':24,
        'label': 'Retired',
      },
      { 'id':25,
        'label': 'Retired Out',
      },
      { 'id':26,
        'label': 'Handling the Ball',
      },
      { 'id':27,
        'label': 'Hit the Ball Twice',
      },
      { 'id':28,
        'label': 'Obstruct the field',
      },
      { 'id':29,
        'label': 'Timed Out',
      },
      { 'id':30,
        'label': 'Absence Hurt',
      },

    ];

    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> StatefulBuilder(builder: (context, setState){
          return Container(
            height: 60.h,
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
                  padding:  EdgeInsets.only(left: 2.w,right: .2.w),
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
                          if (data['label'] == 'Bowled'){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return OutMethodDialog(label: 'Bowled', id: data['id'], scoringData: scoringData!);
                              },
                            );
                          }
                          if (data['label'] == 'LBW'){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return OutMethodDialog(label: 'LBW',id: data['id'],scoringData: scoringData!);
                              },
                            );
                          }
                          if (data['label'] == 'Caught Behind'){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return OutMethodDialog(label: 'Caught Behind',id: data['id'],scoringData: scoringData!);
                              },
                            );
                          }
                          if (data['label'] == 'Caught & Bowled'){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return OutMethodDialog(label: 'Caught & Bowled',id: data['id'],scoringData: scoringData!);
                              },
                            );
                          }
                          if (data['label'] == 'Run out (Mankaded)'){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return OutMethodDialog(label: 'Mankaded',id: data['id'],scoringData: scoringData!);
                              },
                            );
                          }
                          if (data['label'] == 'Hit Wicket'){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return OutMethodDialog(label: 'Hit Wicket',id: data['id'],scoringData: scoringData!);
                              },
                            );
                          }
                          if (data['label'] == 'Handling the Ball'){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return OutMethodDialog(label: 'Handling the Ball',id: data['id'],scoringData: scoringData!);
                              },
                            );
                          }
                          if (data['label'] == 'Hit the Ball Twice'){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return OutMethodDialog(label: 'Hit the Ball Twice',id: data['id'],scoringData: scoringData!);
                              },
                            );
                          }
                          if (data['label'] == ' Run Out'){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RunOutScreen(ballType:data['id'],scoringData: scoringData!)));
                          }
                          if (data['label'] == 'Caught'){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CaughtOutScreen(ballType:data['id'],scoringData: scoringData!)));
                          }
                          if (data['label'] == 'Retired Hurt'){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RetiredHurtScreen(label: 'Retired Hurt', checkcount: "Don't count the ball",ballType:data['id'],scoringData: scoringData!,)));
                          }
                          if (data['label'] == 'Retired Out'){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RetiredHurtScreen(label: 'Retired Out', checkcount: "Don't count the ball",ballType:data['id'],scoringData: scoringData!,)));
                          }
                          if (data['label'] == 'Timed Out'){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TimeOutAbsence(label: 'Timed out',ballType:data['id'],scoringData: scoringData!, )));
                          }
                          if (data['label'] == 'Absence Hurt'){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TimeOutAbsence(label: 'Absence hurt',ballType:data['id'],scoringData: scoringData!,)));
                          }
                          if (data['label'] == 'Stumped'){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RetiredHurtScreen(label: 'Stumped', checkcount: "Wide Ball?",ballType:data['id'],scoringData: scoringData!,)));
                          }
                          if (data['label'] == 'Retired'){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RetiredScreens(ballType:data['id'],scoringData: scoringData!,)));
                          }
                          if (data['label'] == 'Obstruct the field' ){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ObstructTheField(ballType:data['id'],scoringData: scoringData!,)));
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
    ).then((value)async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var strikerId=prefs.getInt('striker_id')??0;
      var nonStrikerId=prefs.getInt('non_striker_id')??0;
      if(strikerId==0 || nonStrikerId==0 ) {
        String player=(strikerId==0)?'striker_id':'non_striker_id';
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


