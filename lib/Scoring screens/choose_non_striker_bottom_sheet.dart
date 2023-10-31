import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:scorer/provider/player_selection_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../models/player_list_model.dart';
import '../models/save_batsman_request_model.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import '../widgets/cancel_btn.dart';
import '../widgets/ok_btn.dart';
import '../widgets/snackbar.dart';

class ChooseNonStrikerBottomSheet extends StatefulWidget {
  final String matchId, teamId, teamName;
  const ChooseNonStrikerBottomSheet(this.matchId, this.teamId, this.teamName, {super.key});

  @override
  State<ChooseNonStrikerBottomSheet> createState() => _ChooseNonStrikerBottomSheetState();
}

class _ChooseNonStrikerBottomSheetState extends State<ChooseNonStrikerBottomSheet> {

  List<BattingPlayers> battingPlayers = [];
  Future<List<BattingPlayers>?>? futureData;
  String teamName = "";

  bool searching = false;
  bool isResultEmpty = false;
  String searchedText = "";
  TextEditingController searchController = TextEditingController();
  List<BattingPlayers>? searchedBatsman = [];

  int localSelectedIndex = -1;
  String playerId = "", playerName = "";

  onSearchNonStriker(String search) {
    setState(() {
      searching = true;
      searchedText = search;
      searchedBatsman = battingPlayers.where((player) => player.playerName!.toLowerCase().toString().contains(search.toLowerCase())).toList();
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
    futureData = ScoringProvider()
        .getPlayerList(
        widget.matchId, widget.teamId, 'bat')
        .then((value) {
      setState(() {
        battingPlayers = value.battingPlayers!;
        teamName = value.team!.teamName.toString();
      });
      return value.battingPlayers;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      decoration: const BoxDecoration(
          color: AppColor.lightColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                  "Select Non-Striker",
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
            height: 1.h,
          ),
          const Divider(
            thickness: 1,
            color: Color(0xffD3D3D3),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 5.w, vertical: 1.h),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xffF8F9FA),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 5.w, vertical: 1.2.h),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        cursorColor: AppColor.secondaryColor,
                        onChanged: (value) {
                          onSearchNonStriker(value);
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
                          hintText: "Search for players",
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
                          onSearchNonStriker(" ");
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
            child: Text(
              widget.teamName,
              style: fontMedium.copyWith(
                  fontSize: 14.sp, color: AppColor.pri),
            ),
          ),
          // const Divider(
          //   thickness: 0.5,
          //   color: Color(0xffD3D3D3),
          // ),
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
            child: FadeIn(
              child: ListView.separated(
                separatorBuilder: (context, _) {
                  return const Divider(
                    thickness: 0.6,
                  );
                },
                itemCount: searchedBatsman!.length,
                itemBuilder: (context, index) {
                  final player = searchedBatsman![index];
                  return Consumer<PlayerSelectionProvider>(
                    builder: (context, id, child) {
                      if(id.selectedStrikerId == player.playerId.toString()){
                        return const SizedBox();
                      } else {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              playerId = player.playerId.toString();
                              playerName = player.playerName.toString();
                              if (localSelectedIndex == index) {
                                localSelectedIndex = 0; // Deselect the item if it's already selected
                              } else {
                                localSelectedIndex =
                                    index; // Select the item if it's not selected
                              }
                              // onItemSelected(localSelectedIndex);
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.5.w, vertical: 1.h),
                            child: Row(
                              children: [
                                //circular button
                                Container(
                                  height:
                                  20.0, // Adjust the height as needed
                                  width: 20.0, // Adjust the width as needed
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: localSelectedIndex == index
                                        ? Colors.blue
                                        : Colors
                                        .grey, // Change colors based on selected index
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons
                                          .circle_outlined, // You can change the icon as needed
                                      color: Colors.white, // Icon color
                                      size: 20.0, // Icon size
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Image.asset(
                                  Images.playersImage,
                                  width: 10.w,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      searchedBatsman![index].playerName ?? '-',
                                      style: fontMedium.copyWith(
                                        fontSize: 12.sp,
                                        color: AppColor.blackColour,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 1.h,
                                          width: 2.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(50),
                                            color: AppColor.pri,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          searchedBatsman![index].battingStyle ?? '-',
                                          style: fontMedium.copyWith(
                                              fontSize: 11.sp,
                                              color:
                                              const Color(0xff555555)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        );
                      }
                    }
                  );
                },
              ),
            ),
          ),]
          else if(isResultEmpty || !searching)...[
            Expanded(
              child: FutureBuilder(
                future: futureData,
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  if(snapshot.connectionState == ConnectionState.done){
                    return FadeIn(
                      child: ListView.builder(
                        itemCount: battingPlayers.length,
                        itemBuilder: (context, index) {
                          final player = battingPlayers[index];
                          return Consumer<PlayerSelectionProvider>(
                            builder: (context, id, child) {
                              if(id.selectedStrikerId == player.playerId.toString()){
                                return const SizedBox();
                              } else {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      playerId = player.playerId.toString();
                                      playerName = player.playerName.toString();
                                      if (localSelectedIndex == index) {
                                        localSelectedIndex = 0; // Deselect the item if it's already selected
                                      } else {
                                        localSelectedIndex =
                                            index; // Select the item if it's not selected
                                      }
                                      // onItemSelected(localSelectedIndex);
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.5.w, vertical: 1.h),
                                        child: Row(
                                          children: [
                                            //circular button
                                            Container(
                                              height:
                                              20.0, // Adjust the height as needed
                                              width: 20.0, // Adjust the width as needed
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: localSelectedIndex == index
                                                    ? Colors.blue
                                                    : Colors
                                                    .grey, // Change colors based on selected index
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons
                                                      .circle_outlined, // You can change the icon as needed
                                                  color: Colors.white, // Icon color
                                                  size: 20.0, // Icon size
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Image.asset(
                                              Images.playersImage,
                                              width: 10.w,
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  battingPlayers[index].playerName ?? '-',
                                                  style: fontMedium.copyWith(
                                                    fontSize: 12.sp,
                                                    color: AppColor.blackColour,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 1.h,
                                                      width: 2.w,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(50),
                                                        color: AppColor.pri,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Text(
                                                      battingPlayers[index].battingStyle ?? '-',
                                                      style: fontMedium.copyWith(
                                                          fontSize: 11.sp,
                                                          color:
                                                          const Color(0xff555555)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                );
                              }
                            }
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                }
              ),
            ),],

          Container(
            padding: EdgeInsets.symmetric(
                vertical: 2.h, horizontal: 5.w),
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
                GestureDetector(
                    onTap: () async {
                      if (playerId != "") {
                        Provider.of<PlayerSelectionProvider>(context, listen: false).setNonStrikerId(playerId.toString(), playerName.toString());
                        // SaveBatsmanDetailRequestModel requestModel =
                        // SaveBatsmanDetailRequestModel(
                        //   batsman: [
                        //     Batsman(
                        //         matchId: int.parse(widget.matchId),
                        //         teamId: int.parse(widget.teamId),
                        //         playerId:
                        //         int.parse(playerId),
                        //         striker: true),
                        //   ],
                        // );
                        //
                        // ScoringProvider()
                        //     .saveBatsman(requestModel);
                        // SharedPreferences prefs =
                        // await SharedPreferences.getInstance();
                        // await prefs.setInt('striker_id',
                        //     searchedBatsman![0].playerId!);

                        Navigator.pop(context);
                      } else {
                        Dialogs.snackBar("Choose a non striker", context, isError: true);
                        // displayError();
                      }
                    },
                    child: const OkBtn("Ok")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
