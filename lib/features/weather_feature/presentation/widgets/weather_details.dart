import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/value_manger.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails(
      {Key? key, required this.uv, required this.wind, required this.humidity})
      : super(key: key);
  final String uv;
  final String wind;
  final String humidity;
  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'assets/images/clouds.gif',
      'assets/images/wind.gif',
      'assets/images/humidity.gif'
    ];
    List<String> titles = [uv, wind, humidity];
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.18,
      
        child: Padding(
          padding: const EdgeInsets.only(left:20.0),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Column(
                    children: [
                      Card(
                        elevation: AppSize.s4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s12)),
                        child: Container(
                            width: AppSize.s80,
                            height: AppSize.s80,
                            decoration: BoxDecoration(
                                color: ColorManager.white,
                                borderRadius: BorderRadius.circular(AppSize.s18)),
                            child: Image.asset(images[index])),
                      ),
                      Text(
                        titles[index],
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
              separatorBuilder: (context, index) => const SizedBox(
                    width: AppSize.s12,
                  ),
              itemCount: 3),
        ));
  }
}
