import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wheather_app/core/resources/value_manger.dart';
import 'package:wheather_app/features/weather_feature/presentation/bloc/weather_bloc.dart';

import '../../../../core/utils/methods.dart';
import '../../domain/entities/weather_entity.dart';

class WeekDetails extends StatelessWidget {
  const WeekDetails({Key? key, required this.weatherDetails}) : super(key: key);
  final List<WeatherDetails> weatherDetails;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WeatherBloc>(context).compareTime(weatherDetails);

    List<WeatherDetails> weakWeatherDetails =
        BlocProvider.of<WeatherBloc>(context).weakWeather;
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(AppSize.s12)),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: ListView.separated(
          itemCount: weakWeatherDetails.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: AppSize.s40,
                      child: Text(DateFormat('EE').format(
                          convertTimeToDate(weakWeatherDetails[index].dt)))),
                  Image.network('https://openweathermap.org/img/wn/'
                      '${weakWeatherDetails[index].icon}.png'),
                  Text('${weakWeatherDetails[index].description}'),
                  Text('${weakWeatherDetails[index].tempMax!.ceil()}'
                      '°'
                      ' / '
                      '${weakWeatherDetails[index].tempMin!.ceil()}'
                      '°'),
                ]);
          },
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: AppSize.s12,
          ),
        ),
      ),
    );
  }
}
