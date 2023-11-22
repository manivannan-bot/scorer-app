import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scorer/models/get_live_score_model.dart';
import 'package:scorer/utils/colours.dart';
import 'package:scorer/utils/sizes.dart';
import 'package:scorer/view/scoring_tab.dart';
import 'package:scorer/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../Scoring screens/home_screen.dart';
import '../commentaryscreens/commentary_screen.dart';
import '../commentaryscreens/info_screen.dart';
import '../provider/score_update_provider.dart';
import '../provider/scoring_provider.dart';
import '../scorecardScreens/scorecard_screen.dart';
import '../utils/images.dart';
import 'new_update_bottom_sheet.dart';

class ScoreUpdateScreen extends StatefulWidget  {
  final String matchId;
  final String team1id, team2id;
  const ScoreUpdateScreen(this.matchId, this.team1id, this.team2id, {super.key});

  @override
  State<ScoreUpdateScreen> createState() => _ScoreUpdateScreenState();
}

class _ScoreUpdateScreenState extends State<ScoreUpdateScreen> with SingleTickerProviderStateMixin{

   late TabController tabController;
   Matches? matchList;
   String currentRunRate = "";
   String requiredRunRate = "";
   RefreshController refreshController = RefreshController();
   int? batTeamId;
   int? bowlTeamId;
   int currentInning=1;
   bool loading = false;
   String currentOverData = "";
   String? target;

   setDelay() async{
     if(mounted){
       setState(() {
         loading = true;
       });
     }
     await Future.delayed(const Duration(seconds: 1));
     if(mounted){
       setState(() {
         loading = false;
       });
     }
   }

   @override
  void initState() {
     matchList=null;
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    fetchData();
    // checkForUpdate();
  }

  checkForUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    debugPrint(appName);
    debugPrint(packageName);
    debugPrint(version);
    debugPrint(buildNumber);
    FirebaseFirestore fireStore = FirebaseFirestore.instance;

    // Get the reference to the "version" collection and document "1"
    DocumentReference docRef = fireStore.collection('version').doc('1');

    // Fetch the document
    DocumentSnapshot snapshot = await docRef.get();

    String versionName = "";
    String versionNumber = "";
    String versionReleaseNotes = "";
    bool versionPriority = false;
    String versionType = "";

    if (snapshot.exists) {
      // Access the data in the snapshot
      versionName = snapshot['version_name'].toString();
      versionNumber = snapshot['version'].toString();
      versionReleaseNotes = snapshot['release_notes'].toString();
      versionPriority = snapshot['priority'];
      versionType = snapshot['type'].toString();

      // Print or use the retrieved data
      debugPrint('Version Name: $versionName');
      debugPrint('Version number: $versionNumber');
      debugPrint('Release Notes: $versionReleaseNotes');
      debugPrint('Release priority: $versionPriority');
      debugPrint('Release type: $versionType');
    } else {
      debugPrint('Document does not exist');
    }

