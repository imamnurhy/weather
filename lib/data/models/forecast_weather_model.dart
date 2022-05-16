class ForecastWeatherModel {
  final List<_Days> days;

  ForecastWeatherModel({required this.days});

  factory ForecastWeatherModel.fromJson(Map<String, dynamic> json) {
    return ForecastWeatherModel(
      days: List<_Days>.from(json['list'].map((x) => _Days.fromJson(x))),
    );
  }
}

class _Days {
  final DateTime dt;
  final double temp;
  final String icon;

  _Days({required this.dt, required this.temp, required this.icon});

  factory _Days.fromJson(Map<String, dynamic> json) => _Days(
        dt: DateTime.parse(json['dt_txt']),
        temp: double.parse(json['main']['temp'].toString()),
        icon: json['weather'][0]['icon'],
      );
}
