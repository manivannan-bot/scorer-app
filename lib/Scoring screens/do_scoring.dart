import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorer/provider/player_selection_provider.dart';
import 'package:scorer/utils/colours.dart';
import 'package:scorer/utils/styles.dart';
import 'package:scorer/widgets/cancel_btn.dart';
import 'package:scorer/widgets/ok_btn.dart';
import 'package:scorer/widgets/stricker%20container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../models/player_list_model.dart';
import '../models/save_batsman_request_model.dart';
import '../provider/scoring_provider.dart';
import '../view/score_update_screen.dart';
import '../widgets/snackbar.dart';
import 'choose_bowler_bottom_sheet.dart';
import 'choose_non_striker_bottom_sheet.dart';
import 'choose_striker_bottom_sheet.dart';
import 'choose_wk_bottom_sheet.dart';

class DOScoring extends StatefulWidget {
  final String matchId;
  final String team1id;
  final String team2id;
  // final String teamAName;
  // final String teamBName;
  const DOScoring(this.matchId, this.team1id, this.team2id,
      // this.teamAName, this.teamBName,
      {super.key});

  @override
  State<DOScoring> createState() => _DOScoringState();
}

class _DOScoringState extends State<DOScoring> {

  List<BattingPlayers>? itemsBatsman = [];
  List<BowlingPlayers>? itemsBowler = [];
  List<WkPlayers>? itemsKeeper = [];
  List<BattingPlayers>? searchedBatsman = [];
  List<BowlingPlayers>? searchedBowler = [];
  List<WkPlayers>? searchedKeeper = [];
  int? selectedPlayer1;
  int? selectedBowler;
  int? selectedWicketKeeper;
  int? selectedPlayer2;
  String selectedPlayer1Name = "";
  String? selectedTeamName = "";
  String? selectedBTeamName = "";
  String selectedBowlerName = "";
  String? selectedPlayer2Name = '';
  String selectedWicketKeeperName = "";
  bool showError = false;

  bool searching = false;
  bool isResultEmpty = false;
  String searchedText = "";
  TextEditingController searchController = TextEditingController();
  int strikerId=0;
  int nonStrikerId=0;
  int bowlerId=0;
  int keeperId=0;


  bool striker = false;
  bool nonStriker = false;
  bool bowler = false;

  @override
  void initState() {
    super.initState();
    selectedPlayer1 = null;
    selectedBowler = null;
    selectedPlayer2 = null;
    selectedWicketKeeper = null;
    _fetchPlayers(widget.matchId, widget.team1id, widget.team2id);
  }

