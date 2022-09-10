import 'package:dartz/dartz.dart';
import 'package:wheather_app/features/weather_feature/domain/entities/city.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/weather_reporistory.dart';
import '../datasources/weather_local_datasource.dart';
import '../datasources/wheather_remote_datasource.dart';

class WeatherRepositoryImplement implements WeatherReporsitory {
  // final WeatherLocalDataSource surahLocalDataSource;
  final WeatherRemoteDataSource weatherRemoteDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImplement(this.networkInfo,
      {required this.weatherRemoteDataSource});
  // @override
  // Future<Either<Failure, List<Weather>>> getAllSurahs() async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final remoteSurahs = await weatherRemoteDataSource.getAllSurahs();
  //       weatherRemoteDataSource.saveSurahs(remoteSurahs);
  //       return Right(remoteSurahs);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   } else {
  //     try {
  //       final localSurahs = await surahLocalDataSource.getCashedSurahs();
  //       return Right(localSurahs);
  //     } on EmptyCasheException {
  //       return Left(EmptyCasheFailure());
  //     }
  //   }
  // }

  @override
  Future<Either<Failure, Weather>> getTodayWeather(String unit) async {
    if (await networkInfo.isConnected) {
      try {
        final weather = await weatherRemoteDataSource.getTodaWeather(unit);
        return Right(weather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
  

  @override
  Future<Either<Failure, Weather>> getWeatherByCity(String city,String unit) async{
if(await networkInfo.isConnected){
 try {
        final weather = await weatherRemoteDataSource.getWeatherbyCity(city,unit);
        return Right(weather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, City>> getAllCities() async{
   if(await networkInfo.isConnected){
 try {
        final city = await weatherRemoteDataSource.getAllCities();
        return Right(city);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