    int versionCheck = compareVersions(version, versionNumber.toString());
    if(versionCheck == -1){
      showUpdateBottomSheet(versionName, versionReleaseNotes, versionPriority, versionType, versionNumber);
      // Dialogs.snackBar("Please update your app", context);
    } else if(versionCheck == 1){
      Dialogs.snackBar("You are already upto date", context);
      debugPrint("You are already up to date");
    }
  }

   // Function to compare version strings
   int compareVersions(String version1, String version2) {
     List<String> v1 = version1.split('.');
     List<String> v2 = version2.split('.');

     int length = v1.length > v2.length ? v1.length : v2.length;

     for (int i = 0; i < length; i++) {
       int num1 = i < v1.length ? int.parse(v1[i]) : 0;
       int num2 = i < v2.length ? int.parse(v2[i]) : 0;

       if (num1 < num2) {
         return -1; // Version 1 is less than version 2
       } else if (num1 > num2) {
         return 1; // Version 1 is greater than version 2
       }
     }

     return 0; // Versions are equal
   }

   Future<void> fetchData() async {
     final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
     SharedPreferences prefs = await SharedPreferences.getInstance();
     //setting batting and bowling team id's
     WidgetsBinding.instance.addPostFrameCallback((_) {
       setState(() {
         batTeamId = int.parse(widget.team1id);
         bowlTeamId = int.parse(widget.team2id);
       });
     });
     debugPrint("team1 id ${widget.team1id} team 2 id ${widget.team2id}");
     //getting live score
     await ScoringProvider().getLiveScore(widget.matchId, widget.team1id).then((data) async{
       //setting match list
     setState(() {
       matchList = data.matches;
       currentInning=data.matches!.currentInnings!;
       target = data.target.toString();
       currentOverData = data.matches!.teams!.currentOverDetails.toString();
       currentRunRate = data.runRate!.currentRunRate.toString();
       requiredRunRate = data.runRate!.reqRunRate.toString();
     });
     int overNumber = 0;
     int ballNumber = 0;

     if(score.overNumberInnings != 0 || score.ballNumberInnings != 0){
       debugPrint("crossed 0th over - ON ${score.overNumberInnings} BN ${score.ballNumberInnings}");
       debugPrint("getting the over number and ball number from previous score update response for next ball");
       overNumber = score.overNumberInnings;
       ballNumber = score.ballNumberInnings;
     } else {
       debugPrint("0th over of the innings - over number and ball number are 0");
       debugPrint("getting the over number and ball number from getlive score api - ON $overNumber BN $ballNumber");
       overNumber = data.matches!.teams!.overNumber ?? 0;
       ballNumber = data.matches!.teams!.ballNumber ?? 0;
     }
     //setting over number and ball number values for next ball
         if (overNumber == 0 && ballNumber == 0) {
           overNumber = 0;
           ballNumber = 1;
           debugPrint("over number and ball number are 0");
         }
     debugPrint("while setting value to provider");
       score.setOverNumber(overNumber);
       score.setBallNumber(ballNumber);
     await prefs.setInt('current_innings',data.matches!.currentInnings??1);

     refreshController.refreshCompleted();
     });
   }

   String calculateRequiredRuns(String target, String currentRuns){
     int requiredRuns = int.parse(target) - int.parse(currentRuns);
     String result = requiredRuns.toString();
     return result;
   }

   String calculateRemainingWickets(String wicketsGone){
     int remWickets = 10 - int.parse(wicketsGone);
     String result = remWickets.toString();
     return result;
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: matchList == null
          ? const Center(child: CircularProgressIndicator(
          ))
      : loading
          ? const Center(child: CircularProgressIndicator(
      )) : SmartRefresher(
        enablePullDown: true,
        onRefresh: fetchData,
        controller: refreshController,
        child: Column(
          children: [
            Stack(
              children: [
                // Background image
                Image.asset(
                  Images.bannerBg,
                  fit: BoxFit.cover, // You can choose how the image should be scaled
                  width: double.infinity,
                   height: 30.h,
                ),
                Positioned(
                  top: 5.h,
                  left: 5.w,
                  right: 5.w,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap:(){
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomeScreen()));
                              },
                              child: Icon(Icons.arrow_back,color: AppColor.lightColor, size: 7.w,)),
                          currentInning == 2
                              ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.8.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColor.lightColor,
                            ),
                            child: Text(
                              'Target: $target',
                              style: fontSemiBold.copyWith(
                                fontSize: 10.sp,
                                color: AppColor.blackColour,
                              ),
                            ),
                          )
                          : Text(
                            'Team',
                            style: fontMedium.copyWith(
                              fontSize: 18.sp,
                              color: AppColor.lightColor
                            )
                          ),
                          SizedBox(
                            width: 7.w,
                          ),
                        ],
                      ),
                       SizedBox(height: 2.h,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                             Image.asset(Images.teamaLogo,width: 20.w,),
                              Text(
                                '${matchList!.team1Name}',
                                style: fontMedium.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColor.lightColor
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                currentInning == 2 ? const SizedBox() : Text(
                                  '${matchList!.tossWinnerName} won the Toss\nand Choose to ${matchList!.choseTo} ',
                                  textAlign: TextAlign.center,
                                  style: fontRegular.copyWith(
                                      fontSize: 11.sp,
                                      color: AppColor.lightColor
                                  )
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('${matchList!.teams!.totalRuns}',
                                        style: fontMedium.copyWith(
                                            fontSize: 22.sp,
                                            color: AppColor.lightColor
                                        )),
                                    Text('/',
                                        style: fontMedium.copyWith(
                                            fontSize: 23.sp,
                                            color: AppColor.lightColor
                                        )),
                                    Text('${matchList!.teams!.totalWickets}',
                                        style: fontMedium.copyWith(
                                            fontSize: 22.sp,
                                            color: AppColor.lightColor
                                        )),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.8.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColor.primaryColor,
                                  ),
                                  child: Text(
                                    'Overs: ${matchList!.teams!.currentOverDetails}/${matchList!.overs}',
                                    style: fontMedium.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.blackColour,
                                    ),
                                  ),
                                ),
                                currentInning == 2
                                    ? Padding(
                                      padding: EdgeInsets.only(top: 2.h),
                                      child: Text("${matchList!.teams!.teamName.toString()} "
                                      "need ${calculateRequiredRuns(target.toString(), matchList!.teams!.totalRuns.toString())} more"
                                      " ${int.parse(calculateRequiredRuns(target.toString(), matchList!.teams!.totalRuns.toString())) > 1 ? "runs" : "run"} to win",
                                  textAlign: TextAlign.center,
                                  style: fontRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.lightColor,
                                  ),),
                                    ) : const SizedBox(),
                                AnimatedTextKit(
                                  pause: const Duration(milliseconds: 1500),
                                  repeatForever: true,
                                  stopPauseOnTap: false,
                                  animatedTexts: [
                                    RotateAnimatedText("Innings ${matchList!.currentInnings??'0'}",
                                      textAlign: TextAlign.center,
                                      duration: const Duration(milliseconds: 2000),
                                      textStyle: fontRegular.copyWith(
                                        fontSize: 11.sp,
                                        color: AppColor.lightColor,
                                      ),),
                                    RotateAnimatedText(currentInning == 2 ? "CRR - $currentRunRate  RRR - $requiredRunRate" : "CRR - $currentRunRate",
                                      textAlign: TextAlign.center,
                                      duration: const Duration(milliseconds: 2000),
                                      textStyle: fontRegular.copyWith(
                                        fontSize: 11.sp,
                                        color: AppColor.lightColor,
                                      ),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Image.asset(Images.teamaLogo,width: 20.w,),
                               Text(
                                   '${matchList!.team2Name}',
                                style:fontMedium.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColor.lightColor)
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h,),
            TabBar(
                unselectedLabelColor: AppColor.unselectedTabColor,
                labelColor:  const Color(0xffD78108),
                indicatorColor: const Color(0xffD78108),
                isScrollable: true,
                indicatorWeight: 2.0,
                 labelPadding: EdgeInsets.symmetric(vertical: 0.4.h, horizontal: 3.5.w),
                indicatorSize: TabBarIndicatorSize.label,
                controller: tabController,
                tabs: [
                  Text('Scoring',style: fontRegular.copyWith(fontSize: 12.sp,),),
                  Text('Scorecard',style: fontRegular.copyWith(fontSize: 12.sp,),),
                  Text('Commentary',style: fontRegular.copyWith(fontSize: 12.sp,),),
                  Text('Info',style: fontRegular.copyWith(fontSize: 12.sp,),),
                ]
            ),
            Theme(
                data: ThemeData(
                  dividerTheme: const DividerThemeData(
                    space: 0,
                    thickness: 0.5,
                    indent: 0,
                    endIndent: 0,
                  ),
                ),
                child: const Divider()),
              Expanded(
                child: TabBarView(
                    controller: tabController,
                    children: [
                      ScoringTab(widget.matchId,batTeamId.toString(),bowlTeamId.toString(), fetchData, currentOverData),
                      ScorecardScreen(widget.matchId,batTeamId.toString(),bowlTeamId.toString(),currentInning.toString(),fetchData),
                      CommentaryScreen(widget.matchId,batTeamId.toString(),bowlTeamId.toString(),fetchData),
                      InfoScreen(widget.matchId),
                    ]),
              )
            ],
          ),
        ),
      );
  }

  showUpdateBottomSheet(String versionHeading, String releaseNotes, bool priority, String type, String versionNumber){
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        builder: (context)=> NewUpdateBottomSheet(versionHeading, releaseNotes, priority, type, versionNumber)
    );
  }
}
