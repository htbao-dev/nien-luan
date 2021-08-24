import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nien_luan/Model/weather_info.dart';

import '../common.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherInfo? _weatherInfo = null;

  WeatherInfo? get weatherInfo {
    if (_weatherInfo == null) {
      queryCurrentWeather();
    }
    return _weatherInfo;
  }

  void queryCurrentWeather({String CityId = Common.HUE_CITY_ID}) async {
    var uri = Uri.parse(Common.WEATHER_HOST_NAME +
        "weather?id=${CityId}&appid=${Common.WEATHER_API_KEY}");

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      _weatherInfo = WeatherInfo.fromJson(parsed);
    } else {
      _weatherInfo = null;
      print("fails");
    }
    notifyListeners();
  }
}
