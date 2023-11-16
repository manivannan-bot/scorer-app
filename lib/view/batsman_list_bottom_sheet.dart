import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:scorer/view/widgets/batsman_list_item.dart';
import 'package:scorer/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../models/player_list_model.dart';
import '../models/save_batsman_request_model.dart';
import '../provider/player_selection_provider.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import '../widgets/cancel_btn.dart';
import '../widgets/ok_btn.dart';

class BatsmanListBottomSheet extends StatefulWidget {
  final String matchId, team1Id, player;
  final VoidCallback refresh;
  const BatsmanListBottomSheet(this.matchId, this.team1Id, this.player, this.refresh, {super.key});

  @override
  State<BatsmanListBottomSheet> createState() => _BatsmanListBottomSheetState();
}

class _BatsmanListBottomSheetState extends State<BatsmanListBottomSheet> {

  bool searching = false;
  bool isResultEmpty = false;
  String searchedText = "";
  int? localBatsmanIndex = -1;
  TextEditingController searchController = TextEditingController();
  List<BattingPlayers>? searchedBatsman = [];
  List<BattingPlayers>? itemsBatsman = [];
  String batsmanId = "", batsmanName = "";


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

  getData(){
    ScoringProvider().getPlayerList(widget.matchId,widget.team1Id,'bat').then((value) {
      setState(() {
        itemsBatsman = [];
        searchedBatsman=value.battingPlayers!;
        itemsBatsman = value.battingPlayers;
        // selectedTeamName= value.team!.teamName;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print("batsman type ${widget.player}");
  }

  @override
  Widget build(BuildContext context) {
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
                Text("Select Batsman",style: fontMedium.copyWith(
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
                          onSearchBatsman(value);
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
                          hintText: "Search for batsman",
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
                          onSearchBatsman(" ");
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
            child: Text('',style: fontMedium.copyWith(
                fontSize:14.sp,
                color: AppColor.pri
            ),),
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
          else if(!isResultEmpty && searching)...[
            Expanded(
              child: ListView.builder(
                  itemCount: searchedBatsman!.length,
                  itemBuilder: (context, index) {
                    final isPlayerOut = searchedBatsman![index].isOut == 1 || searchedBatsman![index].isOut == 0;
                    return GestureDetector(
                      onTap: () {
                        if (isPlayerOut) {
                          debugPrint("batsman who can't be chosen");
                        } else {
                          setState(() {
                            batsmanId = searchedBatsman![index].playerId.toString();
                            batsmanName = searchedBatsman![index].playerName.toString();
                          });
                          setState(() {
                            if (localBatsmanIndex == index) {
                              localBatsmanIndex = null;
                            } else {
                              localBatsmanIndex = index;
                            }
                          });
                        }
                      },
                      child: isPlayerOut ? const SizedBox()
                      : PlayerListItem(
                          index,
                          localBatsmanIndex,
                          searchedBatsman![index].playerName,
                          searchedBatsman![index].battingStyle)

                    );
                  }

              ),
            ),
          ]
          else if(isResultEmpty || !searching)...[
              Expanded(
                child: ListView.builder(
                    itemCount: itemsBatsman!.length,
                    itemBuilder: (context, index) {
                      final isPlayerOut = itemsBatsman![index].isOut == 1 || itemsBatsman![index].isOut == 0;
                      return GestureDetector(
                        onTap: () {
                          if (isPlayerOut) {
                            debugPrint("batsman who we cannot choose");
                          } else {
                            setState(() {
                              batsmanId = itemsBatsman![index].playerId.toString();
                              batsmanName = itemsBatsman![index].playerName.toString();
                            });
                            setState(() {
                              if (localBatsmanIndex == index) {
                                localBatsmanIndex = null;
                              } else {
                                localBatsmanIndex = index;
                              }
                            });
                          }
                        },
                        child: isPlayerOut ? const SizedBox()
                            : PlayerListItem(
                            index,
                            localBatsmanIndex,
                            itemsBatsman![index].playerName,
                            itemsBatsman![index].battingStyle)
                      );
                    }

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
                GestureDetector(
                    onTap:(){
                      Navigator.pop(context);
                    },
                    child: const CancelBtn("Cancel")),
                SizedBox(width: 2.w,),
                GestureDetector(
                    onTap:()async {
                  if(localBatsmanIndex!=null){
                    final player = Provider.of<PlayerSelectionProvider>(context, listen: false);
                    bool striker=(widget.player=='striker_id')?true:false;
                    SaveBatsmanDetailRequestModel requestModel = SaveBatsmanDetailRequestModel(
                      batsman: [
                        Batsman(
                            matchId:int.parse(widget.matchId),
                            teamId: int.parse(widget.team1Id),
                            playerId: searchedBatsman![localBatsmanIndex!].playerId,
                            striker: striker
                        ),
                      ],
                    );
                    await ScoringProvider().saveBatsman(requestModel)
                    .then((value) {
                      if(value.status == true){
                        if(striker == true){
                          print("setting new striker after wicket");
                          player.setStrikerId(batsmanId, batsmanName);
                        } else {
                          print("setting new non-striker after wicket");
                          player.setNonStrikerId(batsmanId, batsmanName);
                        }
                        widget.refresh();
                        Navigator.pop(context);
                      }
                    });
                  }else{
                    Dialogs.snackBar("Select one player", context, isError: true);
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
