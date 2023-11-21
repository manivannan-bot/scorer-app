import 'dart:async';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';


import '../../utils/colours.dart';

import '../utils/images.dart';
import '../utils/sizes.dart';
import '../widgets/flutter_otp_field.dart';
import '../widgets/snackbar.dart';

class EnterOtpScreen extends StatefulWidget {
  final bool login, register, fromSplash;
  final String otp, userTempId, mobileNumber;
  const EnterOtpScreen(this.login, this.register, this.otp, this.userTempId, this.mobileNumber, this.fromSplash, {Key? key}) : super(key: key);

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {

  int _seconds = 120;
  Timer? _timer;
  bool loading = false;
  bool enableButton = false;
  String otp = "";
  bool incomplete = true;
  String yourOtp = "";

 // User? user;

  @override
  void initState() {
    super.initState();
    startTimer();
    setOtp(widget.otp);
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer!.cancel();
          onTimerEnd();
        }
      });
    });
  }

  onTimerEnd(){
    print('Timer Ended!');
  }

  setOtp(String otp) async{
    setState(() {
      yourOtp = otp;
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ) + EdgeInsets.only(
                  top: 4.h + statusBarHeight,
                  bottom: 5.h
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.fromSplash
                    ? const SizedBox()
                    : InkWell(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, color: AppColor.textColor, size: 7.w,)),

                    Text(widget.login ? "Enter your OTP" : "Verify your mobile number",
                    style: fontSemiBold.copyWith(
                      color: AppColor.textColor,
                      fontSize: widget.login ? 16.sp : 14.sp
                    ),),

                    widget.fromSplash
                        ? const SizedBox()
                        : Icon(Icons.arrow_back_ios_outlined, color: Colors.transparent, size: 7.w,),
                  ],
                ),
              ),
              Center(
                child: SvgPicture.asset(Images.otpImage, width: 36.w,),
              ),
              SizedBox(height: 3.h),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                ),
                child: Text("Please enter the 4 digit code sent to ${widget.mobileNumber}",
                  textAlign: TextAlign.center,
                  style: fontRegular.copyWith(
                      color: AppColor.textColor,
                      fontSize: 12.sp
                  ),),
              ),
              SizedBox(height: 3.h),
              OtpTextField(
                keyboardType: TextInputType.number,
                showFieldAsBox: true,
                textStyle: fontMedium.copyWith(
                  color: AppColor.textColor,
                  fontSize: 14.sp
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                showCursor: true,
                cursorColor: AppColor.textColor,
                numberOfFields: 4,
                fillColor: AppColor.lightColor,
                filled: true,
                borderColor: Colors.transparent,
                margin: EdgeInsets.symmetric(
                  horizontal: 2.w
                ),
                focusedBorderColor: AppColor.primaryColor,
                enabledBorderColor: Colors.transparent,
                fieldWidth: 16.w,
                onSubmit: (value) async {
                  setState((){
                    otp = value;
                  });
                  setState((){
                    incomplete = false;
                  });
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  String? userId = preferences.getString("user_temp_id");
                  print(widget.login);
                  if(widget.login){
                    //verifyLogin(userId);
                  } else if(widget.register){
                   // verifyRegister(userId, otp);
                  }
                },
                onCodeChanged: (value){
                  setState((){
                    otp = value;
                  });
                  if(value.length < 4){
                    setState((){
                      incomplete = true;
                    });
                  } else{
                    setState((){
                      incomplete = false;
                    });
                  }
                },
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              SizedBox(height: 3.h),
              Text(
                "${formatTime(_seconds)} seconds",
                style: fontMedium.copyWith(
                  color: AppColor.textColor,
                    fontSize: 11.sp),
              ),
              SizedBox(height: 3.h),
              _seconds > 0 ? const SizedBox() : RichText(
                text: TextSpan(
                    text: 'Didn\'t receive code? ',
                    style: fontRegular.copyWith(
                      color: AppColor.textColor,
                      fontSize: 11.sp,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: ' Resend',
                          style: fontSemiBold.copyWith(
                            color: _seconds > 0 ? AppColor.textMildColor : AppColor.textColor,
                            fontSize: 11.sp,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if(_seconds > 0){

                              } else {
                               // resendOtp(widget.userTempId);
                              }
                            }
                      )
                    ]
                ),
              ),
              // SizedBox(height: 5.h),
              // if(loading)...[
              //   const Center(
              //     child: CircularProgressIndicator(
              //       color: AppColor.primaryColor,
              //     ),
              //   )
              // ]
              // else...[
              //   incomplete
              //       ? Padding(
              //     padding: EdgeInsets.symmetric(
              //       horizontal: 5.w,
              //     ),
              //         child: CustomButton(AppColor.hintColour.withOpacity(0.2), "Verify", AppColor.textColor),
              //       )
              //       : Padding(
              //     padding: EdgeInsets.symmetric(
              //       horizontal: 5.w,
              //     ),
              //     child: Bounceable(
              //         onTap: () async {
              //           SharedPreferences preferences = await SharedPreferences.getInstance();
              //           String? userId = preferences.getString("user_temp_id");
              //           print(widget.login);
              //           if(widget.login){
              //             verifyLogin(userId);
              //           } else if(widget.register){
              //             verifyRegister(userId, otp);
              //           }
              //         },
              //         child: const CustomButton(AppColor.primaryColor, "Verify", AppColor.textColor)),
              //   ),
              // ],
              // SizedBox(height: 20.h),
              // Text(widget.otp,
              //   style: fontSemiBold.copyWith(
              //       color: AppColor.textColor,
              //       fontSize: widget.login ? 20.sp : 20.sp
              //   ),),
            ],
          ),
        ),
      ),
    );
  }

  // resendOtp(String id){
  //   if(widget.login){
  //     AuthProvider().resendOtpLogin(id)
  //         .then((value) {
  //       if(value.status == true){
  //         Dialogs.snackbar(value.message.toString(), context, isError: false);
  //         setOtp(value.otp.toString());
  //         setState(() {
  //           _seconds = 120;
  //         });
  //         startTimer();
  //       } else if(value.status == false){
  //         Dialogs.snackbar(value.message.toString(), context, isError: true);
  //       } else {
  //         Dialogs.snackbar(value.message.toString(), context, isError: true);
  //       }
  //     });
  //   }
  //   else if(widget.register){
  //     AuthProvider().resendOtpRegister(id)
  //         .then((value) {
  //       if(value.status == true){
  //         Dialogs.snackbar(value.message.toString(), context, isError: false);
  //         setOtp(value.otp.toString());
  //         setState(() {
  //           _seconds = 120;
  //         });
  //         startTimer();
  //       } else if(value.status == false){
  //         Dialogs.snackbar(value.message.toString(), context, isError: true);
  //       } else {
  //         Dialogs.snackbar(value.message.toString(), context, isError: true);
  //       }
  //     });
  //   }
  // }


  // verifyLogin(String? userId) async {
  //   print(otp);
  //   if(otp == ""){
  //     Dialogs.snackbar("Enter the OTP", context, isError: true);
  //   } else{
  //     setState(() {
  //       loading = true;
  //     });
  //     AuthProvider().loginOtpCheck(otp, userId.toString())
  //         .then((value) async {
  //       if(value.status == true){
  //         Dialogs.snackbar(value.message.toString(), context, isError: false);
  //         Navigator.pushNamed(context, 'menu_screen');
  //         SharedPreferences preferences = await SharedPreferences.getInstance();
  //         preferences.setBool("in_address" , false);
  //         setState(() {
  //           loading = false;
  //         });
  //       } else if(value.status == false){
  //         print("login false");
  //         Dialogs.snackbar(value.message.toString(), context, isError: true);
  //         setState(() {
  //           loading = false;
  //         });
  //       } else{
  //         Dialogs.snackbar("Something went wrong. Please try again.", context, isError: true);
  //         setState(() {
  //           loading = false;
  //         });
  //       }
  //     });
  //   }
  // }

  // verifyRegister(String? userId, String otp) async {
  //   if(otp == ""){
  //     Dialogs.snackbar("Enter the OTP", context, isError: true);
  //   } else{
  //     setState(() {
  //       loading = true;
  //     });
  //     AuthProvider().registerOtpCheck(otp, userId.toString())
  //         .then((value) async {
  //           if(value.status == true){
  //             Dialogs.snackbar(value.message.toString(), context, isError: false);
  //             ProfileProvider().getCaptainProfile(context)
  //             .then((value) async {
  //               if(value.status == true && value.user?.pinCode.toString() == ""){
  //                 SharedPreferences preferences = await SharedPreferences.getInstance();
  //                 preferences.setBool("in_address" , true);
  //                 if(mounted){
  //                   Navigator.push(context, ScaleRoute(page: AddAddress(true, false, user)));
  //                 }
  //               } else if(value.status == true && value.user?.pinCode.toString() != ""){
  //                 Navigator.push(context, ScaleRoute(page: const MenuScreen()));
  //               }
  //             });
  //
  //             setState(() {
  //               loading = false;
  //             });
  //           } else if(value.status == false){
  //             print("register false");
  //             Dialogs.snackbar(value.message.toString(), context, isError: true);
  //             setState(() {
  //               loading = false;
  //             });
  //           } else{
  //             Dialogs.snackbar("Something went wrong. Please try again.", context, isError: true);
  //             setState(() {
  //               loading = false;
  //             });
  //           }
  //     });
  //   }
  // }

  openExitSheet() {
    var platform = Theme.of(context).platform;
    return showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        builder: (BuildContext context) {
          return Padding(
            padding: platform == TargetPlatform.iOS
                ? EdgeInsets.symmetric(
                vertical: 5.h,
                horizontal: 2.w)
                : EdgeInsets.symmetric(
                vertical: 1.h,
                horizontal: 2.w),
            child: Container(
                height: 22.h,
                padding: EdgeInsets.symmetric(
                    vertical: 2.h,
                    horizontal: 5.w),
                decoration: BoxDecoration(
                  color: AppColor.lightColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Verify OTP",
                      style: fontSemiBold.copyWith(
                          color: AppColor.textColor,
                          fontSize: 14.sp),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Would you still want to close the app?",
                      style: fontRegular.copyWith(
                          color: AppColor.textMildColor,
                          fontSize: 12.sp),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        //don't close the app
                        Expanded(
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.secondaryColor, width: 0.5),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                      1.5.h),
                                  child: Text(
                                    "No",
                                    style: fontMedium.copyWith(
                                      color: AppColor.secondaryColor,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        //close the app
                        Expanded(
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: () async {
                              exit(0);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.secondaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                      1.5.h),
                                  child: Text(
                                    "Yes",
                                    style: fontMedium.copyWith(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          );
        });
  }
}
