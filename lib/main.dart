import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheather_app/features/weather_feature/presentation/screens/home_screen.dart';
import 'package:wheather_app/features/weather_feature/presentation/screens/on_boarding.dart';
import 'core/network/cashe_helper.dart';
import 'core/resources/theme_manager.dart';
import 'core/services/service_locator.dart' as di;
import 'features/weather_feature/presentation/bloc/weather_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await CasheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              di.sl<WeatherBloc>()..add(GetTodayWeatherEvent())
            ..add(GetallCitiesEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: getApplicationTheme(),
        home:  OnBoardingScreen(),
      ),
    );
  }
}
