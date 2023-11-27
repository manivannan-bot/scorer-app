import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/commentaryscreens/widgets/ball_result_and_commentary.dart';
import 'package:scorer/commentaryscreens/widgets/end_of_over_card.dart';
import 'package:scorer/commentaryscreens/widgets/new_batsman_card.dart';
import 'package:scorer/commentaryscreens/widgets/new_bowling_spell_card.dart';
import 'package:scorer/commentaryscreens/widgets/new_wicket_card.dart';
import 'package:scorer/commentaryscreens/widgets/over_ball_and_bowler_to_batsman.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class CommentaryAllScreen extends StatefulWidget {
  const CommentaryAllScreen({super.key});

  @override
  State<CommentaryAllScreen> createState() => _CommentaryAllScreenState();
}

class _CommentaryAllScreenState extends State<CommentaryAllScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            const NewBowlingSpellCard("Prasanth", "Right arm fast"),
            SizedBox(height: 1.h,),
            const Divider(
              color: Color(0xffD3D3D3),
            ),
            SizedBox(height: 1.h,),
            const EndOfOverCard(),
            SizedBox(height: 2.h,),
            //ball count design
            SizedBox(height: 1.h,),
            const BallResultAndCommentary("1", "Prasanth to Arunkumar, 6 run, knocked down to long-on"),
            SizedBox(height: 1.h,),
            const DottedLine(
              dashColor: Color(0xffD2D2D2),
            ),
            SizedBox(height: 1.h,),
            const NewBatsmanCard("Vishal", "Right arm bat"),
            SizedBox(height: 1.h,),
            const DottedLine(
              dashColor: Color(0xffD2D2D2),
            ),
            SizedBox(height: 1.h,),
            const NewWicketCard("Pandi", "Prasanth", "23", "7"),
            SizedBox(height: 1.h,),
            const DottedLine(
              dashColor: Color(0xffD2D2D2),
            ),
            SizedBox(height: 1.h,),
            const OverBallAndBowlerToBatsman("6.4", "Prasanth", "Pandi"),
          ],
        ),
      ),
    );
  }
}


