import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:scorer/models/players/player_info_model.dart';
import 'package:scorer/provider/player_details_provider.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/sizes.dart';

class PlayerInfoScreen extends StatefulWidget {
  final String playerId;
  const PlayerInfoScreen(this.playerId, {super.key});

  @override
  State<PlayerInfoScreen> createState() => _PlayerInfoScreenState();
}

class _PlayerInfoScreenState extends State<PlayerInfoScreen> {
  PlayerInfoModel? playerInfoModel;
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  fetchData(){
    PlayerDetailsProvider().getPlayerInfo('3').then((value) {
      setState(() {
        playerInfoModel=value;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    if(playerInfoModel==null){
      return const SizedBox(
          height: 100,
          width: 100,
          child: Center(child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          )));
    }
    if(playerInfoModel!.data!.userDetails==null){
      return const Center(child: Text('No data found'),);
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
              width: double.infinity,
              height: 70.h,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                  color: AppColor.lightColor
              ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text("Player Information",style: fontMedium.copyWith(
                 fontSize: 14.sp,
                 color: AppColor.blackColour,
               ),),
               SizedBox(height: 2.h,),
               Container(
                 padding: EdgeInsets.symmetric(
                   horizontal: 0.w,
                   vertical: 1.h,
                 ),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                   color: const Color(0xffF8F9FA),
                 ),
                 child: Column(
                   children: [
                     _buildRow("Name", "${playerInfoModel!.data!.userDetails!.name??'-'}"),
                     _buildDivider(),
                     _buildRow("Role", "${playerInfoModel!.data!.userDetails!.battingRole==1?'Batting':'Bowling'}"),
                     _buildDivider(),
                     _buildRow("Batting Style", "${playerInfoModel!.data!.userDetails!.battingStyle??'-'}"),
                     _buildDivider(),
                     _buildRow("Batting Order", "${playerInfoModel!.data!.userDetails!.battingOrder??'-'}"),
                     _buildDivider(),
                     _buildRow("Bowling action", "${playerInfoModel!.data!.userDetails!.bowlingAction??'-'}"),
                     _buildDivider(),
                     _buildRow("Bowling Style", "${playerInfoModel!.data!.userDetails!.bowlingStyle??'-'}"),
                     _buildDivider(),
                     _buildRow("Bowling Proficiency", "${playerInfoModel!.data!.userDetails!.bowlingProficiency??'-'}"),
                     _buildDivider(),
                     _buildRow("Date of Birth", "${playerInfoModel!.data!.userDetails!.dob??'-'}"),
                     _buildDivider(),
                     _buildRow("Location", "${playerInfoModel!.data!.userDetails!.location??'-'}"),

                   ],

                 ),
               ),
             ],
           ),
            ),
          ],
        ),
      ),

    );
  }
  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
          child: Text(
            label,
            style: fontRegular.copyWith(fontSize: 12.sp, color: const Color(0xff555555)),
          ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.h),
          child: SizedBox(
            width: 30.w,
            child: Text(
              value,
              style: fontMedium.copyWith(fontSize: 12.sp, color: AppColor.blackColour),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const DottedLine(
      dashColor: Color(0xffD2D2D2),
    );
  }








}
