import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scorer/models/commentary/commentary_overs_model.dart';
import 'package:scorer/provider/match_provider.dart';
import 'package:scorer/utils/colours.dart';
import 'package:sizer/sizer.dart';

import '../utils/images.dart';
import '../utils/sizes.dart';

class CommentryOvers extends StatefulWidget {
  final String matchId;
  final String teamId;
  const CommentryOvers(this.matchId,this.teamId, {super.key});

  @override
  State<CommentryOvers> createState() => _CommentryOversState();
}

class _CommentryOversState extends State<CommentryOvers> {
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
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, _) {
          return Padding(
            padding: EdgeInsets.only(right: 2.w,bottom: 1.h),
          );
        },
        itemCount: commentaryOversModel!.data!.length,
        itemBuilder: (BuildContext context, int index) {
          final option=commentaryOversModel!.data![index];
          return  Column(
            children: [
              Row(
                children: [
                  Text('Over ${option.overNumber}',style: fontMedium.copyWith(
                    fontSize: 13.sp,
                    color: Color(0xff666666),
                  ),),
                  SizedBox(width: 3.w,),
                  Expanded(
                    child: SizedBox(
                      height: 4.h,
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
                            return ScoreContainer( runsScored: '${item.runsScored??'0'}');
                          }),
                    ),
                  ),
                  SizedBox(width: 3.w,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('=',
                        style: fontRegular.copyWith(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                      Text('${option.overRun}' ?? 'N/A',
                        style: fontRegular.copyWith(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
              SizedBox(height: 1.h,),
              const DottedLine(
                dashColor: Color(0xffD2D2D2),
              ),
            ],
          );
        },

      ),
    );
  }
}


class ScoreContainer extends StatelessWidget {
  final String runsScored;

  ScoreContainer({required this.runsScored});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    if (runsScored == '6') {
      bgColor = const Color(0xff1A134C);
      textColor=Colors.white;
    } else if (runsScored == '4') {
      bgColor = const Color(0xff6654EB);
      textColor=Colors.white;
    } else if (runsScored == '0') {
      bgColor = const Color(0xffFF0000);
      textColor=Colors.white;
    } else {
      bgColor = const Color(0xffDADADA);
      textColor=Colors.black;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Color(0xffDADADA)),
        color: bgColor, // Use the determined background color
      ),
      child: Center(
        child: Text(
          runsScored,
          style: fontMedium.copyWith(
            fontSize: 11.sp,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
