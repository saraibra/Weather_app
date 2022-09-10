import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheather_app/features/weather_feature/presentation/bloc/weather_bloc.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/value_manger.dart';
import 'city_item.dart';

class CitiesList extends StatelessWidget {
  const CitiesList({Key? key, required this.citiesList}) : super(key: key);
  final List<String> citiesList;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      return SizedBox(
        height: AppSize.s150,
        child: GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 2,
            shrinkWrap: true,
            crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          // scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            children: List.generate(10, (index) {
              return InkWell(
                borderRadius: BorderRadius.circular(AppSize.s12),
                onTap: () {
                  BlocProvider.of<WeatherBloc>(context).add(GetCityWeatherEvent(index:index,context:context,city: ''));
                },
                child: CityItem(
                  index: index,
                  citiesList: citiesList,
                ),
              );
            }).toList()),
      );
    });
    // child: SizedBox(
    //   width: double.infinity,
    //   height: AppSize.s28,
    //   child:

    // ListView.separated(
    //     scrollDirection: Axis.horizontal,
    //     itemBuilder: (context, index) => GestureDetector(
    //         onTap: () {
    //           BlocProvider.of<WeatherBloc>(context).selectCity(index);
    //         },
    //         child: CityItem(
    //           cityName: citiesList[index],
    //           selected:BlocProvider.of<WeatherBloc>(context) .selected == index,
    //         )),
    //     separatorBuilder: (context, index) => const SizedBox(
    //           width: AppSize.s12,
    //         ),
    //     itemCount: citiesList.length),
  }
}
