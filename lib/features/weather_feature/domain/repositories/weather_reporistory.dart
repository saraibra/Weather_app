import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/city.dart';
import '../entities/weather_entity.dart';

abstract class WeatherReporsitory{
 Future<Either<Failure,Weather>> getTodayWeather(String unit);
   Future<Either<Failure,Weather>> getWeatherByCity(String city,String unit);
     Future<Either<Failure,City>> getAllCities();


}