part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetTodayWeatherEvent extends WeatherEvent {}
class GetCityWeatherEvent extends WeatherEvent {
 final int index;
 final BuildContext context;
  String? city;
  GetCityWeatherEvent({required this.index, required this.context,this.city});
}
class ChangeTemperatureUnitEvent extends WeatherEvent {
 final String tempUnit;

  ChangeTemperatureUnitEvent(this.tempUnit);
}

class GetallCitiesEvent extends WeatherEvent {

  GetallCitiesEvent();
}

class SearchCitiesEvent extends WeatherEvent {

  SearchCitiesEvent();
}
