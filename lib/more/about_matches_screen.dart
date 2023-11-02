import 'package:flutter/material.dart';
import 'package:scorer/models/matches/umpire_matches_model.dart';
import 'package:scorer/provider/match_provider.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/sizes.dart';
import '../widgets/Individual_player_completed_list.dart';

class AboutMatchesScreen extends StatefulWidget {
  const AboutMatchesScreen({super.key});

  @override
  State<AboutMatchesScreen> createState() => _AboutMatchesScreenState();
}

class _AboutMatchesScreenState extends State<AboutMatchesScreen> {
  final List<Map<String,dynamic>>itemList=[
    {},{},{},{},{},{},{},{},{},{},{},{},
  ];
  UmpireMatchesModel? umpireMatchesModel;
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  fetchData(){
    MatchProvider().getScorerMatches('46').then((value){
      setState(() {
        umpireMatchesModel=value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    if(umpireMatchesModel==null||umpireMatchesModel!.data==null){
      return const SizedBox(height: 100,width: 100,
          child: Center(child: CircularProgressIndicator(),));
    }
    return  Container(
        padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
            color: AppColor.lightColor
        ),
        child: Column(
          children: [
            Container(
              height: 10.h,
              width: double.maxFinite,
              color: AppColor.pri,
            ),
            SizedBox(height: 2.h,),
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true, // Remove top system padding (status bar)
                removeBottom: true,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, _) {
                      return Padding(
                        padding: EdgeInsets.only(right: 2.w,bottom: 1.h),
                      );
                    },
                    itemCount:umpireMatchesModel!.data!.matches!.length ,
                    itemBuilder: (context, int index) {
                      final item = umpireMatchesModel!.data!.matches![index];
                      return IndividualPlayerCompletedMatches(item);
                    }),
              ),
            ),
          ],
        )
    );
  }
}
