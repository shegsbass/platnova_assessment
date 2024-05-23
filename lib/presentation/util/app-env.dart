// ignore_for_file: constant_identifier_names, use_setters_to_change_properties, avoid_classes_with_only_static_members
enum AppEnvironment { DEV, STAGING, PROD }

abstract class EnvInfo {
  static AppEnvironment _environment = AppEnvironment.DEV;

  static void initialize(AppEnvironment environment) {
    EnvInfo._environment = environment;
  }

  static String get appName => _environment._appTitle;
  static String get envName => _environment._envName;
  static String get baseUrlString => _environment._baseUrlString;
  static AppEnvironment get environment => _environment;
  static bool get isProduction => _environment == AppEnvironment.PROD;
}

extension _EnvProperties on AppEnvironment {
  static const _appTitles = {
    AppEnvironment.DEV: 'Platnova Dev',
    AppEnvironment.STAGING: 'Platnova Staging',
    AppEnvironment.PROD: 'Platnova TDD',
  };

  static const _baseUrl = {
    AppEnvironment.DEV: 'https://jsonplaceholder.typicode.com',
    AppEnvironment.STAGING: '',
    AppEnvironment.PROD: '',
  };

  static const _envs = {
    AppEnvironment.DEV: 'dev',
    AppEnvironment.STAGING: 'staging',
    AppEnvironment.PROD: 'prod',
  };

  String get _appTitle => _appTitles[this]!;
  String get _envName => _envs[this]!;
  String get _baseUrlString => _baseUrl[this]!;
}
