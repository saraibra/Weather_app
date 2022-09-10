import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheather_app/core/resources/value_manger.dart';
import 'package:wheather_app/core/utils/methods.dart';
import 'package:wheather_app/features/weather_feature/presentation/bloc/weather_bloc.dart';
import 'package:wheather_app/features/weather_feature/presentation/widgets/cities_list.dart';
import 'package:wheather_app/features/weather_feature/presentation/widgets/search_item.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/string_manager.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:Text('Search')
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(AppSize.s28),
          child:
              BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.addCity,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: AppSize.s8,
                ),
                SizedBox(
                  width: double.infinity,
                  height: AppSize.s40,
                  child: InkWell(
                    onTap: () => showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (context) {
                          return const SearchItem();
                        }),
                    child: TextFormField(
                      enabled: false,
                      controller: BlocProvider.of<WeatherBloc>(context)
                          .searchController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(AppSize.s12),
                        hintText: AppStrings.enterPlaceName,
                        prefix: Icon(Icons.search_sharp,
                            size: AppSize.s16, color: ColorManager.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s12,
                ),
                Text(
                  AppStrings.topCities,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: AppSize.s8,
                ),
             
               
              
                CitiesList(
                    citiesList:
                        BlocProvider.of<WeatherBloc>(context).worldCitiesList),
              ],
            );
          }),
        ),
      ),
    );
  }
}
