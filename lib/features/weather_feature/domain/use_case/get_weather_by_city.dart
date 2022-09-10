import 'package:dartz/dartz.dart';
import 'package:wheather_app/core/errors/failure.dart';
import 'package:wheather_app/features/weather_feature/domain/entities/weather_entity.dart';
import 'package:wheather_app/features/weather_feature/presentation/bloc/weather_bloc.dart';

import '../repositories/weather_reporistory.dart';

class GetWeatherByCityUseCase{
 final WeatherReporsitory weatherByCityRepository;

  GetWeatherByCityUseCase({required this.weatherByCityRepository});
  Future<Either<Failure,Weather>> call(String city,String unit) async{
    return await weatherByCityRepository.getWeatherByCity(city,unit);
  }
  
}