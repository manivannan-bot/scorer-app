import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scorer/models/commentary/commentary_overs_model.dart';
import 'package:scorer/provider/match_provider.dart';
import 'package:scorer/utils/colours.dart';
import 'package:sizer/sizer.dart';

import '../utils/images.dart';
import '../utils/sizes.dart';

class CommentaryOvers extends StatefulWidget {
  final String matchId;
  final String teamId;
  const CommentaryOvers(this.matchId,this.teamId, {super.key});

  @override
  State<CommentaryOvers> createState() => _CommentaryOversState();
}

class _CommentaryOversState extends State<CommentaryOvers> {
     CommentaryOversModel? commentaryOversModel;


  @override
  void initState() {
    super.initState();
    fetchData();
  }
  fetchData(){
    MatchProvider().getCommentaryOvers(widget.matchId, widget.teamId).then((value) {
      setState(() {
        commentaryOversModel=value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    if(commentaryOversModel==null){
      return const SizedBox(
          height: 100,
          width: 100,
          child: Center(child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          )));
    }
    if(commentaryOversModel!.data!.innings1!.isEmpty){
      return const Center(child: Text('No data found'));
    }
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          commentaryOversModel!.data!.innings2!.isEmpty ? const SizedBox() : Text('Innings 2',
              style: fontMedium.copyWith(
                color: Colors.black,
                fontSize: 14.sp,
              )),
          commentaryOversModel!.data!.innings2!.isEmpty ? const SizedBox()
              : ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, _) {
                  return Padding(
                    padding: EdgeInsets.only(right: 2.5.w,bottom: 1.5.h, top: 1.5.h),
                    child: const DottedLine(
                      dashColor: Color(0xffD2D2D2),
                    ),
                  );
                },
                itemCount: commentaryOversModel!.data!.innings2!.length,
                itemBuilder: (BuildContext context, int index) {
                  final option=commentaryOversModel!.data!.innings2![index];
                  var overNo=(option.overNumber??0)+1;
                  return Row(
                    children: [
                      SizedBox(
                        width: 15.w,
                        child: Text('Over $overNo',style: fontMedium.copyWith(
                          fontSize: 11.sp,
                          color: const Color(0xff666666),
                        ),),
                      ),
                      SizedBox(width: 5.w,),
                      Expanded(
                        child: SizedBox(
                          height: 3.h,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, _) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 2.w,bottom: 0.h),
                                );
                              },
                              itemCount:option.noOfBalls!.length ,
                              itemBuilder: (context, int index) {
                                final item = option.noOfBalls![index];
                                if(item.wicket==1){
                                  return const ScoreContainer( runsScored: 'w');
                                }
                                return ScoreContainer( runsScored: item.slugData??'0');
                              }),
                        ),
                      ),
                      SizedBox(width: 3.w,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('= ',
                            style: fontMedium.copyWith(
                              color: Colors.black,
                              fontSize: 11.sp,
                            ),
                          ),
                          Text('${option.overRun}',
                            style: fontMedium.copyWith(
                              color: Colors.black,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),

                    ],
                  );
                },

              ),
          commentaryOversModel!.data!.innings2!.isEmpty ? const SizedBox() : SizedBox(height: 3.h,),
          Text('Innings 1',
              style: fontMedium.copyWith(
                color: Colors.black,
                fontSize: 14.sp,
              )),
          ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, _) {
              return Padding(
                padding: EdgeInsets.only(right: 2.5.w,bottom: 1.5.h, top: 1.5.h),
                child: const DottedLine(
                  dashColor: Color(0xffD2D2D2),
                ),
              );
            },
            itemCount: commentaryOversModel!.data!.innings1!.length,
            itemBuilder: (BuildContext context, int index) {
              final option=commentaryOversModel!.data!.innings1![index];
              var overNo=(option.overNumber??0)+1;
              return  Row(
                children: [
                  SizedBox(
                    width: 15.w,
                    child: Text('Over $overNo',style: fontMedium.copyWith(
                      fontSize: 11.sp,
                      color: const Color(0xff666666),
                    ),),
                  ),
                  SizedBox(width: 5.w,),
                  Expanded(
                    child: SizedBox(
                      height: 3.h,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, _) {
                            return Padding(
                              padding: EdgeInsets.only(right: 2.w,),
                            );
                          },
                          itemCount:option.noOfBalls!.length ,
                          itemBuilder: (context, int index) {
                            final item = option.noOfBalls![index];
                            if(item.wicket==1){
                              return const ScoreContainer( runsScored: 'W');
                            }
                            return ScoreContainer( runsScored: item.slugData??'0');
                          }),
                    ),
                  ),
                  SizedBox(width: 3.w,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('= ',
                        style: fontMedium.copyWith(
                          color: Colors.black,
                          fontSize: 11.sp,
                        ),
                      ),
                      Text('${option.overRun}',
                        style: fontMedium.copyWith(
                          color: Colors.black,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),

                ],
              );
            },

          )],
      ),
    );
  }
}


class ScoreContainer extends StatelessWidget {
  final String runsScored;

  const ScoreContainer({super.key, required this.runsScored});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    bool border;

    if (runsScored == '6') {
      bgColor = const Color(0xff1A134C);
      textColor=Colors.white;
      border = false;
    } else if (runsScored == '4') {
      bgColor = const Color(0xff6654EB);
      border = false;
      textColor=Colors.white;
    } else if (runsScored == 'W') {
      bgColor = const Color(0xffFF0000);
      border = false;
      textColor=Colors.white;
    } else {
      bgColor = const Color(0xffFBFAF7);
      textColor=Colors.black;
      border = true;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: border ? Border.all(color: const Color(0xffDADADA)) : null,
        color: bgColor, // Use the determined background color
      ),
      child: Center(
        child: Text(
          runsScored,
          style: fontSemiBold.copyWith(
            fontSize: 9.sp,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
