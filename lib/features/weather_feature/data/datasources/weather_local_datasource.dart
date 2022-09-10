import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exception.dart';
import '../models/weather_model.dart';

abstract class WeatherLocalDataSource {

  Future<Unit> saveData(List<WeatherModel> SurahsModel);
    Future<List<WeatherModel>> getCashedData();

}

class WeatherLocalDataSourceImplement implements WeatherLocalDataSource {
    final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImplement({required this.sharedPreferences});
  @override
  Future<List<WeatherModel>> getCashedData() {
    final jsonString = sharedPreferences.getString('CASHED_SurahS');
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<WeatherModel> jsonToWeatherModel =
          decodeJsonData.map<WeatherModel>((jsonWeatherModel) => WeatherModel.fromJson(jsonWeatherModel)).toList();
          return Future.value(jsonToWeatherModel);
    }
    else{
      throw EmptyCasheException();
    }
  }

  @override
  Future<Unit> saveData(List<WeatherModel> weatherModel) {
    // List WeatherModelToJson = weatherModel
    //     .map<Map<String, dynamic>>((WeatherModel) => WeatherModel.toJson())
    //     .toList();
    // sharedPreferences.setString('CASHED_SurahS', json.encode(WeatherModelToJson));
    return Future.value(unit);
  }
  

}
