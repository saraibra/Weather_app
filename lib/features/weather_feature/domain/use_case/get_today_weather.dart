import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/weather_entity.dart';
import '../repositories/weather_reporistory.dart';

class GetTodayWeatherUseCase{
  final WeatherReporsitory reporsitory;
  GetTodayWeatherUseCase(this.reporsitory);
  Future<Either<Failure,Weather>> call (String unit)async{
 return await reporsitory.getTodayWeather(unit);
  }

}