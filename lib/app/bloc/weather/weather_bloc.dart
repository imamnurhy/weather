import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/repository/weather_repository.dart';
import '../../../data/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

final WeatherRepository weatherRepository = WeatherRepository();

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<GetWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weatherModel = await weatherRepository.currentWeather(event.lat, event.long);
        emit(WeatherLoaded(weatherModel));
      } catch (e) {
        emit(WeatherError(e.toString()));
      }
    });
  }
}
