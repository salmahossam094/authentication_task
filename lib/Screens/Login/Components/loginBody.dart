import 'package:authentication_task/Screens/Register/register.dart';
import 'package:authentication_task/firebase/firebase_functions.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../components/buttons.dart';
import '../../../../constants.dart';
import '../../HomePage.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    bool emptyArea = false;

    return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
///////////////////////////////////////////////////////////////////////////////////
              Padding(
                padding: const EdgeInsets.only(top: 120).r,
                child: SizedBox(
                  width: 260.w,
                  child: Column(
                    children: [
                      Text(
                        "Login!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: mainFontSize.sp,
                          fontWeight: mainFontWeight,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Welcome back ! Login with your credentials",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: commonTextSize.sp,
                          color: lightGreyReceiptBG,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
///////////////////////////////////////////////////////////////////////////////////

              SizedBox(width: double.infinity.w, height: 40.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
///////////////////////////////////////////////////////////////////////////////////
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0).r,
                      child: SizedBox(
                        width: 220.w,
                        height: 90.h,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              displaySnackBar("enter your email");
                              emptyArea = true;
                              return "empty";
                            }
                            return null;
                          },
                          cursorColor: textBlack,
                          style: TextStyle(fontSize: subFontSize.sp),
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: textBlack),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: textBlack),
                            ),
                            icon: const Icon(
                              Icons.email_outlined,
                              color: textBlack,
                            ),
                            labelText: "Email",
                            hintText: "abc@gmail.com",
                            labelStyle: TextStyle(
                                color: textBlack,
                                fontSize: mainFontSize.sp,
                                fontWeight: mainFontWeight),
                            hintStyle: TextStyle(
                                color: textBlack, fontSize: subFontSize.sp),
                          ),
                          onChanged: (text) {
                            email = text;
                          },
                        ),
                      ),
                    ),
///////////////////////////////////////////////////////////////////////////////////
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0).r,
                      child: SizedBox(
                        width: 220.w,
                        height: 90.h,
                        child: TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              displaySnackBar("enter your email");
                              emptyArea = true;
                              return "empty";
                            }
                            return null;
                          },
                          cursorColor: textBlack,
                          style: TextStyle(fontSize: subFontSize.sp),
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: textBlack),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: textBlack),
                            ),
                            icon: const Icon(
                              Icons.password_outlined,
                              color: textBlack,
                            ),
                            labelText: "Password",
                            hintText: "******",
                            labelStyle: TextStyle(
                                color: textBlack,
                                fontSize: mainFontSize.sp,
                                fontWeight: mainFontWeight),
                            hintStyle: TextStyle(
                                color: textBlack, fontSize: subFontSize.sp),
                          ),
                          onChanged: (text) {
                            password = text;
                          },
                        ),
                      ),
                    ),
///////////////////////////////////////////////////////////////////////////////////
                    SizedBox(height: 30.h, width: double.infinity.w),
                    DefaultButton(
                        text: "Log in",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            emptyArea = false;
                          }
                          if (emptyArea == false) {
                            await displaySnackBar("loading");
                            FirebaseFunctions.login(email, password, () {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                title: 'Successful',
                                desc: 'Login Successful',
                                dialogBorderRadius: BorderRadius.circular(20),
                                dismissOnTouchOutside: false,
                                btnOkOnPress: () {},
                              ).show().then((value) =>
                                  Navigator.pushReplacementNamed(
                                      context, HomePage.routeName));
                            }, (value) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                title: 'Error',
                                desc: 'The email address or password you entered is invalid',
                                dialogBorderRadius: BorderRadius.circular(20),
                                dismissOnTouchOutside: false,
                                btnOkOnPress: () {},
                              ).show();
                              setState(() {

                              });
                            });
                          }
                        }),
///////////////////////////////////////////////////////////////////////////////////
                    SizedBox(height: 20.h, width: double.infinity.w),
                    Text(
                      "Do not have an account ?",
                      style: (TextStyle(
                          color: textBlack, fontSize: commonTextSize.sp)),
                    ),
///////////////////////////////////////////////////////////////////////////////////
                    InkWell(
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: textBlack,
                            fontSize: commonTextSize.sp,
                            fontWeight: commonTextWeight),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Register.routeName);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

// TODO: Create Your Functions Here
}
