import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheather_app/core/resources/value_manger.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../bloc/weather_bloc.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration:  BoxDecoration(
            color: ColorManager.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSize.s28),
              topRight: Radius.circular(AppSize.s28),
            )
          ),
          height:MediaQuery.of(context).size.height*0.92,
          child: Padding(
              padding: const EdgeInsets.only(top:AppPadding.p20,left:AppPadding.p12,right:AppPadding.p12 ),
              child: Column(
                children: [
                  TextFormField(
                    controller:
                        BlocProvider.of<WeatherBloc>(context).searchController,
                    onChanged: (v) {
                      BlocProvider.of<WeatherBloc>(context).add(SearchCitiesEvent());
                    },
                    decoration: InputDecoration(
        
                      contentPadding: const EdgeInsets.all(AppSize.s14),
                      hintText: AppStrings.enterPlaceName,
                      prefix: Icon(Icons.search_sharp,
                          size: AppSize.s16, color: ColorManager.grey),
                    ),
                  ),
                  BlocConsumer<WeatherBloc, WeatherState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Expanded(
                          child: ListView.separated(
                            itemCount: BlocProvider.of<WeatherBloc>(context)
                                .searchResult
                                .length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  BlocProvider.of<WeatherBloc>(context).add(
                                      GetCityWeatherEvent(
                                          index: 0,
                                          context: context,
                                          city: BlocProvider.of<WeatherBloc>(context)
                                              .searchResult[index]));
                                },
                                child: Container(
                                  child: Text(BlocProvider.of<WeatherBloc>(context)
                                      .searchResult[index],style: Theme.of(context).textTheme.headlineLarge,),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => const SizedBox(
                              height: AppSize.s12,
                              child: Divider(),
                            ),
                          ),
                        );
                      }),
                ],
              ),
          
          ),
        ),
      ],
    );
  }
}
