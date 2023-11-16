import 'package:flutter/material.dart';
import 'package:scorer/widgets/snackbar.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/sizes.dart';

class Wicket extends StatefulWidget {
  final bool isOut;
  final String slug, dismissalType;
  const Wicket(this.isOut, this.slug, this.dismissalType, {super.key});

  @override
  State<Wicket> createState() => _WicketState();
}

class _WicketState extends State<Wicket> {

  List<DismissalTypes> chipData = const[
    DismissalTypes(15, "Bowled"),
    DismissalTypes(32, "Caught"),
    DismissalTypes(16, "Stumped"),
    DismissalTypes(17, "LBW"),
    DismissalTypes(18, "Caught Behind"),
    DismissalTypes(19, "Caught & Bowled"),
    DismissalTypes(20, "Run Out"),
    DismissalTypes(21, "Run out (Mankaded)"),
    DismissalTypes(22, "Retired Hurt"),
    DismissalTypes(23, "Hit Wicket"),
    DismissalTypes(24, "Retired"),
    DismissalTypes(25, "Retired Out"),
    DismissalTypes(26, "Handling the Ball"),
    DismissalTypes(27, "Hit the Ball Twice"),
    DismissalTypes(28, "Obstruct the field"),
    DismissalTypes(29, "Absence Hurt"),
    DismissalTypes(30, "Timed Out"),
  ];

  String getDismissalType() {
    print(widget.dismissalType);
    var type = chipData.firstWhere((element) => element.id.toString() == widget.dismissalType);
    return type.label.toString();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(widget.dismissalType == "0"){

        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            width: 50.w,
            backgroundColor: AppColor.primaryColor,
            elevation: 5,
            content: Center(
              child: Text(
                "Dismissal Type - ${getDismissalType()}",
                style: fontMedium.copyWith(color: AppColor.textColor),
              ),
            ),
            duration: const Duration(milliseconds: 1000),
            behavior: SnackBarBehavior.floating,
          ));
        }

      },
      child: Container(
        width: 9.w,
        height: 4.5.h,
        padding: EdgeInsets.symmetric(
          horizontal: 1.w
        ),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: widget.isOut
              ? AppColor.redColor : Colors.black,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: FittedBox(
            child: Text(
              widget.isOut
                  ? "W" : widget.slug,
              style:  fontRegular.copyWith(
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DismissalTypes {
  final String label;
  final int id;

  const DismissalTypes(this.id, this.label);
}
