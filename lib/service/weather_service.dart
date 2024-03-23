//import 'dart:html';

//import 'package:wea_ther/models/weather_model.dart';

import 'dart:convert';
//import 'dart:html';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:wea_ther/models/weather_model.dart';

class WeatherService{
 static const Base_URL= "http://api.openweathermap.org/data/2,5/weather" ;
 final String apiKey;

 WeatherService( this.apiKey);
 Future<Weather> getWeather(String cityname)async{
  final response =await http.get(Uri.parse('$Base_URL?q=$cityname&appid=$apiKey&units=metric'));
  
  if (response.statusCode==200){
    return Weather.fromJson(jsonDecode(response.body));
  }else {
    throw Exception("failed to load weather data");
  }
 }
 Future<String>getCurrentCity()async{
//get permission from user

  LocationPermission permission= await Geolocator.checkPermission();
  if (permission ==LocationPermission.denied){
    permission=await Geolocator.requestPermission();
  }

//fetchbthe current location
Position position = await Geolocator.getCurrentPosition(
  desiredAccuracy: LocationAccuracy.high
);

//connvert the location into a list of placement object

List<Placemark> placemarks =
await placemarkFromCoordinates(position.latitude, position.longitude);
//Extract the city name from the first placement

String? city= placemarks[0].locality;
return city ?? "";


 }
}