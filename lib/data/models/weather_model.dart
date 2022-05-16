class WeatherModel {
  final String name;
  final _Weather weather;
  final _Main main;
  final _Rain? rain;
  final _Wind wind;

  WeatherModel({
    required this.name,
    required this.weather,
    required this.main,
    this.rain,
    required this.wind,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        name: json['name'],
        weather: _Weather.fromJson(json['weather'][0]),
        main: _Main.fromJson(json['main']),
        rain: json['rain'] != null ? _Rain.fromJson(json['rain']) : null,
        wind: _Wind.fromJson(json['wind']),
      );
}

class _Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  _Weather({required this.id, required this.main, required this.description, required this.icon});

  factory _Weather.fromJson(Map<String, dynamic> json) => _Weather(
        id: json['id'] as int,
        main: json['main'] as String,
        description: json['description'] as String,
        icon: json['icon'] as String,
      );
}

class _Main {
  final double temp;
  final int humidity;

  _Main({required this.temp, required this.humidity});

  factory _Main.fromJson(Map<String, dynamic> json) => _Main(
        temp: json['temp'],
        humidity: json['humidity'],
      );
}

class _Rain {
  final double? rain;

  _Rain({this.rain});

  factory _Rain.fromJson(Map<String, dynamic> json) => _Rain(
        rain: double.parse(json['1h'].toString()),
      );
}

class _Wind {
  final double speed;

  _Wind({required this.speed});

  factory _Wind.fromJson(Map<String, dynamic> json) => _Wind(
        speed: json['speed'],
      );
}
