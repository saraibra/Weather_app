part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  
  @override
  List<Object> get props => [];
}

class WheatherInitial extends WeatherState {}
class LoadingWeatherState extends WeatherState {}
class LoadedWeathersState extends WeatherState {
  final Weather weather;

  LoadedWeathersState({required this.weather});
  
  
  @override
  List<Object> get props => [weather];
}
class ErrorWeatherState extends WeatherState {
  final String message;

  ErrorWeatherState(this.message);
}


class LoadingWeekWeatherState extends WeatherState {}
class LoadedWeekWeathersState extends WeatherState {
  final Weather weather;

  LoadedWeekWeathersState({required this.weather});
  
  
  @override
  List<Object> get props => [weather];
}
class ErrorWeekWeatherState extends WeatherState {
  final String message;

  ErrorWeekWeatherState(this.message);
}
class TemperatueUnitChangeState extends WeatherState {
  final String tempUnit;

  TemperatueUnitChangeState({required this.tempUnit});
   @override
  List<Object> get props => [tempUnit];
}
class GetAllcitiesState extends WeatherState {
final List<String> city;
  GetAllcitiesState(this.city);
   @override
  List<Object> get props => [city];
}

class SearchCitiesState extends WeatherState {
final String city;
  SearchCitiesState(this.city);
   @override
  List<Object> get props => [city];
}
class SearchCitiesLoadingState extends WeatherState {
  SearchCitiesLoadingState();
   @override
  List<Object> get props => [];
}
class SelectCityState extends WeatherState {
 final String selected;

  SelectCityState({required this.selected});
   @override
  List<Object> get props => [selected];
}
