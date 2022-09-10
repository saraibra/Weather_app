import 'package:flutter/material.dart';

import '../../../../core/resources/value_manger.dart';

class DayWeatherItem extends StatelessWidget {
  const DayWeatherItem(
      {Key? key,
      required this.color,
      required this.image,
      required this.temp,
      required this.time})
      : super(key: key);
  final Color color;
  final String image;
  final String temp;
  final String time;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
         height: AppSize.s140,
        width: AppSize.s100,
      child: Card(
        elevation: AppSize.s4,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s28)
        ),
        child: Container(
       
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(AppSize.s28)),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: AppSize.s50, child: Image.asset(image)),
                Text(
                  temp,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
