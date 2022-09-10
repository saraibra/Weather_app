import 'package:wheather_app/features/weather_feature/domain/entities/city.dart';
import 'package:wheather_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:wheather_app/features/weather_feature/domain/repositories/weather_reporistory.dart';

class GetAllCitiesUseCase {
final WeatherReporsitory citiesRepositories;

  GetAllCitiesUseCase(this.citiesRepositories);
  Future<Either<Failure, City>> call() async{
   return await citiesRepositories.getAllCities();
  }
}