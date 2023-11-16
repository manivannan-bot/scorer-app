import 'dart:async';
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
import 'package:scorer/view/widgets/bowler_current_over_data.dart';
import 'package:scorer/view/widgets/change_bowler_button.dart';
import 'package:scorer/view/widgets/choose_batsman_button.dart';
import 'package:scorer/view/widgets/current_over_data.dart';
import 'package:scorer/view/widgets/runs_scored_and_balls_faced_text.dart';
import 'package:scorer/view/widgets/scorer_grid_four.dart';
import 'package:scorer/view/widgets/scorer_grid_item.dart';
import 'package:scorer/view/widgets/scorer_grid_out.dart';
import 'package:scorer/view/widgets/set_bowler_position.dart';
import 'package:scorer/widgets/custom_vertical_dottedLine.dart';
import 'package:scorer/widgets/snackbar.dart';
import 'package:sizer/sizer.dart';
import '../Scoring screens/home_screen.dart';
import '../Scoring screens/wicket_options_bottom_sheet.dart';
import '../models/player_list_model.dart';
import '../models/score_update_request_model.dart';
import '../models/score_update_response_model.dart';
import '../out_screens/undo_screen.dart';
import '../provider/player_selection_provider.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import '../widgets/custom_horizondal_dottedLine.dart';
import 'deliveries/leg_bye_bottom_sheet.dart';
import 'other_bottom_sheet.dart';

class ScoringTab extends StatefulWidget {
  final String matchId;
  final String team1Id;
  final String team2Id;
  final String currentOverData;
  final VoidCallback fetchData;
  const ScoringTab(this.matchId, this.team1Id, this.team2Id, this.fetchData, this.currentOverData, {super.key});

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
  int ow=1;
  int rw = -1;

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
  RefreshController refreshController = RefreshController();
  String eventData = 'No event received yet';

  @override
  void initState() {
    scoringData=null;
    super.initState();
    _refreshData();
    //setUpServices();
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
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
      debugPrint(eventData);

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
        if(value.data!.over!.isNotEmpty){
          player.setWicketKeeperId(value.data!.over!.last.wicketKeeperId.toString(), "");
        }
      } else {
        player.setNonStrikerId(value.data!.batting!.first.playerId.toString(), value.data!.batting!.first.playerName.toString());
        player.setBowlerId(value.data!.bowling!.playerId.toString(), value.data!.bowling!.playerName.toString());
        if(value.data!.over!.isNotEmpty){
          player.setWicketKeeperId(value.data!.over!.last.wicketKeeperId.toString(), "");
        }
      }

