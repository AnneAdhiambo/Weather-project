class Weather{
  final String cityname;
  final String temperature;
  final String maincondition;
  Weather({
    required this.cityname,
    required this.temperature,
    required this.maincondition,
  });
  factory Weather.fromJson(Map<String,dynamic> json){
    return Weather(
      cityname: json["name"], 
      temperature: json["main"]["Temp"].todouble(),
      maincondition: json ["weather"][0]["main"],
    );
  }
}