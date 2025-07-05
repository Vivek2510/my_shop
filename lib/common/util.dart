import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:task_demo/constant/font_style.dart';

AppBar baseAppBar({
  String title = '',
  List<Widget>? widgets,
  Widget? leading,
  double? leadingWidth,
  double elevation = 0.0,
  TextStyle? titleStyle,
  Color color = Colors.transparent,
  SystemUiOverlayStyle systemOverlayStyle = SystemUiOverlayStyle.dark,
  bool centerTitle = true,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    systemOverlayStyle: systemOverlayStyle,
    backgroundColor: color,
    elevation: elevation,
    leadingWidth: leadingWidth,
    titleSpacing: 0,
    leading:
        leading != null
            ? Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: leading,
            )
            : null,
    title: Padding(
      padding: EdgeInsets.only(left: leading == null ? 20.0 : 0),
      child: Text(
        title,
        style:
            titleStyle ??
            AppFontStyle.boldInterTextFiled.copyWith(color: Colors.black),
      ),
    ),
    centerTitle: centerTitle,
    iconTheme: const IconThemeData(
      color: Colors.black, //change your color here
    ),
    actions: widgets,
  );
}

String getFormattedTime({required int timestamp}) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  var days = today.difference(date).inDays;

  if (days > 0) {
    String formattedDate = DateFormat('dd MMM yyyy').format(date);
    return formattedDate;
  } else {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String formattedDate = DateFormat('hh:mm a').format(date);
    return formattedDate;
  }
}

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

Future<bool> checkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.mobile)) {
    return true;
  } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
    return true;
  }
  return false;
}

DateTime? backButtonPressedTime;

Future<bool> performWillPopTwoClick() async {
  DateTime currentTime = DateTime.now();

  bool backButton =
      backButtonPressedTime == null ||
      currentTime.difference(backButtonPressedTime!) >
          const Duration(seconds: 3);

  if (backButton) {
    backButtonPressedTime = currentTime;
    Fluttertoast.showToast(
      msg: 'Double click to exit app',
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
    return Future.value(false);
  }
  exit(0);
  // return true;
}

void showLoader(BuildContext context) {
  Loader.show(
    context,
    progressIndicator: const SizedBox(
      height: 100,
      width: 100,
      child: LoadingIndicator(
        indicatorType: Indicator.ballSpinFadeLoader,
        colors: [Color(0xFF81C035)],
        strokeWidth: 2,
        pathBackgroundColor: Colors.black,
      ),
    ),
    overlayColor: Colors.black.withValues(alpha: 0.6),
    overlayFromTop: 0,
  );
}

void hideLoader() {
  Loader.hide();
}

void showToastAlert({String message = ''}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

BoxDecoration formContainerDecoration({Color? backgroundColor}) {
  return BoxDecoration(
    color: backgroundColor,
    borderRadius: const BorderRadius.only(topLeft: Radius.circular(75)),
  );
}
