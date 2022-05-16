import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather/data/constant.dart';
import 'package:weather_icons/weather_icons.dart';
import '../bloc/weather/weather_bloc.dart';
import '../bloc/forecast_weather/forecast_weather_bloc.dart';
import '../utilities/constant.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (context) => WeatherBloc(),
        ),
        BlocProvider<ForecastWeatherBloc>(
          create: (context) => ForecastWeatherBloc(),
        ),
      ],
      child: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  Position? position;
  String lat = '-6.3525141';
  String lon = '106.6955019';

  @override
  void initState() {
    _checkPermission();

    super.initState();
  }

  void _getCurrentLocation() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      lat = position?.latitude.toString() ?? lat;
      lon = position?.longitude.toString() ?? lon;
    });
  }

  void _checkPermission() async {
    final permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always) {
      _getCurrentLocation();
    } else {
      final permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.always) {
        _getCurrentLocation();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Info Weather now
              _WeatherCurrent(
                latitude: lat,
                longitude: lon,
              ),

              // Detail Weather
              _WeatherDetail(
                latitude: lat,
                longitude: lon,
              ),

              // Weather Forecast
              _WeatherForecast(
                latitude: lat,
                longitude: lon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeatherCurrent extends StatefulWidget {
  final String latitude;
  final String longitude;

  const _WeatherCurrent({Key? key, required this.latitude, required this.longitude}) : super(key: key);

  @override
  State<_WeatherCurrent> createState() => __WeatherCurrentState();
}

class __WeatherCurrentState extends State<_WeatherCurrent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(color: accentColor, borderRadius: BorderRadius.circular(25)),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          bloc: WeatherBloc()..add(GetWeather(widget.latitude, widget.longitude)),
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WeatherLoaded) {
              return Column(
                children: [
                  // App Name
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Weather App',
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Weather Info
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, right: 25, left: 25),
                    child: Row(
                      children: [
                        Text(
                          'Today',
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        const Spacer(),
                        const Text(''),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 25, left: 25),
                    child: Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: state.weatherModel.main.temp.toStringAsFixed(0),
                                style: GoogleFonts.poppins(fontSize: 70, color: Colors.white),
                              ),
                              TextSpan(
                                text: '°C',
                                style: GoogleFonts.rubik(
                                  fontSize: 70,
                                  color: selectedColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        // Weather Icon
                        Image.network(
                          iconUrl + state.weatherModel.weather.icon + '.png',
                          scale: 0.5,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, right: 25, left: 25, bottom: 20),
                    child: Row(
                      children: [
                        Icon(
                          const IconData(
                            0xf193,
                            fontFamily: 'MaterialIcons',
                          ),
                          color: selectedColor,
                        ),
                        Expanded(
                          child: Text(
                            state.weatherModel.name,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.rubik(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            } else if (state is WeatherError) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text('Unknown State'),
              );
            }
          },
        ),
      ),
    );
  }
}

class _WeatherDetail extends StatefulWidget {
  final String latitude;
  final String longitude;

  const _WeatherDetail({Key? key, required this.latitude, required this.longitude}) : super(key: key);

  @override
  State<_WeatherDetail> createState() => __WeatherDetailState();
}

class __WeatherDetailState extends State<_WeatherDetail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(color: accentColor, borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocBuilder<WeatherBloc, WeatherState>(
            bloc: WeatherBloc()..add(GetWeather(widget.latitude, widget.longitude)),
            builder: (context, state) {
              if (state is WeatherLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WeatherLoaded) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Icon(
                            WeatherIcons.strong_wind,
                            color: selectedColor,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            '${state.weatherModel.wind.speed} Km/h',
                            style: GoogleFonts.rubik(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Icon(
                            WeatherIcons.humidity,
                            color: selectedColor,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            '${state.weatherModel.main.humidity}%',
                            style: GoogleFonts.rubik(fontSize: 15, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: state.weatherModel.rain != null,
                      child: Expanded(
                        child: Column(
                          children: [
                            Icon(
                              WeatherIcons.rain,
                              color: selectedColor,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${state.weatherModel.rain?.rain} mm',
                              style: GoogleFonts.rubik(fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is WeatherError) {
                return Center(
                  child: Text(
                    state.error,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text('Unknown State'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _WeatherForecast extends StatefulWidget {
  final String latitude;
  final String longitude;

  const _WeatherForecast({Key? key, required this.latitude, required this.longitude}) : super(key: key);

  @override
  State<_WeatherForecast> createState() => __WeatherForecastState();
}

class __WeatherForecastState extends State<_WeatherForecast> {
  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return SizedBox(
      height: screensize.height / 4.5,
      width: double.infinity,
      child: BlocBuilder<ForecastWeatherBloc, ForecastWeatherState>(
        bloc: ForecastWeatherBloc()..add(GetForecastWeather(widget.latitude, widget.longitude)),
        builder: (context, state) {
          if (state is ForecastWeatherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ForecastWeatherLoaded) {
            return ListView.builder(
              itemCount: state.forecastWeatherModel.days.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: screensize.width / 3,
                    decoration: BoxDecoration(color: accentColor, borderRadius: BorderRadius.circular(25)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Image.network(
                              iconUrl + '${state.forecastWeatherModel.days[index].icon}.png',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              DateFormat('h:mm a').format(state.forecastWeatherModel.days[index].dt),
                              style: GoogleFonts.rubik(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: state.forecastWeatherModel.days[index].temp.toStringAsFixed(0),
                                    style: GoogleFonts.rubik(
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "°C",
                                    style: GoogleFonts.rubik(
                                      fontSize: 15,
                                      color: selectedColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is ForecastWeatherError) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Unknown State'),
            );
          }
        },
      ),
    );
  }
}
