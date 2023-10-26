import 'package:flutter/material.dart';
import 'package:scorer/commentaryscreens/teamone_playing_list.dart';
import 'package:scorer/commentaryscreens/teamtwo_list.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/sizes.dart';


class PlayingElevenListScreen extends StatefulWidget {
  const PlayingElevenListScreen({super.key});

  @override
  State<PlayingElevenListScreen> createState() => _PlayingElevenListScreenState();
}

class _PlayingElevenListScreenState extends State<PlayingElevenListScreen>with SingleTickerProviderStateMixin {
  late TabController tabController;
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
           Padding(
             padding:  EdgeInsets.symmetric(horizontal: 4.w),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 GestureDetector(
                     onTap: (){
                       Navigator.pop(context);
                     },
                     child: Icon(Icons.arrow_back,size: 7.w,)),
                 Text("Playing XI",style: fontMedium.copyWith(
                   fontSize: 17.sp,
                   color: AppColor.blackColour,
                 ),),
                 SizedBox(width: 7.w,),
               ],
             ),
           ),
            SizedBox(height: 2.h,),
            TabBar(
              unselectedLabelColor: AppColor.unselectedTabColor,
              labelColor:  Color(0xffD78108),
              indicatorColor: Color(0xffD78108),
              isScrollable: true,
              controller: tabController,
              indicatorWeight: 4.0, // Set the indicator weight
              tabs: [
                Text('Dhoni CC',style: fontRegular.copyWith(fontSize: 14.sp,),),
                Text('Spartans',style: fontRegular.copyWith(fontSize: 14.sp,),),
              ],
            ),
            Divider(),
            Expanded(
              child: TabBarView(
                  controller: tabController,
                  children: [
                    TeamOnePlayingList(),
                    TeamTwoList(),
                  ]
              ),
            ),

          ],
        ),
      ),
    );
  }
}
