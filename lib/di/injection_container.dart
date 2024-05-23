
import 'package:get_it/get_it.dart';
import 'package:platnova_assessment/presentation/util/data_utils/storage/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/remote/network/base_http.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton(PlatnovaBaseHttpService.new);
  //! Features

  // Repository

  // Data sources

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(sharedPreferences),
  );
}
