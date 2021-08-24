class WeatherInfo {
  final double visibility;
  final String name;
  final Weather weather;
  final Main main;
  final Wind wind;
  final Cloud cloud;

  WeatherInfo({
    required this.visibility,
    required this.weather,
    required this.main,
    required this.wind,
    required this.cloud,
    required this.name,
  });

  factory WeatherInfo.fromJson(dynamic json) {
    List<dynamic> wt = json["weather"];
    print(json["name"]);
    return WeatherInfo(
        weather: Weather.fromJson(wt[0]),
        main: Main.fromJson(json["main"]),
        visibility: double.parse(json["visibility"].toString()),
        wind: Wind.fromJson(json["wind"]),
        cloud: Cloud.fromJson(json["clouds"]),
        name: json["name"]);
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
      temp: double.parse(json["temp"].toString()) - 272.15,
      feels_like: double.parse(json["feels_like"].toString()) - 272.15,
      temp_min: double.parse(json["temp_min"].toString()) - 272.15,
      temp_max: double.parse(json["temp_max"].toString()) - 272.15,
      pressure: double.parse(json["pressure"].toString()),
      humidity: double.parse(json["humidity"].toString()),
    );
  }
}

class Wind {
  final double speed;
  final double deg;

  Wind({required this.speed, required this.deg});

  factory Wind.fromJson(dynamic json) {
    return Wind(
        speed: double.parse(json["speed"].toString()),
        deg: double.parse(json["deg"].toString()));
  }
}

class Cloud {
  final double all;
  Cloud({required this.all});

  factory Cloud.fromJson(dynamic json) =>
      Cloud(all: double.parse(json["all"].toString()));
}
