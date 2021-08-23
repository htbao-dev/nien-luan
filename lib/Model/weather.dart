import 'dart:convert';

class WeatherInfo {
  final double visibility;
  final Weather weather;
  final Main main;
  final Wind wind;

  WeatherInfo(
      {required this.visibility,
      required this.weather,
      required this.main,
      required this.wind});

  factory WeatherInfo.fromJson(dynamic json) {
    List<dynamic> wt = json["weather"];

    return WeatherInfo(
      weather: Weather.fromJson(wt[0]),
      main: Main.fromJson(json["main"]),
      visibility: json["visibility"] as double,
      wind: Wind.fromJson(json["wind"]),
    );
  }
}

class Weather {
  final String description;
  final String iconId;
  Weather({required this.description, required this.iconId});

  factory Weather.fromJson(dynamic json) {
    return Weather(
      description: json["description"] as String,
      iconId: json["icon"] as String,
    );
  }
}

class Main {
  final double temp;
  final double feels_like;
  final double temp_min;
  final double temp_max;
  final double pressure;
  final double humidity;
  Main(
      {required this.temp,
      required this.feels_like,
      required this.temp_min,
      required this.temp_max,
      required this.pressure,
      required this.humidity});

  factory Main.fromJson(dynamic json) {
    return Main(
      temp: json["temp"] as double,
      feels_like: json["feels_like"] as double,
      temp_min: json["temp_min"] as double,
      temp_max: json["temp_max"] as double,
      pressure: json["pressure"] as double,
      humidity: json["humidity"] as double,
    );
  }
}

class Wind {
  final double speed;
  final double deg;

  Wind({required this.speed, required this.deg});

  factory Wind.fromJson(dynamic json) {
    return Wind(speed: json["speed"] as double, deg: json["deg"] as double);
  }
}
