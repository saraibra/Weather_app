import 'package:equatable/equatable.dart';

class City extends Equatable {
  final List<String> country;
  final List<String> cities;

  City(this.country, this.cities);
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}