import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/sizes.dart';

class BatsmanListItem extends StatelessWidget {
  final int? index, localIndex, runsScored, ballsFaced;
  final String? name, style;
  final bool onStrike;
  const BatsmanListItem(this.index, this.localIndex, this.name, this.style, this.runsScored, this.ballsFaced, this.onStrike, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 5.w, vertical: 1.h),
          child: Row(
            children: [
              //circular button
              Container(
                height: 20.0, // Adjust the height as needed
                width: 20.0, // Adjust the width as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: localIndex == index
                      ? AppColor.pri
                      : Colors.grey, // Change colors based on selected index
                ),
                child: const Center(
                  child: Icon(
                    Icons.circle_outlined,
                    color: Colors.white, // Icon color
                    size: 20.0, // Icon size
                  ),
                ),
              ), SizedBox(width: 3.w,),
              Image.network(
                Images.playersImage, width: 10.w,),
              SizedBox(width: 2.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          name?.toUpperCase() ?? '-',
                          style: fontMedium.copyWith(
                            fontSize: 10.sp,
                            color: AppColor.textColor
                          ),),
                        SizedBox(width: 2.w,),
                        onStrike ? SvgPicture.asset(Images.batIcon,
                            color: AppColor.textColor) : const SizedBox()
                      ],
                    ),
                    style.toString() == "" ? const SizedBox() : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 3.5,
                          backgroundColor: onStrike ? AppColor.pri : AppColor.blackColour,
                        ),
                        SizedBox(width: 2.w,),
                        Text(
                          style?.toUpperCase() ?? '-',
                          style: fontMedium.copyWith(
                            fontSize: 8.sp,
                            color: AppColor.textMildColor
                        ),),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(width: 2.w,),
              Text(
                "$runsScored ($ballsFaced)",
                style: fontRegular.copyWith(
                    fontSize: 10.sp,
                    color: AppColor.textMildColor
                ),),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
