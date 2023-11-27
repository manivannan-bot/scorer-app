import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorer/view/widgets/stump_image.dart';
import 'package:sizer/sizer.dart';

import '../../provider/score_update_provider.dart';
import '../../utils/colours.dart';
import '../../utils/sizes.dart';

class SetBowlerPosition extends StatelessWidget {
  const SetBowlerPosition({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ScoreUpdateProvider>(
        builder: (context, position, child) {
          debugPrint("bowler position ${position.ow}");
          return Row(
              children:[
                InkWell(onTap:()async{
                  final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
                  score.setBowlerPosition(0, 1, 0);
                },
                  child: Row(children:[
                    StumpImage(position.ow),
                    Padding(padding: EdgeInsets.only(left: 2.w,),
                        child:  Text('OW',
                          style: fontRegular.copyWith(
                              fontSize: 9.sp,
                              color: position.ow == 1 ? AppColor.pri : AppColor.textMildColor),)),
                  ]),
                ),
                SizedBox(width:8.w),
                InkWell(
                  onTap:()async{
                    final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
                    score.setBowlerPosition(1, 0, 1);
                  },
                  child: Row(children:[
                    Padding(padding: EdgeInsets.only(right: 2.w,),
                        child:  Text('RW',
                          style: fontRegular.copyWith(
                              fontSize: 9.sp,
                              color: position.rw == 1 ? AppColor.pri : AppColor.textMildColor),)),
                    StumpImage(position.rw),
                  ]),
                ),
              ]);
        }
    );
  }
}
