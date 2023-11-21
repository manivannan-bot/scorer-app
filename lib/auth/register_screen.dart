
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import '../provider/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/snackbar.dart';
import '../widgets/text_field_title_text.dart';
import 'enter_otp.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool loading = false;
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController refCodeController = TextEditingController();

  bool isValid = true;
  bool hasValue = false;

  bool isNumeric(String value) {
    if (value.isEmpty) {
      // Handle empty input (optional)
      return false;
    }
    return double.tryParse(value) != null;
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    // var connectionStatus = Provider.of<ConnectivityStatus>(context);
    // if (connectionStatus == ConnectivityStatus.offline) {
    //   return const NoInternetView();
    // }
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
            backgroundColor: AppColor.bgColor,
            body: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                children: [
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _formKey,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(Images.authCurveImg, width: 100.w,),
                              Positioned(
                                child: SvgPicture.asset(Images.loginTopImg, width: 100.w,),
                              ),
                              Positioned(
                                child: Column(
                                  children: [
                                    Text("Create Account",
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
                                child: Text("Sign Up",
                                  style: fontBold.copyWith(
                                      fontSize: 20.sp,
                                      color: AppColor.textColor
                                  ),),
                              ),
                              Positioned(
                                left: 5.w,
                                top: 2.h + statusBarHeight,
                                child: GestureDetector(
                                    onTap:(){
                                      Navigator.pop(context);
                                    },
                                    child: Icon(Icons.arrow_back_rounded, color: AppColor.textColor, size: 7.w,)),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          //name
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextFieldTitleText("Your Name *"),
                                SizedBox(height:1.h),
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
                                      controller: nameController,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(50),
                                      ],
                                      cursorColor: AppColor.secondaryColor,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter your name';
                                        }
                                        return null;
                                      },
                                      style: fontRegular.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.textColor
                                      ),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                        hintText: "Enter your name",
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
                          SizedBox(height: 2.h),
                          //mobile number
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextFieldTitleText("Mobile Number *"),
                                SizedBox(height:1.h),
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
                                      controller: mobileController,
                                      autofillHints: const <String>[AutofillHints.telephoneNumberNational],
                                      cursorColor: AppColor.secondaryColor,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter mobile number';
                                        } else if (value.length < 10) {
                                          return 'Mobile Number must be 10 digits';
                                        }
                                        return null;
                                      },
                                      style: fontRegular.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.textColor
                                      ),
                                      keyboardType: TextInputType.phone,
                                      textInputAction: TextInputAction.next,
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
                          SizedBox(height: 2.h),
                          //email
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Email",
                                      style: fontRegular.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.textColor
                                      ),),
                                    const Spacer(),
                                    Text("(Optional)",
                                      style: fontRegular.copyWith(
                                          fontSize: 8.sp,
                                          color: AppColor.textMildColor
                                      ),),
                                  ],
                                ),
                                SizedBox(height:1.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                    vertical: 1.5.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.lightColor,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: TextFormField(
                                    controller: emailController,
                                    cursorColor: AppColor.secondaryColor,
                                    style: fontRegular.copyWith(
                                        fontSize: 10.sp,
                                        color: AppColor.textColor
                                    ),
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        setState(() {
                                          hasValue = false;
                                          isValid = false;
                                        });
                                      } else {
                                        setState(() {
                                          hasValue = true;
                                         // isValid = EmailValidator.validate(value);
                                        });
                                      }
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      // suffixIcon: !hasValue ? const SizedBox() : Icon(isValid ? Icons.done_all : Icons.error_outline, color: isValid ? Colors.green : Colors.red, size: 5.w,),
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: "Enter email address",
                                      hintStyle: fontRegular.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.textMildColor
                                      ),),
                                  ),
                                ),
                                !hasValue || isValid
                                    ? const SizedBox()
                                    : SizedBox(height:1.h),
                                !hasValue || isValid
                                    ? const SizedBox()
                                    : Text("* Enter a valid email address",
                                  style: fontRegular.copyWith(
                                      fontSize: 8.sp,
                                      color: AppColor.redColor
                                  ),),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h),
                          //referral code
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Referral Code",
                                      style: fontRegular.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.textColor
                                      ),),
                                    const Spacer(),
                                    Text("(Optional)",
                                      style: fontRegular.copyWith(
                                          fontSize: 8.sp,
                                          color: AppColor.textMildColor
                                      ),),
                                  ],
                                ),
                                SizedBox(height:1.h),
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
                                      textCapitalization: TextCapitalization.characters,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(9),
                                      ],
                                      controller: refCodeController,
                                      cursorColor: AppColor.secondaryColor,
                                      style: fontRegular.copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor.textColor
                                      ),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                        hintText: "Enter referral code",
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
                          SizedBox(height: 5.h),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  //register button
                  if(loading)...[
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    )
                  ] else...[
                    Bounceable(
                        onTap:(){
                         // validate();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: const CustomButton(AppColor.primaryColor, "Sign Up", AppColor.textColor),
                        ))
                  ],
                  SizedBox(height: 2.h),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Already have an account? ',
                          style: fontRegular.copyWith(
                            color: AppColor.textColor,
                            fontSize: 11.sp,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: ' Log in',
                                style: fontMedium.copyWith(
                                  color: AppColor.redColor,
                                  fontSize: 11.sp,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pop(context);
                                  }
                            )
                          ]
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          )

    );
  }

  // Future<void> _requestLocationPermission() async {
  //   await Permission.location.request();
  // }

  // void validate() {
  //   print(refCodeController.text);
  //   if (_formKey.currentState!.validate()) {
  //       setState(() {
  //         loading = true;
  //       });
  //       if(hasValue && !isValid){
  //         setState(() {
  //           loading = false;
  //         });
  //         Dialogs.snackbar("Enter a valid email address", context, isError: true);
  //       } else {
  //         AuthProvider().register(nameController.text, emailController.text, mobileController.text, refCodeController.text)
  //             .then((value) async {
  //           if(value.status == true){
  //             SharedPreferences preferences = await SharedPreferences.getInstance();
  //             preferences.setString("user_temp_id", value.userTempId.toString());
  //             preferences.setString("mobile", mobileController.text);
  //             preferences.setString("otp", value.otp.toString());
  //             preferences.setBool("isLoginScreen", false);
  //             _requestLocationPermission();
  //             if(mounted){
  //               Navigator.push(context, ScaleRoute(page: EnterOtpScreen(false, true, value.otp.toString(), value.userTempId.toString(), mobileController.text, false)));
  //             }
  //             setState(() {
  //               loading = false;
  //             });
  //             print("registration form submitted");
  //             // Dialogs.snackbar(value.message.toString(), context, isError: false);
  //           } else if(value.status == false){
  //             print(value.message.toString());
  //             Dialogs.snackbar(value.message.toString(), context, isError: true);
  //             setState(() {
  //               loading = false;
  //             });
  //           } else{
  //             setState(() {
  //               loading = false;
  //             });
  //           }
  //         });
  //       }
  //   }
  //   }
}
