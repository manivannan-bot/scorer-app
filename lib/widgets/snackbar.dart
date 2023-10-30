import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';

class Dialogs {
  static snackBar(String message, context, {bool isLong = false, bool isError = false}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: !isError ? AppColor.textColor : Colors.red,
        textColor: AppColor.lightColor,
        fontSize: 11.sp
    );
  }
}