import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wheather_app/core/resources/value_manger.dart';
import 'package:wheather_app/core/utils/methods.dart';
import 'package:wheather_app/features/weather_feature/presentation/bloc/weather_bloc.dart';
import 'package:wheather_app/features/weather_feature/presentation/widgets/drawer.dart';
import 'package:wheather_app/features/weather_feature/presentation/widgets/sunrise_sunset_card.dart';
import 'package:wheather_app/features/weather_feature/presentation/widgets/weather_card.dart';
import 'package:wheather_app/features/weather_feature/presentation/widgets/week_details.dart';

import '../widgets/chart.dart';
import '../widgets/weather_details.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  var animation;

  var controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      print(state.toString());
      if (state is LoadingWeatherState) {
        return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()));
      } else if (state is ErrorWeatherState) {
        return Scaffold(body: Center(child: Text(state.message,
        style: Theme.of(context).textTheme.headlineLarge,
        ),));
      } else if (state is LoadedWeathersState) {
        return SafeArea(
            child: Scaffold(
          drawer: MyDrawer(
            weather: state.weather,
          ),
          body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innnerBoxIsScrolled) {
                if (innnerBoxIsScrolled) {
                  /* Animation */
                  controller = AnimationController(
                    vsync: this,
                    duration: const Duration(
                      seconds: 1,
                    ),
                  );
                  animation = Tween(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(controller);
                  /* Animation */
                  controller.forward();
                }
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 80.0,
                    floating: false,
                    pinned: true,
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    titleSpacing: 0.0,
                    toolbarHeight: (innnerBoxIsScrolled == true) ? 60.0 : 10.0,
                    centerTitle: false,
                    elevation: 0.0,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (innnerBoxIsScrolled == true)
                          Padding(
                            padding: const EdgeInsets.only(left:AppPadding.p40),
                            child: FadeTransition(
                              opacity: animation,
                              child: Column(children: [
                                Text('${state.weather.city}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge),
                              ]),
                            ),
                          ),
                      ],
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: false,
                      titlePadding: const EdgeInsets.all(0),
                      title: IconButton(
                          onPressed: () {
                            if (Scaffold.of(context).isDrawerOpen) {
                              Scaffold.of(context).closeDrawer();
                            } else if (!Scaffold.of(context).isDrawerOpen) {
                              Scaffold.of(context).openDrawer();
                            }
                          },
                          icon: Icon(Icons.menu,size: AppSize.s20,)),
                      background: Container(
                        width: MediaQuery.of(context).size.width,
                        // child: MyDrawer(
                        //   weather: state.weather,
                        // ),
                      ),
                    ),
                  ),
                ];
              },
              body: Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${state.weather.city}',
                          style: Theme.of(context).textTheme.headlineLarge),
                      Text('${state.weather.country}',
                          style: Theme.of(context).textTheme.headlineLarge),
                      Text(
                          DateFormat('EEEE, d MMM').format(
                            convertTimeToDate(
                              state.weather.hourWeather[0].dt,
                            ),
                          ),
                          style: Theme.of(context).textTheme.titleMedium),
                      WeatherCard(
                        temp:
                            '${state.weather.hourWeather[0].temp!.ceil()}' '°',
                        feelLikeTemp:
                            '${state.weather.hourWeather[0].feelsLike!.ceil()}'
                            '°',
                        description: state.weather.hourWeather[0].description!,
                      ),
                      const SizedBox(
                        height: AppSize.s18,
                      ),
                      Text(
                        'Today',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(
                        height: AppSize.s8,
                      ),
                      // TempChart(
                      //   dayWeather: state.weather.hourWeather,
                      // ),
                      // DayWeather(
                      //   dayWeather: state.weather.hourWeather,
                      // ),
                      SizedBox(
                        width: double.infinity,
                        child: LineChartSample5(
                          dayWeather: state.weather.hourWeather,
                        )),
                      const SizedBox(
                        height: AppSize.s18,
                      ),
                        SunsetSunriseCard(
                          sunrise: state.weather.sunrise!,
                          sunset: state.weather.sunset!),
                      WeatherDetails(
                        humidity:
                            ' ${state.weather.hourWeather[0].humidity!} %',
                        uv: '${state.weather.hourWeather[0].all!} %',
                        wind: ' ${state.weather.hourWeather[0].speed!} km/h',
                      ),
                     
                      Text(
                        'Next five days',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(
                        height: AppSize.s8,
                      ),
                      WeekDetails(weatherDetails: state.weather.hourWeather),
                    
                    ],
                  ),
                ),
              )),
        ));
      }
      return Scaffold(
          appBar: AppBar(),
          body: const Center(child: CircularProgressIndicator()));
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
