import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/models/scoring_detail_response_model.dart';
import 'package:scorer/view/widgets/sixer.dart';
import 'package:scorer/view/widgets/wicket.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/sizes.dart';
import 'boundary.dart';

class CurrentOverData extends StatelessWidget {
  final ScoringDetailResponseModel? scoringData;
  final String currentOverData, currentOverTotal;
  const CurrentOverData(this.scoringData, this.currentOverData, this.currentOverTotal, {super.key});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [
                AppColor.gradient1,
                AppColor.gradient2
              ],
            ),
            borderRadius: BorderRadius.circular(10.0)
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(Images.overCardBg, fit: BoxFit.cover, width: 90.w,),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 3.w, vertical: 1.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Over $currentOverData',
                    style: fontMedium.copyWith(
                      color: Colors.black,
                      fontSize: 12.sp,
                    ),
                  ),
                  (scoringData!.data!.over!.isNotEmpty)
                      ? SizedBox(
                    height: 10.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              children: <Widget>[
                                for (int index = 0; index < scoringData!.data!.over!.length; index++)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      (scoringData!.data!.over![index].extras.toString() == "0" && scoringData!.data!.over![index].runsScored==4
                                          || scoringData!.data!.over![index].extras.toString() == "0" && scoringData!.data!.over![index].runsScored==6)?
                                      (scoringData!.data!.over![index].runsScored==4)
                                          ? const Boundary()
                                          :const Sixer()
                                          : Wicket(
                                          scoringData!.data!.over![index].slug.toString() == "OUT",
                                          scoringData!.data!.over![index].slug.toString(),
                                          scoringData!.data!.over![index].dismissalType.toString()
                                      )
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(' = ',
                                style: fontMedium.copyWith(
                                  color: AppColor.textColor,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Text(currentOverTotal,
                                style: fontMedium.copyWith(
                                  color: AppColor.textColor,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                      : SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
