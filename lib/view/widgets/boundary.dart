import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/images.dart';

class Boundary extends StatelessWidget {
  const Boundary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child:  CircleAvatar(
          radius: 4.w, // Adjust the radius as needed for the circle size
          backgroundColor: Colors.white,
          child: Image.asset(Images.four)
      ),
    );
  }
}
