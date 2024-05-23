import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/remote/repository/user_repository_impl.dart';
import '../../domain/models/user_model/user_detail_response.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
GlobalKey<NavigatorState> mainKey(MainKeyRef ref) {
  GlobalKey<NavigatorState> materialKey = GlobalKey();
  return materialKey;
}

@riverpod
UserRepositoryImpl user(UserRef ref){
  return UserRepositoryImpl();
}

@riverpod
Future<List<UserDetailResponse>> getUsers(GetUsersRef ref, WidgetRef widgetRef) async{
  return await ref.read(userProvider).getUserDetails(ref: widgetRef);
}