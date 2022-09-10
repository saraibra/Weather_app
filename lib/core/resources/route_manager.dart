import 'package:flutter/material.dart';
import 'package:wheather_app/core/resources/string_manager.dart';

class Routes {
  static const String mainRoute = "/";
  static const String addTask = "/addTask";
    static const String schedule = "/schedule";


}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.splashRoute:
      //   return MaterialPageRoute(builder: (_) => const SplashView());
    
      // case Routes.mainRoute:
      //   return MaterialPageRoute(builder: (_) => const MainScreen());
      // case Routes.addTask:
      //   return MaterialPageRoute(builder: (_) =>  AddTask());
        //  case Routes.schedule:
        // return MaterialPageRoute(builder: (_) =>  ScheduleView());
      default:
        return unDefinedRoute();
    }
  }
  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
