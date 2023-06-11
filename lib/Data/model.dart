class Weather {
  final String name;
  final double maxTemp;
  final double minTemp;
  final double temp;
  final dynamic condition;
  final dynamic conditionImage;
  final List<dynamic> hours;
  final List<dynamic>days;

  final String time;

  Weather(
      {required this.name,
        required this.conditionImage,
        required this.maxTemp,
        required this.minTemp,
        required this.temp,
        required this.condition,
        required this.time,
        required this.hours,
        required this.days
      });

  factory Weather.fromjson(Map<String, dynamic> json) {
    return Weather(
      name: json['location']['name'],
      maxTemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
      minTemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
      temp: json['current']['temp_c'],
      condition: json['current']['condition']['text'],
      time: json['location']['localtime'],
      conditionImage: json['current']['condition']['icon'],
      hours: json['forecast']['forecastday'][0]['hour'],
      days : json['forecast']['forecastday'],
    );
  }
}
