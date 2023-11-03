import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/models/teams/team_players_model.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class TeamsBowlerListScreen extends StatefulWidget {
  final List<Bowler>? bowler;
  const TeamsBowlerListScreen(this.bowler,  {super.key});

  @override
  State<TeamsBowlerListScreen> createState() => _TeamsBowlerListScreenState();
}

class _TeamsBowlerListScreenState extends State<TeamsBowlerListScreen> {
  List<Map<String,dynamic>> itemLists=[
    {
      "image":'assets/images/req_list.png',
      "name":"Akash",
      "team":"(Toss and Tails)",
      "dot":".",
      "batsman":"Right hand batsman",
      "button":"Connect",
    },{},{},{},{},{},{},{},{},{},{},{},


  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 4.w),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true, // Remove top system padding (status bar)
        removeBottom: true,
        child: ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, _) {
              return Padding(
                padding: EdgeInsets.only(bottom: 0.h),
                child: const Divider(
                  color: Color(0xffD3D3D3),
                ),
              );
            },
            itemCount: widget.bowler!.length,
            itemBuilder: (context, int index) {
              final item =  widget.bowler![index];
              return   Padding(
                padding:  EdgeInsets.only(top: 0.5.h,bottom: 0.8.h),
                child: Row(
                  children: [
                    ClipOval(child: Image.asset(Images.profileImage,width: 14.w,)),
                    SizedBox(width: 5.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 60.w,
                          child: Text('${item.playerName}',style: fontMedium.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackColour,
                          ),),
                        ),
                        SizedBox(height: 0.5.h,),
                        (item.battingStyle!=null)?Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: AppColor.pri,
                              radius: 4,
                            ),
                            SizedBox(width: 1.w,),
                            Text("${item.battingStyle}",style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: Color(0xff555555),
                            ),),
                          ],
                        ):const Text(''),
                      ],),
                    Spacer(),
                    SvgPicture.asset(Images.arrowICon,width: 6.5.w,),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
