import '../../domain/entities/weather_entity.dart';

class WeatherModel extends Weather {
  WeatherModel({
    List<WeatherDetails> hourWeather = const [],
    String? city,
    String? country,
    int? timezone,
    int? sunrise,
    int? sunset,
  }) : super(
            hourWeather: hourWeather,
            city: city,
            country: country,
            timezone: timezone,
            sunrise: sunrise,
            sunset: sunset);
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    List<WeatherDetails> tempWeatherList = [];
    if (json['list'] != null) {
      json['list'].forEach((element) {
        WeatherDetails weatherDetails = WeatherDetails(
                    dt: element['dt'],

          temp:double.parse( element['main']['temp'].toString()),
          feelsLike:double.parse( element['main']['feels_like'] .toString()),
          tempMin:double.parse( element['main']['temp_min'].toString()),
          tempMax:double.parse( element['main']['temp_max'].toString()),
          pressure: element['main']['pressure'],
          humidity: element['main']['humidity'],
          tempKf:element['main']['temp_kf'].toString()  ,
          main: element['weather'][0]['main'],
          description: element['weather'][0]['description'],
          icon: element['weather'][0]['icon'],
          all: element['clouds']['all'],
          speed:double.parse(element['wind']['speed'].toString()) ,
          date: element['dt_txt'],
        );
        tempWeatherList.add(weatherDetails);
      });
    }

    return WeatherModel(
      hourWeather: tempWeatherList,
      city: json['city']['name'],
      country: json['city']['country'],
      sunrise: json['city']['sunrise'],
      sunset: json['city']['sunset'],
      timezone: json['city']['timezone'],
    );
  }
}
