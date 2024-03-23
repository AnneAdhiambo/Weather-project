import 'package:flutter/material.dart';
import 'package:wea_ther/models/weather_model.dart';
import 'package:wea_ther/service/weather_service.dart';
class screen1 extends StatefulWidget {
  const screen1({super.key});

  @override
  State<screen1> createState() => _screen1State();
}


class _screen1State extends State<screen1> {

  //api key
final _weatherservice=WeatherService("564afe98348983cb8b6c5da99c03f33a");
Weather?_weather;
  //fetch weather
_fetchWeather()async{
//get the current city
String cityname= await _weatherservice.getCurrentCity();


//get weather from city

try{
  final weather = await _weatherservice.getWeather(cityname);
  setState(() {
    _weather =weather;
  });
}
//any error
catch (e){
  print(e);
}
}
  //weather animation
//in itstate

  @override
  void initState(){
    super.initState();
    //Fetch weather on startup
    _fetchWeather();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather  App",
      style: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold
      ),
      ),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //cityname
            Text(_weather?.cityname ?? "loading city..."),
            //temperature
            Text('${_weather?.temperature.toString()}\u00B0 Celsius')
          ],
        ),
      ),

    );
  }
}