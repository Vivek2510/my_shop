import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// This class will have all the color constant which are using in the App.
class AppFontStyle {
  static const String inter = 'Inter';
  static const String barlow = 'Barlow';

  static const boldInterTextFiled = TextStyle(
    fontFamily: inter,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
  );

  static const semiBoldInterTextFiled = TextStyle(
    fontFamily: inter,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
  );

  static const regularInterTextFiled = TextStyle(
    fontFamily: inter,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

}
