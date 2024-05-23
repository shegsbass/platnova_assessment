import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';

import '../../../domain/models/user_model/user_detail_response.dart';
import '../../../domain/repository/user_repository.dart';
import '../../../presentation/components/common/global.dart';
import '../../../presentation/components/common/helpers.dart';
import '../network/api_services.dart';

class UserRepositoryImpl implements UserRepository{
  @override
  Future<List<UserDetailResponse>> getUserDetails({required WidgetRef ref}) async{
    try{
      Global.showAppLoader(ref: ref);
      final response = await ApiServices.getUsers
          .hit(map: (result) => result,);
      print(response.runtimeType);
      Global.dismissAppLoader(ref: ref);
      final List<dynamic> responseData = response as List<dynamic>;
      final List<UserDetailResponse> userResponses = responseData.map((json) => UserDetailResponse.fromJson(json)).toList();
      return userResponses;
    }catch(e, s){
      debugPrint(e.toString());
      debugPrint("Show error:: $s");
      Global.dismissAppLoader(ref: ref);
      handleError(ref, e: e,);
      rethrow;
    }
  }


}