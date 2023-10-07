import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scorer/pages/scoring_tab.dart';
import 'package:scorer/utils/sizes.dart';
import 'package:sizer/sizer.dart';

import '../utils/colors.dart';
import '../utils/images.dart';

class ScoreUpdateScreen extends StatefulWidget  {
  const ScoreUpdateScreen({super.key});

  @override
  State<ScoreUpdateScreen> createState() => _ScoreUpdateScreenState();
}

class _ScoreUpdateScreenState extends State<ScoreUpdateScreen> with SingleTickerProviderStateMixin{
   late TabController tabController;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(

            Images.bannerBg,
            fit: BoxFit.cover, // You can choose how the image should be scaled
            width: double.infinity,
            height: 250,
          ),
          Container(
            child: Column(
              children: [
                Container(height: 40,width: 20,),
                // Arrow and Text
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back,color: Colors.white,),
                      onPressed: () {
                        // Handle arrow back button press here
                      },
                    ),
                    Container(width: 120,),
                    const Center(
                      child: Text(
                        'Team',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24, // Adjust the font size as needed
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Container(width: 20,),
                    Column(
                      children: [
                        Container(
                          width: 80, // Set the desired width
                          height: 80, // Set the desired height
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0, // Adjust the border width as needed
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              Images.csk_team_logo,
                              width: 100, // Match the container's width
                              height: 100, // Match the container's height
                              fit: BoxFit.cover, // Adjust the fit as needed
                            ),
                          ),
                        ),
                        Text(
                          'Csk',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12, // Adjust the font size as needed
                          ),
                        ),
                      ],
                    ),
                    Container(width: 20,),
                    Center(
                      child: Column(
                        children: [

                              Text(
                                'Dhoni CC won the Toss ',
                                style: TextStyle(color: Colors.white),
                              ),
                          Text(
                            'and Choose to bat ',
                            style: TextStyle(color: Colors.white),
                          ),

                          Text('0/0',style: TextStyle(color: Colors.white,fontSize: 24),),
                          ElevatedButton(
                            onPressed: () {
                              // Handle button press here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text(
                              'Overs: 0/10',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),

                          Text('1st Innings',style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                    Container(width: 20,),
                    Column(
                      children: [
                        Container(
                          width: 80, // Set the desired width
                          height: 80, // Set the desired height
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0, // Adjust the border width as needed
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              Images.mi_team_logo,
                              width: 100, // Match the container's width
                              height: 100, // Match the container's height
                              fit: BoxFit.cover, // Adjust the fit as needed
                            ),
                          ),
                        ),
                        const Text(
                          'MI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12, // Adjust the font size as needed
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            Container(height: 50,width: 200,),
                Padding(
                  padding:  EdgeInsets.only(bottom: 2.h,),
                  child: TabBar(
                      labelPadding: EdgeInsets.symmetric(vertical: 0.4.h,horizontal: 3.5.w),
                      labelColor: Colors.orange,
                      unselectedLabelColor: Colors.grey,
                      isScrollable: true,

                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      controller: tabController,
                      tabs: [
                        Text('Scoring',style: fontRegular.copyWith(fontSize: 12.sp,),),
                        Text('Score Card',style: fontRegular.copyWith(fontSize: 12.sp,),),
                        Text('Commentary',style: fontRegular.copyWith(fontSize: 12.sp,),),
                        Text('Info',style: fontRegular.copyWith(fontSize: 12.sp,),),


                      ]
                  ),
                ),
                Expanded(
                  child: TabBarView(
                      controller: tabController,
                      children:  [
                        ScoringTab(),
                        Container(height: 50,width: 50,color: Colors.blue,),
                        Container(height: 50,width: 50,color: Colors.red,),
                        Container(height: 50,width: 50,color: Colors.blue,)
                      ]),
                )


              ],
            ),
          ),





        ],
      ),
    );
  }
}
