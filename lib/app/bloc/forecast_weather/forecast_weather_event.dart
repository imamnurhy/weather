part of 'forecast_weather_bloc.dart';

@immutable
abstract class ForecastWeatherEvent {}

class GetForecastWeather extends ForecastWeatherEvent {
  final String lat;
  final String long;

  GetForecastWeather(this.lat, this.long);
}
