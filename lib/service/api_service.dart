import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/models/weather_model.dart';

class ApiService {
  static Future<WeatherModel> getWeatherApi(String cityName) async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=0254036d7610d1672b9d5b54ef490267");
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(responseBody);
    } else if (response.statusCode == 404) {
      throw Exception('City not found');
    } else {
      throw Exception(
          'Failed to load weather data with Error: ${response.statusCode}');
    }
  }
}
