import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorer/models/score_card_response_model.dart';
import 'package:scorer/utils/colours.dart';
import 'package:sizer/sizer.dart';

import '../utils/images.dart';
import '../utils/sizes.dart';

class ScoreCardOne extends StatefulWidget {
  final Data scoreCardData;
  const ScoreCardOne(this.scoreCardData, {super.key});

  @override
  State<ScoreCardOne> createState() => _ScoreCardOneState();
}

class _ScoreCardOneState extends State<ScoreCardOne> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 5.w)
      + EdgeInsets.only(
            top: 2.h
          ),
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView(
          children: [
            Row(
              children: [
                Text("Batting",style: fontMedium.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.blackColour,
                ),),
                SizedBox(width: 1.w,),
                SvgPicture.asset(Images.batIcon,width: 3.w,),
              ],
            ),
            SizedBox(height: 2.h,),
            Row(
              children: [
                SizedBox(
                  width: 35.w,
                  child: Text("Batsman",style: fontRegular.copyWith(
                    fontSize: 11.sp,
                    color: AppColor.pri,
                  ),),
                ),
                SizedBox(width: 5.w,),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("R",style: fontRegular.copyWith(
                        fontSize: 10.sp,
                        color: const Color(0xff777777),
                      ),),
                      Text("B",style: fontRegular.copyWith(
                        fontSize: 10.sp,
                        color: const Color(0xff777777),
                      ),),
                      Text("4s",style: fontRegular.copyWith(
                        fontSize: 10.sp,
                        color: const Color(0xff777777),
                      ),),
                      Text("6s",style: fontRegular.copyWith(
                        fontSize: 10.sp,
                        color: const Color(0xff777777),
                      ),),
                      Text("SR",style: fontRegular.copyWith(
                        fontSize: 10.sp,
                        color: const Color(0xff777777),
                      ),),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              color: Color(0xffD3D3D3),
            ),
            (widget.scoreCardData.batting!.isEmpty) ? const Text('No data found')
                : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, _) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 0.5.h),
                    child: const DottedLine(
                      dashColor: Color(0xffD2D2D2),
                    ),
                  );
                },
                itemCount: widget.scoreCardData.batting!.length,
                itemBuilder: (context, int index) {
                  final item = widget.scoreCardData.batting![index];
                  return Row(
                    children: [
                      SizedBox(
                        width: 35.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("${item.playerName}",style: fontRegular.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.textColor,
                                ),),
                                SizedBox(width: 1.w,),
                                (item.isOut!=1 && item.stricker==1)?
                                SvgPicture.asset(Images.batIcon,width: 3.w,color: AppColor.blackColour,) : const SizedBox(),
                              ],
                            ),
                            SizedBox(height: 0.5.h,),
                            (item.isOut==1)?RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: ("${item.outName??'-'} ${item.wicketerName}\n"),
                                      style: fontRegular.copyWith(
                                        fontSize: 10.sp,
                                        color: const Color(0xff777777),
                                      )),
                                  TextSpan(
                                      text: "b ${item.wicketBowlerName}",
                                      style: fontRegular.copyWith(
                                          fontSize: 10.sp,
                                          color: const Color(0xff777777)
                                      )),
                                ])):Text('Batting',style: fontRegular.copyWith(fontSize: 10.sp,color: const Color(0xff777777)),),
                            SizedBox(height: 1.h,),
                          ],
                        ),
                      ),
                      SizedBox(width: 5.w,),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${item.runsScored}",style: fontMedium.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.textColor,
                            ),),
                            Text("${item.ballsFaced}",style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: const Color(0xff777777),
                            ),),
                            Text("${item.fours}",style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: const Color(0xff777777),
                            ),),
                            Text("${item.sixes}",style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: const Color(0xff777777),
                            ),),
                            Text("${item.strikeRate}",style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: const Color(0xff777777),
                            ),),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
            const Divider(
              color: Color(0xffD3D3D3),
            ),
            Row(
              children: [
                SizedBox(
                  width: 35.w,
                  child: Text("Extras:",style: fontRegular.copyWith(
                    fontSize: 11.sp,
                    color: AppColor.blackColour,
                  ),),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text("${widget.scoreCardData.bowlingExtras!.totalExtras??'0'}",style: fontMedium.copyWith(
                      fontSize: 11.sp,
                      color: AppColor.blackColour,
                    ),),
                    SizedBox(width: 2.w,),
                    Text("( ${widget.scoreCardData.bowlingExtras!.legByes??'0'} lb,",style: fontRegular.copyWith(
                      fontSize: 10.sp,
                      color: const Color(0xff777777),
                    ),),
                    SizedBox(width: 2.w,),
                    Text("${widget.scoreCardData.bowlingExtras!.wides??'0'} w,",style: fontRegular.copyWith(
                      fontSize: 10.sp,
                      color: const Color(0xff777777),
                    ),),
                    SizedBox(width: 2.w,),
                    Text("${widget.scoreCardData.bowlingExtras!.noBalls??'0'} nb )",style: fontRegular.copyWith(
                      fontSize: 10.sp,
                      color: const Color(0xff777777),
                    ),),
                  ],
                ),
              ],
            ),
            const Divider(
              color: Color(0xffD3D3D3),
            ),
            SizedBox(height: 1.h,),
            //yet to bat
            Row(
              children: [
                Text("Yet to bat",style: fontMedium.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.blackColour,
                ),),
                SizedBox(width: 2.w,),
                SvgPicture.asset(Images.helmetIcon,width: 3.w,),
              ],
            ),
            SizedBox(height: 2.h,),
            (widget.scoreCardData.yetToBatPlayers!.isEmpty)? const Text('No data found')
                :GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 1 column
                childAspectRatio: 2.7, // Adjust the aspect ratio as needed
              ),
              itemCount: widget.scoreCardData.yetToBatPlayers!.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final item = widget.scoreCardData.yetToBatPlayers![index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(child: Image.network(Images.playersImage,width: 10.w,)),
                    SizedBox(width: 2.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 30.w,
                          child: Text("${item.playerName}",style: fontRegular.copyWith(
                            fontSize: 11.sp,
                            color: AppColor.blackColour,
                          ),),
                        ),
                        (item.battingStyle!=null)?Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: AppColor.pri,
                              radius: 3,
                            ),
                            SizedBox(width: 1.w,),
                            Text("${item.battingStyle}",style: fontRegular.copyWith(
                                fontSize: 10.sp,
                                color: const Color(0xff666666)
                            ),),
                          ],
                        ):const Text('')
                      ],
                    ),

                  ],
                );
              },
            ),
            const Divider(
              color: Color(0xffD3D3D3),
            ),
            SizedBox(height: 1.h,),
            //bowling
            Row(
              children: [
                Text("Bowling",style: fontMedium.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.blackColour,
                ),),
                SizedBox(width: 1.w,),
                SvgPicture.asset(Images.ballIcon,width: 4.w,),
              ],
            ),
            SizedBox(height: 1.5.h,),
            Row(
              children: [
                SizedBox(
                  width: 35.w,
                  child: Text("Bowling",style: fontRegular.copyWith(
                    fontSize: 11.sp,
                    color: AppColor.pri,
                  ),),
                ),
                SizedBox(width: 5.w,),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("O",style: fontRegular.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff777777),
                      ),),
                      Text("M",style: fontRegular.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff777777),
                      ),),
                      Text("R",style: fontRegular.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff777777),
                      ),),
                      Text("W",style: fontRegular.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff777777),
                      ),),
                      Text("Eco",style: fontRegular.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff777777),
                      ),),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              color: Color(0xffD3D3D3),
            ),
            (widget.scoreCardData.bowling!.isEmpty)?const Text('No data found'): ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, _) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 0.5.h),
                    child: const DottedLine(
                      dashColor: Color(0xffD2D2D2),
                    ),
                  );
                },
                itemCount: widget.scoreCardData.bowling!.length,
                itemBuilder: (context, int index) {
                  final item = widget.scoreCardData.bowling![index];
                  return Row(
                    children: [
                      SizedBox(
                        width: 35.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: 0.5.h,bottom: 0.5.h),
                                  child: Text("${item.playerName??'-'}",style: fontRegular.copyWith(
                                    fontSize: 11.sp,
                                    color: AppColor.blackColour,
                                  ),),
                                ),
                                SizedBox(width: 1.w,),
                                (item.active==1)?
                                SvgPicture.asset(Images.ballBlackIcon,width: 4.w,color: AppColor.blackColour,):const SizedBox(),
                              ],
                            ),
                            SizedBox(height: 1.h,),
                          ],
                        ),
                      ),
                      SizedBox(width: 5.w,),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${item.overBall}",style: fontMedium.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.blackColour,
                            ),),
                            Text("${item.maiden}",style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: const Color(0xff777777),
                            ),),
                            Text("${item.runsConceded}",style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: const Color(0xff777777),
                            ),),
                            Text("${item.wickets}",style: fontMedium.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.blackColour,
                            ),),
                            Text("${item.economy}",style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: const Color(0xff777777),
                            ),),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
            const Divider(
              color: Color(0xffD3D3D3),
            ),
            SizedBox(height: 1.h,),
            //fall of wickets
            Row(
              children: [
                Text("Fall of wickets",style: fontMedium.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.blackColour,
                ),),
                SizedBox(width: 1.w,),
                SvgPicture.asset(Images.stupmsIconss,width: 3.w,),
              ],
            ),
            SizedBox(height: 1.5.h,),
            Row(
              children: [
                SizedBox(
                  width: 50.w,
                  child: Text("Batsman",style: fontRegular.copyWith(
                    fontSize: 11.sp,
                    color: AppColor.pri,
                  ),),
                ),
                SizedBox(width: 5.w,),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Score",style: fontRegular.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff777777),
                      ),),
                      Text("Over",style: fontRegular.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff777777),
                      ),),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              color: Color(0xffD3D3D3),
            ),
            (widget.scoreCardData.fallOfWicket!.isEmpty)?const Text('No data found'):ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, _) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 0.5.h),
                    child: const DottedLine(
                      dashColor: Color(0xffD2D2D2),
                    ),
                  );
                },
                itemCount: widget.scoreCardData.fallOfWicket!.length,
                itemBuilder: (context, int index) {

                  final item = widget.scoreCardData.fallOfWicket![index];
                  return Row(
                    children: [
                      SizedBox(
                        width: 50.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: 0.5.h,bottom: 0.5.h),
                                  child: Text("${item.playerOutName}",style: fontRegular.copyWith(
                                    fontSize: 11.sp,
                                    color: AppColor.blackColour,
                                  ),),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h,),
                          ],
                        ),
                      ),
                      SizedBox(width: 5.w,),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${item.wicketNumber}-${item.teamScore}",style: fontMedium.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.blackColour,
                            ),),
                            Text("${item.over}",style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: const Color(0xff777777),
                            ),),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
            const Divider(
              color: Color(0xffD3D3D3),
            ),
            SizedBox(height: 1.h,),
            //partnership
            Row(
              children: [
                Text("Partnerships",style: fontMedium.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.blackColour,
                ),),
                SizedBox(width: 1.w,),
                SvgPicture.asset(Images.partnerShipIcon,width: 3.w,),
              ],
            ),
            SizedBox(height: 1.h,),
            Row(
              children: [
                Text("Batsman 1",style: fontRegular.copyWith(
                  fontSize: 10.sp,
                  color: AppColor.pri,
                ),),
                const Spacer(),
                Text("Batsman 2",style: fontRegular.copyWith(
                  fontSize: 10.sp,
                  color: AppColor.pri,
                ),),
              ],
            ),
            const Divider(
              color: Color(0xffD3D3D3),
            ),
            (widget.scoreCardData.partnerships!.isEmpty)?const Text('No data found'): ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, _) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 0.5.h),
                    child: const DottedLine(
                      dashColor: Color(0xffD2D2D2),
                    ),
                  );
                },
                itemCount: widget.scoreCardData.partnerships!.length,
                itemBuilder: (context, int index) {
                  final item = widget.scoreCardData.partnerships![index];
                  int player1Runs = int.tryParse(item.player1RunsScored?.toString() ?? "0") ?? 0;
                  int player2Runs = int.tryParse(item.player2RunsScored?.toString() ?? "0") ?? 0;
                  int totalRuns = player1Runs + player2Runs;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(top: 0.5.h,bottom: 1.h),
                        child: Row(
                          children: [
                            Text(getOrdinalNumber(index+1),style: fontRegular.copyWith(
                                fontSize: 11.sp,
                                color: const Color(0xff666666)
                            ),),
                            SizedBox(width: 1.w,),
                            Text("Wicket",style: fontRegular.copyWith(
                                fontSize: 11.sp,
                                color: const Color(0xff666666)
                            ),),

                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: 0.5.h,bottom: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("${item.player1Name}",style: fontRegular.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.blackColour,
                                ),),
                                SizedBox(height: 0.5.h),
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: ("${item.player1RunsScored}"),
                                          style: fontMedium.copyWith(
                                              fontSize: 11.sp,
                                              color: AppColor.blackColour
                                          )),
                                      TextSpan(
                                          text: " (${item.player1BallsFaced})",
                                          style: fontRegular.copyWith(
                                              fontSize: 11.sp,
                                              color: const Color(0xff666666)
                                          )),
                                    ])),
                              ],
                            ),
                            Column(
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: ("${item.totalRunsScored}"),
                                          style: fontMedium.copyWith(
                                              fontSize: 11.sp,
                                              color: AppColor.blackColour
                                          )),
                                      TextSpan(
                                          text: " (${item.totalBallsFaced})",
                                          style: fontRegular.copyWith(
                                              fontSize: 11.sp,
                                              color: const Color(0xff666666)
                                          )),
                                    ])),
                                SizedBox(height: 0.5.h),
                                MyProgressIndicator(currentValue: player1Runs,totalValue: totalRuns,),
                              ],
                            ),
                            Column(
                              children: [
                                Text("${item.player2Name}",style: fontRegular.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.blackColour,
                                ),),
                                SizedBox(height: 0.5.h),
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: ("${item.player2RunsScored}"),
                                          style: fontMedium.copyWith(
                                              fontSize: 11.sp,
                                              color: AppColor.blackColour
                                          )),
                                      TextSpan(
                                          text: " (${item.player2BallsFaced})",
                                          style: fontRegular.copyWith(
                                              fontSize: 11.sp,
                                              color: const Color(0xff666666)
                                          )),
                                    ])),
                              ],
                            ),

                          ],
                        ),
                      ),

                    ],
                  );
                }),
            const Divider(
              color: Color(0xffD3D3D3),
            ),
          ],
        ),
      ),
    );
  }

  String getOrdinalNumber(int number) {
    if (number < 1 || number > 100) {
      return 'Number out of range';
    }

    if (number % 100 >= 11 && number % 100 <= 13) {
      return '$number' 'th';
    }

    switch (number % 10) {
      case 1:
        return '$number' 'st';
      case 2:
        return '$number' 'nd';
      case 3:
        return '$number' 'rd';
      default:
        return '$number' 'th';
    }
  }
}



class MyProgressIndicator extends StatelessWidget {
  int currentValue = 40;
  int totalValue = 100;

  MyProgressIndicator({super.key, required this.currentValue, required this.totalValue});


  @override
  Widget build(BuildContext context) {
    double progress = currentValue / ((totalValue==0)?1:totalValue);

    return SizedBox(
      width: 10.w,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LinearProgressIndicator(
              minHeight: 1.h,
              borderRadius: BorderRadius.circular(4),
              value: progress,
              backgroundColor: const Color(0xffAD8E2E),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xffFFD200)),
            ),
          ],
        ),
      ),
    );
  }
}