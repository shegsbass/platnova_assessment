import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model/user_detail_response.dart';

abstract class UserRepository{
  Future<List<UserDetailResponse>> getUserDetails({required WidgetRef ref});
}