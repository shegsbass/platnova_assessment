import 'package:platnova_assessment/domain/models/user_model/user_detail_response.dart';

class User {
  int id;
  String name;
  String email;
  String street;
  String phone;
  String companyName;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.street,
    required this.phone,
    required this.companyName
  });


  factory User.fromUserDetailResponse(UserDetailResponse userResponse) => User(
    id: userResponse.id,
    name: userResponse.name,
    email: userResponse.email,
    street: userResponse.address.street,
    phone: userResponse.phone,
    companyName: userResponse.company.name,
  );
}