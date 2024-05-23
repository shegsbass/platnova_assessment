import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../di/providers/user_provider.dart';
import 'colors.dart';
import 'loader_overlay.dart';

class Global{
  static showAppLoader({required WidgetRef ref}) {
    final context = ref.read(mainKeyProvider).currentContext;
    if (context != null) {
      final overlay = LoadingOverlay.of(context);
      overlay.show();
    }
  }

  static dismissAppLoader({required WidgetRef ref}) {



    final context = ref.read(mainKeyProvider).currentContext;
    if (context != null) {
    //  log("calleed"); print("fufu");
      Navigator.pop(context);
    }
  }

  static showToastMessage({required message, color = PlatnovaColors.primary}) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        //timeInSecForIosWeb: 1,
        backgroundColor: color.withOpacity(.9),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static showSnackbar({
    required BuildContext context,
    required String message,
    Color backgroundColor = PlatnovaColors.primary,
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      duration: duration,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}