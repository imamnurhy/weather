part of 'forecast_weather_bloc.dart';

@immutable
abstract class ForecastWeatherState {}

class ForecastWeatherInitial extends ForecastWeatherState {}

class ForecastWeatherLoading extends ForecastWeatherState {}

class ForecastWeatherLoaded extends ForecastWeatherState {
  final ForecastWeatherModel forecastWeatherModel;

  ForecastWeatherLoaded(this.forecastWeatherModel);
}

class ForecastWeatherError extends ForecastWeatherState {
  final String error;

  ForecastWeatherError(this.error);
}
