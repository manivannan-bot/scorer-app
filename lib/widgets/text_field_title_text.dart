import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/styles.dart';

class TextFieldTitleText extends StatelessWidget {
  final String title;
  const TextFieldTitleText(this.title, {super.key});

  @override
  Widget build(BuildContext context) {

        return Text(title,
          style: fontRegular.copyWith(
              fontSize: 10.sp,
              color: AppColor.textColor
          ),);

  }
}
