import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/value_manger.dart';
import '../bloc/weather_bloc.dart';

class CityItem extends StatelessWidget {
  const CityItem({Key? key, required this.index, required this.citiesList}) : super(key: key);

  final int index;
    final List<String> citiesList;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {},
        builder: (context, state) {
       
          return Container(
         
            decoration: BoxDecoration(
                color: BlocProvider.of<WeatherBloc>(context).selected != index
                    ? ColorManager.white
                    : ColorManager.primary,
                borderRadius: BorderRadius.circular(AppSize.s12),
                border: Border.all(color: ColorManager.primary)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                      citiesList[index],
                      style: TextStyle(
                          color: BlocProvider.of<WeatherBloc>(context)
                                      .selected ==
                                  index
                              ? ColorManager.white
                              : ColorManager.grey))),
            ),
          );
        });
  }
}
