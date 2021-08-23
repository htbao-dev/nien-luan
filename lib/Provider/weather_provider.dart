import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nien_luan/Model/weather.dart';

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
      // print(response.body);
      String body =
          '{"coord":{"lon":107.5833,"lat":16.3333},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"base":"stations","main":{"temp":308.7,"feels_like":314.74,"temp_min":308.7,"temp_max":308.7,"pressure":1003,"humidity":49},"visibility":10000,"wind":{"speed":5.14,"deg":70},"clouds":{"all":40},"dt":1629705735,"sys":{"type":1,"id":9310,"country":"VN","sunrise":1629671723,"sunset":1629716984},"timezone":25200,"id":1565033,"name":"Tinh Thua Thien-Hue","cod":200}';

      final parsed = jsonDecode(body);
      _weatherInfo = WeatherInfo.fromJson(parsed);
    } else {
      _weatherInfo = null;
      print("fails");
    }
    notifyListeners();
  }
}
