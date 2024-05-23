import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SizeConfig {
  String str = "";
  static late BuildContext appContext;
  static late MediaQueryData _mediaQueryData;
  static late double? screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    appContext = context;
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }

  static void darkStatus({Color color = Colors.transparent}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        // statusBarColor is used to set Status bar color in Android devices.
        statusBarColor: color,
        // To make Status bar icons color white in Android devices.
        statusBarIconBrightness: Brightness.light,
        // statusBarBrightness is used to set Status bar icon color in iOS.
        statusBarBrightness: Brightness.dark
        // Here light means dark color Status bar icons.
        ));
  }

  static void lightStatus({Color color = Colors.transparent}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        // statusBarColor is used to set Status bar color in Android devices.
        statusBarColor: color,
        // To make Status bar icons color white in Android devices.
        statusBarIconBrightness: Brightness.dark,
        // statusBarBrightness is used to set Status bar icon color in iOS.
        statusBarBrightness: Brightness.light
        // Here light means dark color Status bar icons.
        ));
  }

  static double height(double height) {
    final double screenHeight = _mediaQueryData.size.height / 100;
    return height * screenHeight;
  }

  static double relHeight(double height) {
    final double screenHeight = _mediaQueryData.size.height / 100;
    return (height / 8.12) * screenHeight;
  }

  static double relWidth(double width) {
    final double screenWidth = _mediaQueryData.size.width / 100;
    return (width / 3.75) * screenWidth;
  }

  static double width(double width) {
    final double screenWidth = _mediaQueryData.size.width / 100;
    return width * screenWidth;
  }

  static double textSize(double textSize) {
    final double screenWidth = _mediaQueryData.size.width / 100;
    final double screenHeight = _mediaQueryData.size.height / 100;
    return (((textSize / 3.75) * screenWidth) +
            ((textSize / 8.12)) * screenHeight) /
        2;
  }
}