      if(value.data?.batting?.last.striker == 1){
        player.setStrikerId(value.data!.batting!.last.playerId.toString(), value.data!.batting!.last.playerName.toString());
        player.setBowlerId(value.data!.bowling!.playerId.toString(), value.data!.bowling!.playerName.toString());
        if(value.data!.over!.isNotEmpty){
          player.setWicketKeeperId(value.data!.over!.last.wicketKeeperId.toString(), "");
        }
      } else {
        player.setNonStrikerId(value.data!.batting!.last.playerId.toString(), value.data!.batting!.last.playerName.toString());
        player.setBowlerId(value.data!.bowling!.playerId.toString(), value.data!.bowling!.playerName.toString());
        if(value.data!.over!.isNotEmpty){
          player.setWicketKeeperId(value.data!.over!.last.wicketKeeperId.toString(), "");
        }
      }
      refreshController.refreshCompleted();
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

    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      onRefresh: _refreshData,
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: SingleChildScrollView(
          child: Consumer<ScoreUpdateProvider>(
              builder: (context, change, child) {
                return Column(
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
                                                    // const Spacer(),
                                                    // GestureDetector(
                                                    //   onTap:()async{
                                                    //     SharedPreferences prefs = await SharedPreferences.getInstance();
                                                    //     var strikerId=prefs.getInt('striker_id')??0;
                                                    //     var nonStrikerId=prefs.getInt('non_striker_id')??0;
                                                    //     await prefs.setInt('non_striker_id',strikerId);
                                                    //     await prefs.setInt('striker_id',nonStrikerId);
                                                    //     setState(() {
                                                    //       if(index1==1){
                                                    //         index2=1;
                                                    //         index1=0;
                                                    //       }else{
                                                    //         index2=0;
                                                    //         index1=1;
                                                    //       }
                                                    //     });
                                                    //   },
                                                    //   child: SwapButton(),
                                                    // ),
                                                  ]),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(scoringData!.data!.batting![index1].playerName.split(' ').first.toString(),
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
                                                child: const ChooseBatsmanButton(),
                                              )
                                            ] else ...[
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text((scoringData!.data!.batting?.length == 2) ?'${scoringData!.data!.batting![index2].playerName.split(' ').first.toString()} ':'-',
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
                                                const SetBowlerPosition(),
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
                              CurrentOverData(scoringData, widget.currentOverData, totalBallId.toString()),
                            ],
                          )),
                    ),
                    SizedBox(height: 1.h,),
                    change.bowlerChange == 0
                        ? const SizedBox()
                        : InkWell(
                      onTap: (){
                        changeBowler();
                      },
                      child: const ChangeBowlerButton(),
                    ),
                    SizedBox(height: 1.h,),
                    change.bowlerChange == 1 || scoringData!.data!.batting!.length < 2
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
                                                    debugPrint("striker id ${player.selectedStrikerId}");
                                                    debugPrint("non striker id ${player.selectedNonStrikerId}");
                                                    debugPrint("passing over number to score update api ${score.overNumberInnings}");
                                                    debugPrint("passing ball number to score update api ${score.ballNumberInnings}");
                                                    debugPrint("passing overs bowled to score update api ${score.oversBowled}");
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
                                                    scoreUpdateRequestModel.innings=score.innings;
                                                    scoreUpdateRequestModel.battingTeamId=scoringData!.data!.batting![index1].teamId??0;
                                                    scoreUpdateRequestModel.bowlingTeamId=scoringData!.data!.bowling!.teamId??0;
                                                    scoreUpdateRequestModel.overBowled=score.oversBowled;
                                                    scoreUpdateRequestModel.totalOverBowled=0;
                                                    scoreUpdateRequestModel.outByPlayer=0;
                                                    scoreUpdateRequestModel.outPlayer=0;
                                                    scoreUpdateRequestModel.totalWicket=0;
                                                    scoreUpdateRequestModel.fieldingPositionsId=0;
                                                    scoreUpdateRequestModel.endInnings=false;
                                                    scoreUpdateRequestModel.bowlerPosition=score.bowlerPosition;
                                                    ScoringProvider().scoreUpdate(scoreUpdateRequestModel)
                                                        .then((value)async {
                                                      if(value.data?.innings == 3){
                                                        Dialogs.snackBar("Match Ended", context);
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => const HomeScreen()));
                                                      } else if(value.data?.inningCompleted == true){
                                                        Dialogs.snackBar(value.data!.inningsMessage.toString(), context);
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => const HomeScreen()));
                                                      } else {
                                                        setState(() {
                                                          scoreUpdateResponseModel=value;
                                                        });
                                                        debugPrint("striker and non striker id - ${value.data?.strikerId.toString()} ${value.data?.nonStrikerId.toString()}");

                                                        debugPrint("after score update - 0");
                                                        debugPrint(value.data?.overNumber.toString());
                                                        debugPrint(value.data?.ballNumber.toString());
                                                        debugPrint(value.data?.bowlerChange.toString());
                                                        debugPrint("score update print end - 0");

                                                        debugPrint("0 - setting over number ${value.data?.overNumber} and ball number ${value.data?.ballNumber} and bowler change ${value.data?.bowlerChange} to provider after score update");
                                                        score.setOverNumber(value.data?.overNumber??0);
                                                        score.setBallNumber(value.data?.ballNumber??0);
                                                        score.setBowlerChangeValue(value.data?.bowlerChange??0);
                                                        player.setStrikerId(value.data!.strikerId.toString(), "");
                                                        player.setNonStrikerId(value.data!.nonStrikerId.toString(), "");
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
                                            if(mounted){
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return UndoScreen(_refreshData);
                                                },
                                              );
                                            }

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
                    )
                  ],
                );
              }
          ),
        ),
      ),
    );
  }

  isBatsman()async{
    var players = Provider.of<PlayerSelectionProvider>(context, listen: false);
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
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ScoreBottomSheet(run,scoringData!,onSave: (value){
          if(mounted){
            setState(() {
              scoreUpdateResponseModel=value;
            });
          }
        }, _refreshData);
      },
    );
  }

  _displayBowlerBottomSheet (BuildContext context, int? selectedBowler,Function(int?) onItemSelected) async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> BowlerListBottomSheet(widget.matchId, widget.team2Id, _refreshData)
    ).then((value) {
      final players = Provider.of<PlayerSelectionProvider>(context, listen: false);
      final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
      debugPrint(players.selectedBowlerId);
      debugPrint('${score.bowlerChange}');
    });
  }

  Future<void> _displaySelectBatsmanBottomSheet (BuildContext context, int? selectedBatsman,Function(int?) onItemSelected,String player) async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> BatsmanListBottomSheet(widget.matchId, widget.team1Id, player, _refreshData)
    );
  }

//Out
  Future<void> _displayBottomOut (ScoringDetailResponseModel? scoringData) async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> WicketOptionsBottomSheet(scoringData, _refreshData)
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

  Future<void> _displayBottomSheetOther () async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        builder: (context)=> OtherBottomSheet(widget.matchId, widget.team1Id, widget.team2Id)
    );
  }

  Future<void> _displayBottomSheetWide (int ballType, ScoringDetailResponseModel? scoringData) async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> WideBottomSheet(ballType, scoringData, _refreshData)
    );
  }

  Future<void> _displayBottomSheetNoBall (int ballType,ScoringDetailResponseModel? scoringData) async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> NoBallBottomSheet(ballType, scoringData, _refreshData)
    );
  }

  Future<void> _displayBottomSheetLegBye (int ballType,ScoringDetailResponseModel? scoringData) async{

    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> LegByeBottomSheet(ballType, scoringData, _refreshData, widget.matchId, widget.team1Id)
    );
  }

  Future<void> _displayBottomSheetByes (int ballType,ScoringDetailResponseModel? scoringData) async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> ByesBottomSheet(ballType, scoringData, _refreshData, widget.matchId, widget.team1Id)
    );
  }

  Future<void> _displayBottomSheetBonus (int? ballType, ScoringDetailResponseModel? scoringData,) async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        builder: (context)=> BonusBottomSheet(ballType, scoringData, _refreshData)
    ).then((value) {
      _refreshData();
    });
  }

  Future<void> _displayBottomSheetMoreRuns(int ballType,ScoringDetailResponseModel? scoringData) async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        builder: (context)=> MoreRunsBottomSheet(ballType, scoringData, _refreshData)
    ).then((value) {
      _refreshData();
    });
  }

}





