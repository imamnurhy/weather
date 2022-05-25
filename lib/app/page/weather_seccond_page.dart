import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/app/bloc/forecast_weather/forecast_weather_bloc.dart';
import 'package:weather/app/bloc/weather/weather_bloc.dart';

class WeatherSeccondPage extends StatelessWidget {
  const WeatherSeccondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi cuaca'),
      ),
      body: BlocProvider<WeatherBloc>(
        create: (context) => WeatherBloc(),
        child: const _Body(),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  final TextEditingController _controllerRegion = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Widget informasi cuaca
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    log('state: $state');
                    if (state is WeatherLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is WeatherLoaded) {
                      return Flexible(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Suhu
                            Text(
                              '${state.weatherModel.main.temp}°C',
                              style: const TextStyle(
                                fontSize: 80.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // Lokasi
                            Text(
                              state.weatherModel.name,
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state is WeatherError) {
                      return Center(
                        child: Text(
                          state.error,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else {
                      return Flexible(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            // Suhu
                            Text(
                              '0°C',
                              style: TextStyle(
                                fontSize: 110.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // Lokasi
                            Text(
                              '-',
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),

                // Widget untuk mengubah lokasi
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      // Input field untuk mengubah lokasi
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _controllerRegion,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Masukkan lokasi',
                          ),
                        ),
                      ),

                      // Button untuk mengubah lokasi
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            child: const Text('Ubah lokasi'),
                            onPressed: () => {
                              BlocProvider.of<WeatherBloc>(context)..add(GetWeatherWithRegion(_controllerRegion.text)),
                              // unfocus the keyboard
                              FocusScope.of(context).unfocus(),
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
