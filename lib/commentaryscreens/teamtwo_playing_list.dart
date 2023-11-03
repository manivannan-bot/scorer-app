import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../models/matches/match_players_model.dart';
import '../playerdetailsviews/player_detail_view_screen.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class TeamTwoPlayingList extends StatefulWidget {
  final List<PlayersDetails> playersDetails;
  const TeamTwoPlayingList(this.playersDetails,{super.key});

  @override
  State<TeamTwoPlayingList> createState() => _TeamTwoPlayingListState();
}

class _TeamTwoPlayingListState extends State<TeamTwoPlayingList> {
  List<PlayersDetails>? playersCapDetails;
  List<PlayersDetails>? playersList;


  @override
  void initState() {
    super.initState();
    playersCapDetails = widget.playersDetails!.where((player) => player.playerRole!.toLowerCase().toString().contains('captain')).toList();
    playersList = widget.playersDetails!.where((player) => player.playerRole!.toLowerCase().toString().contains('player')).toList();

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 6.w),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
              color: AppColor.lightColor
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Captain',style: fontMedium.copyWith(fontSize: 14.sp,color: AppColor.pri),),
              SizedBox(height: 0.5.h,),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, _) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 0.h),
                      child: Divider(
                        color: Color(0xffD3D3D3),
                      ),
                    );
                  },
                  itemCount: playersCapDetails!.length,
                  itemBuilder: (context, int index) {
                    if(playersCapDetails!.isEmpty){
                      return Text('No Captain Found');
                    }
                    final item = playersCapDetails![index];
                    return   Padding(
                      padding:  EdgeInsets.only(top: 0.5.h,bottom: 0.8.h),
                      child: Row(
                        children: [
                          ClipOval(child: Image.asset(Images.profileImage,width: 14.w,)),
                          SizedBox(width: 5.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${item.playerName}',style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                              SizedBox(height: 0.5.h,),
                              (item.battingStyle!=null)? Row(
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
              Divider(
                color: Color(0xffD3D3D3),
              ),
              Text(' Players',style: fontMedium.copyWith(fontSize: 14.sp,color: AppColor.pri),),
              SizedBox(height: 0.5.h,),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, _) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 0.h),
                      child: Divider(
                        color: Color(0xffD3D3D3),
                      ),
                    );
                  },
                  itemCount: playersList!.length,
                  itemBuilder: (context, int index) {
                    final item = playersList![index];
                    return   Padding(
                      padding:  EdgeInsets.only(top: 0.5.h,bottom: 0.8.h),
                      child: Row(
                        children: [
                          ClipOval(child: Image.asset(Images.profileImage,width: 14.w,)),
                          SizedBox(width: 5.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${item.playerName}',style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                              SizedBox(height: 0.5.h,),
                              (item.battingStyle!=null)? Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: AppColor.pri,
                                    radius: 4,
                                  ),
                                  SizedBox(width: 1.w,),
                                  Text("${item.battingStyle}",style: fontRegular.copyWith(
                                    fontSize: 11.sp,
                                    color: Color(0xff555555),
                                  ),),
                                ],
                              ):const Text('')
                            ],),
                          Spacer(),
                            GestureDetector(
                            onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerDetailViewScreen(item.playerId.toString())));
                            },
                            child:SvgPicture.asset(Images.arrowICon,width: 6.5.w,)),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),

    );
  }
}
