import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheather_app/core/network/cashe_helper.dart';
import 'package:wheather_app/core/resources/color_manager.dart';
import 'package:wheather_app/core/resources/string_manager.dart';
import 'package:wheather_app/core/utils/methods.dart';
import 'package:wheather_app/features/weather_feature/domain/entities/weather_entity.dart';
import 'package:wheather_app/features/weather_feature/presentation/screens/search_screen.dart';

import '../../../../core/resources/value_manger.dart';
import '../bloc/weather_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key, required this.weather}) : super(key: key);
  final Weather weather;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppPadding.p40, horizontal: AppPadding.p16),
        child:
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is! TemperatueUnitChangeState) {
            BlocProvider.of<WeatherBloc>(context).temperatureUnit =
                BlocProvider.of<WeatherBloc>(context).temeratureList.first;
          } else {
            BlocProvider.of<WeatherBloc>(context).temperatureUnit =
                state.tempUnit;
          }
          return Column(
            children: [
              ListTile(
                leading: const Icon(Icons.star),
                title: Text(
                  AppStrings.favouriteLocation,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                subtitle: Row(
                  children: [
                    const Icon(
                      Icons.location_pin,
                      size: AppSize.s12,
                    ),
                    Text(CasheHelper.getData(key: 'home')![0]),
                    const Spacer(),
                    SizedBox(
                      width: AppSize.s40,
                      child: Row(
                        children: [
                          Icon(
                            Icons.sunny,
                          color: ColorManager.yellow,
                            size: AppSize.s16,
                          ),
                          Text(
                            CasheHelper.getStringData(key: 'homeTemp')!,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.add_location_alt,
                ),
                title: Text(
                  AppStrings.otherLocation,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                subtitle: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(CasheHelper.getData(key: 'city') != null &&
                                CasheHelper.getData(key: 'city')!.length > 1
                            ? CasheHelper.getData(key: 'city')![1]
                            : CasheHelper.getData(key: 'home')![0]),
                        CasheHelper.getData(key: 'city') != null &&
                                CasheHelper.getData(key: 'city')!.length > 2
                            ? Text(CasheHelper.getData(key: 'city')![2])
                            : SizedBox()
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: AppSize.s40,
                      child: Row(
                        children: [
                          Icon(
                            Icons.sunny,
                            color: ColorManager.yellow,
                            size: AppSize.s16,
                          ),
                          Text(
                            '${weather.hourWeather[0].temp!.ceil()}' '°',
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  navigateTo(context, SearchScreen());
                },
                borderRadius: BorderRadius.circular(AppSize.s20),
                child: Container(
                  width: double.infinity,
                  height: AppSize.s40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s20),
                      color: ColorManager.yellow),
                  child: Center(
                    child: Text(
                      'Manage Location',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                title: Row(
                  children: [
                    const Text(AppStrings.temperatureUnit),
                    const Spacer(),
                    state is TemperatueUnitChangeState
                        ? Text(state.tempUnit)
                        : Text(
                            BlocProvider.of<WeatherBloc>(context).selectedUnit),
                    DropdownButton(
                      items: BlocProvider.of<WeatherBloc>(context)
                          .temeratureList
                          .map(
                        (value) {
                          return DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        BlocProvider.of<WeatherBloc>(context)
                            .add(ChangeTemperatureUnitEvent(value.toString()));
                      },
                      underline: const SizedBox(),
                    ),
                  ],
                ),
              ),
              const Divider(),
              const ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Report wrong location')),
              const ListTile(
                  leading: Icon(Icons.support_agent),
                  title: Text('Contact us')),
            ],
          );
          //}
          //      else if(state is ErrorWeatherState){
          // return   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          // }
          // else {
          //   return Center(child: CircularProgressIndicator());
          // }
        }),
      ),
    );
  }
}
