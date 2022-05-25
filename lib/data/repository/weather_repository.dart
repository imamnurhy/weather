import 'dart:convert';
import 'dart:developer';

import 'package:network/network.dart';
import 'package:weather/data/models/forecast_weather_model.dart';
import '../constant.dart';
import '../models/weather_model.dart';

class WeatherRepository extends Network {
  Future<WeatherModel> currentWeather(String lat, String long) async {
    try {
      final response = await get(apiUrl + 'weather?lat=$lat&lon=$long&units=metric&appid=$apiKey');
      return WeatherModel.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<ForecastWeatherModel> forecastWeather(String lat, String long) async {
    try {
      final response = await get(apiUrl + 'forecast?lat=$lat&lon=$long&units=metric&appid=$apiKey');
      return ForecastWeatherModel.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  // Future forecash with region
  Future<WeatherModel> forecastWeatherWithRegion(String region) async {
    try {
      final response = await get(apiUrl + 'weather?q=$region&units=metric&appid=$apiKey');
      log(response.body);
      return WeatherModel.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
