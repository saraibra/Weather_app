import 'package:flutter/material.dart';
import 'package:wheather_app/core/resources/string_manager.dart';
import 'package:wheather_app/core/resources/value_manger.dart';
import 'package:wheather_app/core/utils/methods.dart';

import '../../../../core/resources/color_manager.dart';

class SunsetSunriseCard extends StatelessWidget {
  const SunsetSunriseCard(
      {Key? key, required this.sunrise, required this.sunset})
      : super(key: key);
  final int sunrise;
  final int sunset;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Card(
            elevation: AppSize.s4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)),
            child: Container(
                width: AppSize.s100,
                height: AppSize.s100,
                decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(AppSize.s12)),
                child: Column(
                  children: [
                    SizedBox(
                        height: AppSize.s60,
                        width: AppSize.s60,
                        child: Image.asset('assets/images/sunrise.gif')),
                    Text(
                      AppStrings.sunrise,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      convertTimeToDate(sunrise).hour.toString() +
                          ":" +
                          convertTimeToDate(sunrise).minute.toString() +
                          " AM",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                )),
          ),
          Card(
        elevation: AppSize.s4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)),
            child: Container(
                width: AppSize.s100,
                height: AppSize.s100,
                decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(AppSize.s12)),
                child: Column(
                  children: [
                    SizedBox(
                        height: AppSize.s60,
                        width: AppSize.s60,
                        child: Image.asset('assets/images/sunset.gif')),
                    Text(AppStrings.sunset,
                        style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      convertTimeToDate(sunset).hour.toString() +
                          ":" +
                          convertTimeToDate(sunset).minute.toString() +
                          " PM",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
