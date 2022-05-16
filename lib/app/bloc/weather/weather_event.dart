part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class GetWeather extends WeatherEvent {
  final String lat;
  final String long;

  GetWeather(this.lat, this.long);
}
