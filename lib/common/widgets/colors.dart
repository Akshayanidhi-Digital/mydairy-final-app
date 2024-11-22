import 'package:flutter/material.dart';

class AppColor {
  static const Color appColor = Color.fromARGB(255, 0, 101, 183);
  static const Color bluedarkClr = Color.fromARGB(255, 5, 51, 87);
  static const Color greenClr = Color(0xff28A745);
  static const Color yellowClr = Color.fromARGB(255, 255, 211, 0);
  static const Color bluelightClr = Color.fromARGB(255, 180, 223, 255);
  static const Color greenlight = Color(0xffc3f7ff);
  static const Color grey = Color(0xffD3D3D3);
  static const Color txtwhite = Color(0XFFfafafa);
  static const Color ligthClr = Color(0XFFC8FFF2);
  static const Color transparent = Colors.transparent;

  static const Color blackClr = Colors.black;
  // static Color redClr = const Color(0xffF7422D);
  static const Color redClr = Color(0xffFF0000);
  static const Color whiteClr = Colors.white;
}

class Msg {
  static const String number_pattern = r'^[6789]\d{9}$';
  static RegExp phoneregExp = RegExp(number_pattern);
  static const String noInternet = "No internet connection";
  static const String error = "Something went wrong !, please try again later";
  static const String password_required = "Password is Required";
  static const String password_invalide =
      "Password required at least 6 numbers";
  static const String number_required = "Phone Number is Required.";
  static const String number_invalide = "Please enter Valid Mobile Number";
  static const String otp_required = "OTP is Required.";
  static const String otp_invalide = "OTP required at least 4 numbers";
  static const String somethingWrong = "Something went wrong !";
  static const String sometechnicalissue =
      "Some Technical issue !, Please try again later.";
}
