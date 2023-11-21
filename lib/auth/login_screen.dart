

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../utils/styles.dart';
import '../provider/auth_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../widgets/custom_button.dart';
import '../widgets/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isNumeric(String value) {
    if (value.isEmpty) {
      // Handle empty input (optional)
      return false;
    }
    return double.tryParse(value) != null;
  }

  clearData() async {
    await Future.delayed(const Duration(seconds: 2));
    if(mounted){
      // Provider.of<NavigationProvider>(context, listen: false).resetEverything();
      // Provider.of<TeamProvider>(context, listen: false).clearData();
      // Provider.of<ProfileProvider>(context, listen: false).resetEverything();
      // Provider.of<RoleProvider>(context, listen: false).resetEverything();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clearData();
  }

  @override
  Widget build(BuildContext context) {
    // var connectionStatus = Provider.of<ConnectivityStatus>(context);
    // if (connectionStatus == ConnectivityStatus.offline) {
    //   return const NoInternetView();
    // }
    return WillPopScope(
      onWillPop: () {
        return openExitSheet();
      },

      child: Scaffold(
            backgroundColor:  AppColor.bgColor ,
            body: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(Images.authCurveImg, width: 100.w,),
                        Positioned(
                          child: SvgPicture.asset(
                            Images.loginTopImg, width: 100.w,),
                        ),
                        Positioned(
                          child: Column(
                            children: [
                              Text("Greetings Captain",
                                style: fontBold.copyWith(
                                    fontSize: 20.sp,
                                    color: AppColor.textColor
                                ),),
                              SizedBox(height: 1.h),
                              Text("Let's cricket together",
                                style: fontRegular.copyWith(
                                    fontSize: 11.sp,
                                    color: AppColor.textColor
                                ),),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 5.w,
                          bottom: 4.h,
                          child: Text("Login",
                            style: fontBold.copyWith(
                                fontSize: 20.sp,
                                color: AppColor.textColor
                            ),),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.w
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //const  TextFieldTitleText("Mobile Number *"),
                          SizedBox(height: 1.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 1.5.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.lightColor,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Center(
                              child: TextFormField(
                                onTapOutside: (event){
                                  FocusScope.of(context).requestFocus(FocusNode());
                                },
                                controller: mobileController,
                                cursorColor: AppColor.secondaryColor,
                                autofillHints: const <String>[AutofillHints.telephoneNumberNational],
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter mobile number';
                                  } else if (value.length < 10) {
                                    return 'Mobile Number must be 10 digit';
                                  }
                                  return null;
                                },
                                style: fontRegular.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColor.textColor
                                ),
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: "Enter mobile number",
                                  hintStyle: fontRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.textMildColor
                                  ),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    if(loading)...[
                      const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      )
                    ] else
                      ...[
                        Bounceable(
                            onTap: () {
                              // validate();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: const CustomButton(AppColor.primaryColor,
                                  "Log in", AppColor.textColor),
                            )),
                      ],
                    SizedBox(height: 3.h),
                    Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'Don\'t have an Account? ',
                            style: fontRegular.copyWith(
                              color: AppColor.textColor ,
                              fontSize: 11.sp,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: ' Sign Up',
                                  style: fontMedium.copyWith(
                                    color: AppColor.redColor,
                                    fontSize: 11.sp,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, 'register_screen');
                                    }
                              )
                            ]
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                  ],
                ),
              ),
            ),
          ));

  }

  // void validate() {
  //   if (_formKey.currentState!.validate()) {
  //
  //     setState(() {
  //       loading = true;
  //     });
  //     AuthProvider().loginSubmit(mobileController.text, context)
  //         .then((value) async {
  //       if (value.status == true) {
  //         print(value.message.toString());
  //         SharedPreferences preferences = await SharedPreferences.getInstance();
  //         preferences.setString("user_temp_id", value.loginData!.userId.toString());
  //         preferences.setString("mobile", mobileController.text);
  //         preferences.setString("otp", value.loginData!.otp.toString());
  //         preferences.setBool("isLoginScreen", true);
  //         if (mounted) {
  //           Navigator.push(context, ScaleRoute(page: EnterOtpScreen(
  //               true, false, value.loginData!.otp.toString(),
  //               value.loginData!.userId.toString(), mobileController.text, false)));
  //         }
  //         setState(() {
  //           loading = false;
  //         });
  //       } else if (value.status == false) {
  //         print(value.message.toString());
  //         Dialogs.snackbar(value.message.toString(), context, isError: true);
  //         setState(() {
  //           loading = false;
  //         });
  //       } else {
  //         setState(() {
  //           loading = false;
  //         });
  //       }
  //     });
  //   }
  // }
  //
  openExitSheet() {
    return showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: false,
        builder: (BuildContext context) {
        //  return const ExitAppSheet();
          return  Container();
        });
  }

}

