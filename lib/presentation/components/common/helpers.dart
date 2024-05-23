import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/remote/network/errors.dart';
import '../../../di/providers/user_provider.dart';
import 'global.dart';

void handleError(WidgetRef ref, {required e, data}) {

  final context = ref.read(mainKeyProvider).currentContext;

  print("object");
  print("object: $e");
  Map<String, dynamic> errorData = {};
  if (e is! String) {
    if (e is UnauthorizedException) {
      // TODO: handle unauthorized
      // LogOut.forceSignOut(ref);
    } else {
      var tempMap = jsonDecode(e.toString());
      print(tempMap);
      if (tempMap["data"] != null) {
        errorData = {
          "error": "Error",
          "message": tempMap["data"]["error"]["message"],
          "subStatusCode": tempMap["data"]["error"]["subStatusCode"],
          "loginData": data,
        };
      } else {
        errorData = tempMap;
      }
    }
  } else {
    errorData = {
      "error": "Error",
      "message": e.toString(),
      "subStatusCode": "",
      "loginData": data,
    };
  }
  // TODO: handle error
  if(context != null){

    debugPrint("riceeeeee");
    Global.showSnackbar(context: context, message: errorData["message"]);

  }
}

bool isScreenDisplayed(BuildContext context, String screenRouteName) {
  final ModalRoute<dynamic>? currentRoute = ModalRoute.of(context);

  print("Attempt to cR ${currentRoute?.settings.name}");
  print("Attempt to close $screenRouteName");
  // Check if the current route's name matches the specified screenRouteName
  return currentRoute?.settings.name == screenRouteName;
}