import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  List<WeatherDetails> hourWeather;
  String? city;
  String? country;
  int? timezone;
  int? sunrise;
  int? sunset;
  Weather({
    required this.hourWeather,
      this.city,
      this.country,
      this.timezone,
      this.sunrise,
      this.sunset});
  @override
  List<Object?> get props => [];
}
class WeatherDetails extends Equatable{
   String? date;
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  String? tempKf;
  int dt =0;
  String? main;
  String? description;
  String? icon;
  int? all;
  double? speed;
  WeatherDetails(
      {this.date,
      this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity,
      this.tempKf,
      required this.dt,
      this.main,
      this.description,
      this.icon,
      this.all,
      this.speed,});
  @override
  // TODO: implement props
  List<Object?> get props => [];
  
}
