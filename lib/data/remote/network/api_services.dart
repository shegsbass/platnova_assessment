
import '../../../presentation/util/app-env.dart';
import 'base_http.dart';

class ApiServices {
  static final baseUrl = EnvInfo.baseUrlString;

  static final getUsers = PlatnovaEndpoint("GET", "/users");
}

class PlatnovaEndpoint extends Endpoint {
  PlatnovaEndpoint(super.method, super.url);

  @override
  String get domainUrl => ApiServices.baseUrl;
}
