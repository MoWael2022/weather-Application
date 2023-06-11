import 'dart:convert';

import 'package:http/http.dart' as http;
import '../constant/StringManager.dart';

import 'model.dart';

class FetchWeatherData {
  static Future<Weather?> weatherData(String countryName) async {
    http.Response response =
    await http.get(Uri.parse("${StringManager.apiData + countryName+StringManager.NumofDays}"));
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      Weather weatherData = Weather.fromjson(body);
      return weatherData;
    } else {
      return null;
    }
  }
}
