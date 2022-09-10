const String apiKey = 'df506fd42a9bbbb8f53dc01eda064971';
const String baseUrl = 'https://api.openweathermap.org/data/2.5';
 String selectedUnit = 'metric';
double latitude = 0.0;
double longitude = 0.0;

String cityAndCountryEndPoint ='https://countriesnow.space/api/v0.1/countries';
String cityEndPoint ='$baseUrl/forecast?q=';
String weatherByCityEndPoint = '&exclude=hourly&appid=$apiKey&units=$selectedUnit&lang=en';
