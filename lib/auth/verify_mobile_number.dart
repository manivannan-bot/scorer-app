import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/flutter_otp_field.dart';


class VerifyMobileNumber extends StatefulWidget {
  const VerifyMobileNumber({Key? key}) : super(key: key);

  @override
  State<VerifyMobileNumber> createState() => _VerifyMobileNumberState();
}

class _VerifyMobileNumberState extends State<VerifyMobileNumber> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 5.w
              ) + EdgeInsets.only(
                  top: 5.h, bottom: 3.h
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap:(){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back, color: AppColor.textColor, size: 7.w,)),
                  Text("Verify your Mobile number",
                    style: fontMedium.copyWith(
                        fontSize: 16.sp,
                        color: AppColor.textColor
                    ),),
                  SizedBox(width: 7.w,),
                ],
              ),
            ),
            SizedBox(height: 3.h),
            SvgPicture.asset(Images.verifyMobileImage, width: 30.w,),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 5.h
              ),
              child: Text("Please enter your 4 digit code sent to 9865325487",
                textAlign: TextAlign.center,
                style: fontMedium.copyWith(
                    fontSize: 12.sp,
                    color: AppColor.textColor
                ),),
            ),
            OtpTextField(
              fieldWidth: 15.w,
              numberOfFields: 4,
              borderRadius: BorderRadius.circular(10.0),
              borderColor: const Color(0xFFC5BEBE),
              focusedBorderColor: AppColor.primaryColor,
              cursorColor: AppColor.textColor,
              showFieldAsBox: true,
              onCodeChanged: (String code) {
              },
              onSubmit: (String verificationCode){
              }, // end onSubmit
            ),
            SizedBox(height: 4.h),
            RichText(
              text: TextSpan(
                  text: 'Don\'t receive code? ',
                  style: fontRegular.copyWith(
                    color: AppColor.textColor,
                    fontSize: 11.sp,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: ' Re-send',
                        style: fontBold.copyWith(
                          color: AppColor.textColor,
                          fontSize: 11.sp,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                          }
                    )
                  ]
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 4.h,
              ),
              child: Bounceable(
                  onTap: (){
                    Navigator.pushNamed(context, "set_new_password");
                  },
                  child: const CustomButton(AppColor.primaryColor, 'Send', AppColor.textColor)),
            ),
          ],
        ),
      ),
    );
  }
}