  Future<void> _fetchPlayers(
      String matchId, String team1id, String team2id) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
      strikerId=prefs.getInt('striker_id')??0;
      nonStrikerId=prefs.getInt('non_striker_id')??0;
      bowlerId=prefs.getInt('bowler_id')??0;
      keeperId=prefs.getInt('wicket_keeper_id')??0;
    });


  }
  onSearchBatsman(String search) {
    setState(() {
      searching = true;
      searchedText = search;
      searchedBatsman = itemsBatsman!.where((player) => player.playerName!.toLowerCase().toString().contains(search.toLowerCase())).toList();
      if (searchedBatsman!.isEmpty) {
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
  onSearchBowler(String search) {
    setState(() {
      searching = true;
      searchedText = search;
      searchedBowler = itemsBowler!.where((player) => player.playerName!.toLowerCase().toString().contains(search.toLowerCase())).toList();
      if (searchedBatsman!.isEmpty) {
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
  onSearchKeeper(String search) {
    setState(() {
      searching = true;
      searchedText = search;
      searchedKeeper = itemsKeeper!.where((player) => player.playerName!.toLowerCase().toString().contains(search.toLowerCase())).toList();
      if (searchedBatsman!.isEmpty) {
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

  displayError() {
    setState(() {
      showError = true;
    });
    Timer(const Duration(seconds: 4), () {
      setState(() {
        showError = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF8F9FA),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w)
              + EdgeInsets.only(
                    top: 5.h
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 7.w,
                      )),
                  Text(
                    "Start Innings",
                    style: fontMedium.copyWith(
                      fontSize: 18.sp,
                      color: AppColor.blackColour,
                    ),
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                    ) +
                    EdgeInsets.only(top: 2.h, bottom: 3.h),
                decoration: BoxDecoration(
                  color: AppColor.lightColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Batsman*",
                      style: fontMedium.copyWith(
                        fontSize: 16.sp,
                        color: AppColor.blackColour,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              displayStrikerListBottomSheet();
                            },
                            child: Consumer<PlayerSelectionProvider>(
                              builder: (context, player, child) {
                                return ChooseContainer(player.selectedStrikerName != ""
                                    ? player.selectedStrikerName
                                    : "Striker");
                              }
                            )),
                        SizedBox(
                          width: 8.w,
                        ),
                        GestureDetector(
                            onTap: () {
                              displayNonStrikerListBottomSheet();
                              // _displayPlayer2BottomSheet(
                              //     context, selectedPlayer2, (newIndex) async {
                              //   setState(() {
                              //     selectedPlayer2 = newIndex;
                              //     if (selectedPlayer2 != null) {
                              //       selectedPlayer2Name =
                              //           itemsBatsman![selectedPlayer2!].playerName ??
                              //               "";
                              //     }
                              //   });
                              // });
                              // ScoringProvider()
                              //     .getPlayerList(
                              //         widget.matchId, widget.team1id, 'bat')
                              //     .then((value) {
                              //   setState(() {
                              //     searchedBatsman= value.battingPlayers;
                              //     itemsBatsman = value.battingPlayers;
                              //     selectedTeamName = value.team!.teamName;
                              //   });
                              // });
                            },
                            child: Consumer<PlayerSelectionProvider>(
                                builder: (context, player, child) {
                                return ChooseContainer(player.selectedNonStrikerName == ""
                                    ? "Non-Striker"
                                    : player.selectedNonStrikerName);
                              }
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                    ) +
                    EdgeInsets.only(top: 2.h, bottom: 3.h),
                decoration: BoxDecoration(
                  color: AppColor.lightColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Bowler*",
                          style: fontMedium.copyWith(
                            fontSize: 16.sp,
                            color: AppColor.blackColour,
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          "Wicket Keeper*",
                          style: fontMedium.copyWith(
                            fontSize: 16.sp,
                            color: AppColor.blackColour,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              displayBowlerListBottomSheet();
                              // ScoringProvider()
                              //     .getPlayerList(
                              //         widget.matchId, widget.team2id, 'bowl')
                              //     .then((value) {
                              //   setState(() {
                              //     searchedBowler=value.bowlingPlayers;
                              //     itemsBowler = value.bowlingPlayers;
                              //     selectedBTeamName = value.team!.teamName;
                              //   });
                              //   _displayBowlerBottomSheet(
                              //       context, selectedBowler,
                              //       (bowlerIndex) async {
                              //     setState(() {
                              //       selectedBowler = bowlerIndex;
                              //       if (selectedBowler != null) {
                              //         selectedBowlerName =
                              //             itemsBowler![selectedBowler!]
                              //                     .playerName ??
                              //                 "";
                              //       }
                              //     });
                              //   });
                              // });
                            },
                            child: Consumer<PlayerSelectionProvider>(
                                builder: (context, player, child) {
                                return ChooseContainer(player.selectedBowlerName == ""
                                    ? "Bowler"
                                    : player.selectedBowlerName);
                              }
                            )),
                        SizedBox(
                          width: 8.w,
                        ),
                        GestureDetector(
                            onTap: () async {
                              displayWicketKeeperListBottomSheet();
                              // await ScoringProvider()
                              //     .getPlayerList(
                              //         widget.matchId, widget.team2id, 'wk')
                              //     .then((value) {
                              //   setState(() {
                              //     searchedKeeper=value.wkPlayers;
                              //     itemsKeeper = value.wkPlayers;
                              //     selectedBTeamName = value.team!.teamName;
                              //   });
                              //   _displayKeeperBottomSheet(
                              //       context, selectedWicketKeeper,
                              //       (bowlerIndex) async {
                              //     setState(() {
                              //       selectedWicketKeeper = bowlerIndex;
                              //       if (selectedWicketKeeper != null) {
                              //         selectedWicketKeeperName =
                              //             itemsKeeper![selectedWicketKeeper!]
                              //                     .playerName ??
                              //                 "";
                              //       }
                              //     });
                              //   });
                              // });
                            },
                            child: Consumer<PlayerSelectionProvider>(
                                builder: (context, player, child) {
                                return ChooseContainer(
                                    player.selectedWicketKeeperName == ""
                                        ? "Wicket Keeper"
                                        : player.selectedWicketKeeperName);
                              }
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
            //cancel bt
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
              decoration: const BoxDecoration(
                color: AppColor.lightColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const CancelBtn("Cancel")),
                  SizedBox(
                    width: 2.w,
                  ),
                  Consumer<PlayerSelectionProvider>(
                    builder: (context, player, child) {
                      if(player.selectedStrikerId == "" ||
                          player.selectedNonStrikerId == "" ||
                          player.selectedBowlerId == "" ||
                          player.selectedWicketKeeperId == "") {
                        return const SizedBox();
                      } else {
                        return GestureDetector(
                            child: const OkBtn("Ok"),
                            onTap: () async {
                              final players = Provider.of<PlayerSelectionProvider>(context, listen: false);
                              // SharedPreferences prefs =
                              //     await SharedPreferences.getInstance();
                              // var strikerId = prefs.getInt('striker_id') ?? 0;
                              // var nonStrikerId =
                              //     prefs.getInt('non_striker_id') ?? 0;
                              // var bowlerId = prefs.getInt('bowler_id') ?? 0;
                              // var keeperId = prefs.getInt('wicket_keeper_id') ?? 0;
                              if (players.selectedStrikerId == "" ||
                                  players.selectedNonStrikerId == "" ||
                                  players.selectedBowlerId == "" ||
                                  players.selectedWicketKeeperId == "") {
                                Dialogs.snackBar("Select all players", context, isError: true);
                              } else {
                                SaveBatsmanDetailRequestModel requestModel = SaveBatsmanDetailRequestModel(
                                  batsman: [
                                    Batsman(
                                        matchId: int.parse(widget.matchId),
                                        teamId: int.parse(widget.team1id),
                                        playerId:
                                        int.parse(players.selectedStrikerId),
                                        striker: true),
                                  ],
                                );
                                SaveBatsmanDetailRequestModel request1Model = SaveBatsmanDetailRequestModel(
                                  batsman: [
                                    Batsman(
                                        matchId: int.parse(widget.matchId),
                                        teamId: int.parse(widget.team1id),
                                        playerId:
                                        int.parse(players.selectedNonStrikerId),
                                        striker: false),
                                  ],
                                );
                                ScoringProvider()
                                    .saveBatsman(requestModel)
                                    .then((value) {
                                  if(value.status == true){
                                    setState(() {
                                      striker = true;
                                    });
                                  }
                                });
                                ScoringProvider()
                                    .saveBatsman(request1Model).then((value) {
                                  if(value.status == true){
                                    setState(() {
                                      nonStriker = true;
                                    });
                                  }
                                });
                                ScoringProvider()
                                    .saveBowler(widget.matchId, widget.team2id, players.selectedBowlerId)
                                    .then((value) {
                                  if(value.status == true){
                                    setState(() {
                                      bowler = true;
                                    });
                                  }
                                });
                                if(striker && nonStriker && bowler){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScoreUpdateScreen(
                                              widget.matchId, widget.team1id, widget.team2id)));
                                } else {
                                  Dialogs.snackBar("Something went wrong. Please try again", context, isError: true);
                                }
                              }
                            });
                      }
                    }
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  displayStrikerListBottomSheet() async {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return ChooseStrikerBottomSheet(widget.matchId, widget.team1id, "");
              },
            ));
  }

  displayNonStrikerListBottomSheet() async {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return ChooseNonStrikerBottomSheet(widget.matchId, widget.team1id, "");
          },
        ));
  }

  displayBowlerListBottomSheet() async {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return ChooseBowlerBottomSheet(widget.matchId, widget.team2id, "");
          },
        ));
  }

  displayWicketKeeperListBottomSheet() async {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return ChooseWicketKeeperBottomSheet(widget.matchId, widget.team2id, "");
          },
        ));
  }
}
