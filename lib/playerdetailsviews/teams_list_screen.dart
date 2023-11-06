import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:scorer/models/players/player_team_info_model.dart';
import 'package:scorer/provider/player_details_provider.dart';
import 'package:sizer/sizer.dart';

import '../teamsdetailsview/team_detail_view_screens.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class TeamListScreen extends StatefulWidget {
  final String playerId;
  const TeamListScreen(this.playerId, {super.key});

  @override
  State<TeamListScreen> createState() => _TeamListScreenState();
}

class _TeamListScreenState extends State<TeamListScreen> {

  PlayerTeamInfoModel? playerTeamInfoModel;

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  fetchData(){
    PlayerDetailsProvider().getPlayerTeamInfo(widget.playerId).then((value) {
      setState(() {
        playerTeamInfoModel=value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    if(playerTeamInfoModel==null){
      return const SizedBox(
        height: 50,
        width: 50,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        ),
      );
    }
    if(playerTeamInfoModel!.data!.isEmpty){
      return const Center(child: Text('No data found'),);
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                  color: AppColor.lightColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Teams",style: fontMedium.copyWith(
                    fontSize: 14.sp,
                    color: AppColor.blackColour,
                  ),),
                  SizedBox(height: 2.h,),
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,  // Set this to true to remove top padding
                    removeBottom: true,
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, _) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 1.h)
                          );
                        },
                        itemCount: playerTeamInfoModel!.data!.length,
                        itemBuilder: (context, int index) {

                          return   GestureDetector(onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TeamDetailViewScreens(playerTeamInfoModel!.data![index].teamId.toString())));
                          },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.5.h),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffF8F9FA),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Image.asset(Images.teamListImage,width: 20.w,),
                                      ),
                                      SizedBox(width: 2.w,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${playerTeamInfoModel!.data![index].teamName}", style: fontMedium.copyWith(
                                              fontSize: 14.sp,
                                              color: AppColor.blackColour,
                                            )),
                                            SizedBox(height: 1.h,),
                                            const DottedLine(
                                              dashColor: Color(0xffD2D2D2),
                                            ),
                                            SizedBox(height: 1.h,),
                                            Wrap(
                                              children: [
                                                RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: "Played : ",
                                                          style: fontMedium.copyWith(
                                                            fontSize: 12.sp,
                                                            color: AppColor.textGrey,
                                                          )),
                                                      TextSpan(
                                                          text: "${playerTeamInfoModel!.data![index].played}",
                                                          style: fontRegular.copyWith(
                                                            fontSize: 12.sp,
                                                            color: AppColor.blackColour,
                                                          )),
                                                    ])),
                                                SizedBox(width: 1.5.w,),
                                                RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: "Won : ",
                                                          style: fontMedium.copyWith(
                                                            fontSize: 12.sp,
                                                            color: AppColor.textGrey,
                                                          )),
                                                      TextSpan(
                                                          text: "${playerTeamInfoModel!.data![index].matchWonBy}",
                                                          style: fontRegular.copyWith(
                                                            fontSize: 12.sp,
                                                            color: AppColor.blackColour,
                                                          )),
                                                    ])),
                                                SizedBox(width: 1.5.w,),
                                                RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text: "Lost : ",
                                                          style: fontMedium.copyWith(
                                                            fontSize: 12.sp,
                                                            color: AppColor.textGrey,
                                                          )),
                                                      TextSpan(
                                                          text: "${playerTeamInfoModel!.data![index].matchLossBy}",
                                                          style: fontRegular.copyWith(
                                                            fontSize: 12.sp,
                                                            color: AppColor.blackColour,
                                                          )),
                                                    ])),
                                              ],

                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),

    );
  }
}
