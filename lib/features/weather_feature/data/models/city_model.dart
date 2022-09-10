import '../../domain/entities/city.dart';

class CityModel extends City {
  CityModel({required List< String> country, required List<String> cities})
      : super(country, cities);
  factory CityModel.fromJson(Map<String, dynamic> json) {
   List< String> country =[] ;
    List<String> cities = [];
    if (json['data'] != null) {
      json['data'].forEach((element) {
        country.add(element['country']);
        element['cities'].forEach((city){ cities.add(city);});
       
      });
    }
   return  CityModel(country:  country, cities: cities);

  }
}
