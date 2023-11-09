import 'package:flutter/material.dart';

import '../../utils/colours.dart';
import '../../utils/sizes.dart';

class Wicket extends StatelessWidget {
  final bool isOut;
  final String slug;
  const Wicket(this.isOut, this.slug, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: isOut
            ? AppColor.redColor : Colors.black,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          isOut
              ? "W" : slug,
          style:  fontRegular.copyWith(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
