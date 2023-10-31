import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scorer/utils/colours.dart';
import 'package:sizer/sizer.dart';

import '../utils/images.dart';
import '../utils/sizes.dart';

class CommentryOvers extends StatefulWidget {
  const CommentryOvers({super.key});

  @override
  State<CommentryOvers> createState() => _CommentryOversState();
}

class _CommentryOversState extends State<CommentryOvers> {
  final List<Map<String,dynamic>>itemList=[
    {},{},{},{},{},{},{},{},{},{},{},{},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, _) {
          return Padding(
            padding: EdgeInsets.only(right: 2.w,bottom: 1.h),
          );
        },
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return  Column(
            children: [
              Row(
                children: [
                  Text('Over 9',style: fontMedium.copyWith(
                    fontSize: 13.sp,
                    color: Color(0xff666666),
                  ),),
                   SizedBox(width: 3.w,),
                   Expanded(
                     child: SizedBox(
                       height: 4.h,
                       child: ListView.separated(
                         scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, _) {
                        return Padding(
                          padding: EdgeInsets.only(right: 2.w,bottom: 0.h),
                        );
                  },
                  itemCount:itemList.length ,
                  itemBuilder: (context, int index) {
                        final item = itemList[index];
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 2.5.w,vertical: 0.5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Color(0xffDADADA)),
                            color: Color(0xffFBFAF7),
                          ),
                          child: Center(
                            child: Text('2nb',style: fontMedium.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.blackColour,
                            ),),
                          ),
                        );
                  }),
                     ),
                   ),
                  SizedBox(width: 3.w,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('=',
                        style: fontRegular.copyWith(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                      Text('15' ?? 'N/A',
                        style: fontRegular.copyWith(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
              SizedBox(height: 1.h,),
              DottedLine(
                dashColor: Color(0xffD2D2D2),
              ),
            ],
          );
        },

      ),
    );
  }
}
