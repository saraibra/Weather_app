import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:wheather_app/core/utils/end_points.dart';
import 'package:wheather_app/features/weather_feature/data/models/city_model.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/services/location.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getTodaWeather(String unit);
  Future<WeatherModel> getWeatherbyCity(String city,String unit);
    Future<CityModel> getAllCities();

}

class WeatherRemoteDataSourceImplement implements WeatherRemoteDataSource {
  final http.Client client;
LocationData? locationData ;

  WeatherRemoteDataSourceImplement({required this.client});
  @override
  Future<WeatherModel> getTodaWeather(String unit) async {
     locationData = await LocationService.determinePosition();

    latitude = locationData!.latitude!;
    longitude = locationData!.longitude!;
String todayWeatherEndPoint =
    '$baseUrl/forecast?lat=$latitude&lon=$longitude&exclude=hourly&appid=$apiKey&units=$unit&lang=en';
    final response = await client.get(
      Uri.parse(todayWeatherEndPoint),
    );
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final WeatherModel WeatherModels = WeatherModel.fromJson(decodedJson);
      return WeatherModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<WeatherModel> getWeatherbyCity(String city,String unit) async{


String weatherByCityEndPoint = '$baseUrl/forecast?q=$city&exclude=hourly&appid=$apiKey&units=$unit&lang=en';
    final response = await client.get(
      Uri.parse(weatherByCityEndPoint),
    );
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final WeatherModel WeatherModels = WeatherModel.fromJson(decodedJson);
      return WeatherModels;
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<CityModel> getAllCities() async{
   final response = await client.get(
      Uri.parse(cityAndCountryEndPoint),
    );
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final CityModel cityModel = CityModel.fromJson(decodedJson);
      return cityModel;
    } else {
      throw ServerException();
    }
  }


}
