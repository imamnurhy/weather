import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/forecast_weather_model.dart';
import '../../../data/repository/weather_repository.dart';

part 'forecast_weather_event.dart';
part 'forecast_weather_state.dart';

final WeatherRepository weatherRepository = WeatherRepository();

class ForecastWeatherBloc extends Bloc<ForecastWeatherEvent, ForecastWeatherState> {
  ForecastWeatherBloc() : super(ForecastWeatherInitial()) {
    on<GetForecastWeather>((event, emit) async {
      emit(ForecastWeatherLoading());

      try {
        final forecastModel = await weatherRepository.forecastWeather(event.lat, event.long);
        emit(ForecastWeatherLoaded(forecastModel));
      } catch (e) {
        emit(ForecastWeatherError(e.toString()));
      }
    });
  }
}
