import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheather_app/core/utils/end_points.dart';
import 'package:wheather_app/features/weather_feature/domain/entities/city.dart';
import 'package:wheather_app/features/weather_feature/domain/use_case/get_all_cities.dart';
import 'package:wheather_app/features/weather_feature/domain/use_case/get_weather_by_city.dart';
import 'package:wheather_app/features/weather_feature/presentation/screens/home_screen.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/network/cashe_helper.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/utils/methods.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/use_case/get_today_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetTodayWeatherUseCase getTodayWeatherUseCase;
  final GetWeatherByCityUseCase getWeatherByCityUseCase;
  final GetAllCitiesUseCase getAllCitiesUseCase;

  String? unit = CasheHelper.getStringData(key: 'tempUnit') ?? '';
  String selectedUnit = CasheHelper.getStringData(key: 'tempUnit') != null
      ? CasheHelper.getStringData(key: 'tempUnit') == 'standard'
          ? AppStrings.fahrenheit
          : AppStrings.celsius
      : '';

  List<String> searchList = [];
  List<String> searchResult = [];
  String? searchCity;
  WeatherBloc(this.getWeatherByCityUseCase, this.getAllCitiesUseCase,
      {required this.getTodayWeatherUseCase})
      : super(WheatherInitial()) {
    on<WeatherEvent>(
      (event, emit) async {
        if (event is GetTodayWeatherEvent) {
          emit(LoadingWeatherState());
          final Either<Failure, Weather> WeatherList =
              await getTodayWeatherUseCase(unit!);

          emit(_mapFailureOrWeathersToState(WeatherList));
        } else if (event is GetCityWeatherEvent) {
          searchController.clear();
          if (event.city == '') {
            searchCity = selectCity(event.index);
            emit(SelectCityState(selected: selectedCity));
          } else {
            searchCity = event.city!;
            emit(SelectCityState(selected: event.city!));
          }

          final Either<Failure, Weather> WeatherList =
              await getWeatherByCityUseCase(searchCity!, unit!);
          emit(_mapFailureOrWeathersToState(WeatherList));

          navigateTo(event.context, HomeScreen());
        } else if (event is ChangeTemperatureUnitEvent) {
          selectedUnit = changeTemperatureUnit(event.tempUnit);
          emit(TemperatueUnitChangeState(tempUnit: selectedUnit));
          if (selectedUnit == AppStrings.fahrenheit) {
            unit = 'standard';
            CasheHelper.saveStringData(key: 'tempUnit', value: 'standard');
          } else if (selectedUnit == AppStrings.celsius) {
            unit = 'metric';
            CasheHelper.saveStringData(key: 'tempUnit', value: 'metric');
          }
          emit(LoadingWeatherState());

          final Either<Failure, Weather> WeatherList =
              await getTodayWeatherUseCase(unit!);
          emit(_mapFailureOrWeathersToState(WeatherList));
        } else if (event is GetallCitiesEvent) {
          searchList = [];
          final Either<Failure, City> cityList = await getAllCitiesUseCase();

          return cityList.fold(
              (failure) => ErrorWeatherState(_getFailureErrorMessage(failure)),
              (citiesList) {
            citiesList.cities.forEach((element) {
              searchList.add(element);
            });
            citiesList.country.forEach((element) {
              searchList.add(element);
            });

            emit(GetAllcitiesState(searchList));
          });
        } else if (event is SearchCitiesEvent) {
          emit(SearchCitiesLoadingState());
          searchResult = [];

          onSearchTextChanged(searchController.text);
          emit(SearchCitiesState('city'));
        }
      },
    );
  }

  WeatherState _mapFailureOrWeathersToState(Either<Failure, Weather> either) {
    return either
        .fold((failure) => ErrorWeatherState(_getFailureErrorMessage(failure)),
            (Weathers) {
      List<String> cities = [];
      if (CasheHelper.getData(key: 'city') != null) {
        cities = [];
        cities = CasheHelper.getData(key: 'city')!;
        cities.add(Weathers.city!);
        CasheHelper.saveData(key: 'city', value: cities);
      } else {
        cities.add(Weathers.city!);

        CasheHelper.saveData(key: 'home', value: cities);
        CasheHelper.saveStringData(
            key: 'homeTemp', value: Weathers.hourWeather[0].temp!.ceil().toString()+'°');

        CasheHelper.saveData(key: 'city', value: cities);
      }

      return LoadedWeathersState(weather: Weathers);
    });
  }

  String _getFailureErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverError;
      case EmptyCasheFailure:
        return AppStrings.cashError;
      case OfflineFailure:
        return AppStrings.offlineErrpr;
      default:
        return AppStrings.unexpectedError;
    }
  }

  onSearchTextChanged(String text) {
    searchResult = [];
    searchList.forEach((element) {
      if (element.toLowerCase().startsWith(text.toLowerCase())) {
        searchResult.add(element);
      }
    });
  }

  List<String> temeratureList = [AppStrings.celsius, AppStrings.fahrenheit];
  String temperatureUnit = '';

  String changeTemperatureUnit(value) {
    temperatureUnit = value;
    print(temperatureUnit);
    return temperatureUnit;
  }

  TextEditingController searchController = TextEditingController();

  List<String> worldCitiesList = [
    'Current',
    'Cairo',
    'London',
    'Paris',
    'New York',
    'Tokyo',
    'Rome',
    'Dubai',
    'Sydney',
    'Moscow',
  ];
  int? selected = 0;
  String selectedCity = '';
  String selectCity(int index) {
    selected = index;

    selectedCity = worldCitiesList[index];
    return selectedCity;
  }


  List<WeatherDetails> weakWeather = [];
  compareTime(List<WeatherDetails> weatherDetails) {
    weakWeather = [];
    int hour = DateTime.now().hour;

    for (int i = 0; i < weatherDetails.length; i++) {
      if (hour == convertTimeToDate(weatherDetails[i].dt).hour ||
          convertTimeToDate(weatherDetails[i].dt).hour - hour < 3 &&
              convertTimeToDate(weatherDetails[i].dt).hour - hour > 0) {
        debugPrint((weatherDetails[i].icon.toString()));
        weakWeather.add(weatherDetails[i]);
      }
    }
  }

  List<String> labels = [];
  List<double> tempList = [];

  getTempData(List<WeatherDetails> dayWeather) {
    tempList = [];
    labels = [];
    dayWeather.forEach((element) {
      if (convertTimeToDate(element.dt).day == DateTime.now().day ) {
        tempList.add(element.temp!.ceilToDouble());
        labels.add(element.humidity.toString() + ' %');

        //  CasheHelper.saveData(key: 'tempList', value: tempList.);

      }
    });
  }

  List<FlSpot> list = [];
  List<FlSpot>? getChartData() {
    list = [];
    for (int i = 0; i < tempList.length; i++) {
      list.add(FlSpot(i.toDouble(), tempList[i]));
    }
    return list;
  }
}
