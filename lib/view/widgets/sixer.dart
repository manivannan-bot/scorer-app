import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/images.dart';

class Sixer extends StatelessWidget {
  const Sixer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.w,
      height: 4.h,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child:  CircleAvatar(
          radius: 4.w, // Adjust the radius as needed for the circle size
          backgroundColor: Colors.white,
          child: Image.asset(Images.six)
      ),
    );
  }
}
