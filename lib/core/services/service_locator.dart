
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheather_app/features/weather_feature/domain/use_case/get_all_cities.dart';
import 'package:wheather_app/features/weather_feature/domain/use_case/get_weather_by_city.dart';

import '../../features/weather_feature/data/datasources/weather_local_datasource.dart';
import '../../features/weather_feature/data/datasources/wheather_remote_datasource.dart';
import '../../features/weather_feature/data/reporistories/weather_repository_implement.dart';
import '../../features/weather_feature/domain/repositories/weather_reporistory.dart';
import '../../features/weather_feature/domain/use_case/get_today_weather.dart';
import '../../features/weather_feature/presentation/bloc/weather_bloc.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //*  features quran
  // bloc
  sl.registerFactory(() => WeatherBloc(getTodayWeatherUseCase: sl(),sl(),sl()));
  // usecases
  sl.registerLazySingleton<GetTodayWeatherUseCase>(() => GetTodayWeatherUseCase(sl()));
    sl.registerLazySingleton<GetWeatherByCityUseCase>(() => GetWeatherByCityUseCase(weatherByCityRepository: sl()));
    sl.registerLazySingleton<GetAllCitiesUseCase>(() => GetAllCitiesUseCase(sl()));

  // repositories
  sl.registerLazySingleton<WeatherReporsitory>(() => WeatherRepositoryImplement(sl(),
      weatherRemoteDataSource: sl()));
  // datasources
  sl.registerLazySingleton<WeatherRemoteDataSource>(() => WeatherRemoteDataSourceImplement(client: sl()));
  sl.registerLazySingleton<WeatherLocalDataSource>(
      () => WeatherLocalDataSourceImplement(sharedPreferences: sl()));
  //* core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplement(sl()));
  //* external
  final sharedPreference =await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreference);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
