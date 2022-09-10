import 'package:flutter/material.dart';
import 'package:wheather_app/core/resources/color_manager.dart';
import 'package:wheather_app/core/resources/value_manger.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard(
      {Key? key,
      required this.temp,
      required this.feelLikeTemp,
      required this.description})
      : super(key: key);
  final String temp;
  final String feelLikeTemp;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.24,
      width: double.infinity,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.19,
            decoration: BoxDecoration(
                color: ColorManager.cyan,
                borderRadius: BorderRadius.circular(AppSize.s16)),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: AppPadding.p8, right: AppPadding.p12),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        temp,
                        style: TextStyle(
                            color: ColorManager.white,
                            fontSize: AppSize.s40,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text(
                    'Feels like ' + feelLikeTemp,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -AppSize.s8,
            left: AppSize.s0,
            bottom: AppSize.s50,
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                width: AppSize.s150,
                child: Image.asset(
                  'assets/images/sun.gif',
                )),
          )
        ],
      ),
    );
  }
}
