import 'package:flutter/material.dart';
import 'package:nien_luan/Model/weather.dart';
import 'package:nien_luan/Provider/weather_provider.dart';
import 'package:provider/provider.dart';

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: home(context),
      ),
    );
  }

  Widget home(BuildContext context) {
    WeatherInfo? weatherInfo = context.watch<WeatherProvider>().weatherInfo;
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
      ),
    );
  }
}
