import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/sizes.dart';

class PlayerListItem extends StatelessWidget {
  final int? index, localIndex;
  final String? name, style;
  const PlayerListItem(this.index, this.localIndex, this.name, this.style, {super.key});

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
              Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start,
                children: [
                  Text(
                    name?.toUpperCase() ?? '-',
                    style: fontMedium.copyWith(
                      fontSize: 10.sp,
                      color: AppColor.textColor
                    ),),
                  style == null ? const SizedBox() : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 3.5,
                        backgroundColor: AppColor.pri,
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
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
