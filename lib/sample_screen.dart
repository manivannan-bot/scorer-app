import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/utils/colours.dart';
import 'package:scorer/utils/sizes.dart';
import 'package:sizer/sizer.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 10.h
        ),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff454545),
                      Color(0xff8C8C8C),
                    ],
                  ),
                borderRadius: BorderRadius.circular(15.0)
              ),
              child: Stack(
                children: [
                  SvgPicture.asset("assets/images/bowling_spell_img.svg", fit: BoxFit.cover, width: 90.w,),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 7.w,
                      vertical: 0.8.h
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25.0),
                        topLeft: Radius.circular(15.0),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.primaryColor,
                          AppColor.secondaryColor,
                        ],
                      ),
                    ),
                    child: Text("New Bowling Spell",
                    style: fontRegular.copyWith(
                      color: AppColor.textColor,
                      fontSize: 11.sp
                    ),),
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
