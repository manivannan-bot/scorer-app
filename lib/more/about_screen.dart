import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import 'about_detail_screen.dart';
import 'about_matches_screen.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>with SingleTickerProviderStateMixin {
  late TabController tabController;
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  Color color = Colors.white.withOpacity(0.2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(Images.playerDetailBg,),
              SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,size: 7.w,color: AppColor.lightColor,)),
                    Column(
                      children: [
                        Image.asset(Images.playersImage,width: 30.w,),
                        Text('Murugaprasanth',
                          style: fontMedium.copyWith(fontSize: 15.sp,color: AppColor.lightColor),),
                      ],
                    ),
                    SizedBox(width: 7.w,),
                  ],
                ),
              ),
              SizedBox(height: 0.5.h,),
            ],
          ),
          SizedBox(height: 1.h,),
          TabBar(
            unselectedLabelColor: AppColor.unselectedTabColor,
            labelColor:  Color(0xffD78108),
            indicatorColor: Color(0xffD78108),
            isScrollable: true,
            controller: tabController,
            indicatorWeight: 4.0,
            indicatorPadding: EdgeInsets.zero,// Set the indicator weight
            tabs: [
              Text('About',style: fontMedium.copyWith(fontSize: 14.sp,),),
              Text('Matches',style: fontMedium.copyWith(fontSize: 14.sp,),),

            ],
          ),
          Divider(),
          Expanded(
            child: TabBarView(
                controller: tabController,
                children: [
                  AboutDetailScreen(),
                  AboutMatchesScreen(),
                ]
            ),
          ),
        ],
      ),
    );
  }
}
