import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nien_luan/Model/weather_info.dart';
import 'package:nien_luan/Provider/weather_provider.dart';
import 'package:provider/provider.dart';

import '../../../common.dart';

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        child: home(context),
      ),
    );
  }

  Widget home(BuildContext context) {
    WeatherInfo? weatherInfo = context.watch<WeatherProvider>().weatherInfo;
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
      child: Column(
        children: [
          topBar(weatherInfo!.cloud.all, weatherInfo.wind.speed,
              weatherInfo.main.humidity),
          Spacer(flex: 3,),
          showTemperature(weatherInfo.main.temp, weatherInfo.main.feels_like),
          Spacer(flex: 1,),
          showCityName_Description(weatherInfo.name, weatherInfo.weather.description),
          Spacer(flex: 4,),
          Container(
            margin: EdgeInsets.only(bottom: 100),
            child: showIcon(weatherInfo.weather.iconId),
          ),
          Spacer(flex: 6,)
        ],
      ),
    );
  }

  Widget topBar(double cloud, double windSpeed, double humidity) {
    String _cloud = cloud.toStringAsFixed(1);
    String _windSpeed = windSpeed.toStringAsFixed(1);
    String _humidity = humidity.toStringAsFixed(1);
    double size = 18.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.cloud_outlined, size: size,),
            Text("${_cloud}%", style: TextStyle(fontSize: size),),
          ],
        ),
        Row(children: [Text("Sức gió: ", style: TextStyle(fontSize: size)), Text("${_windSpeed}m/s", style: TextStyle(fontSize: size))]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.water, size: size,), Text("${_humidity}%", style: TextStyle(fontSize: size))],
        )
      ],
    );
  }

  Widget showTemperature(double temp, double feels_like){
    var _temp =  temp.toStringAsFixed(1);
    var _feels_like = feels_like.toStringAsFixed(1);
    return Container(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Wrap(
            direction: Axis.horizontal,
            children: [
              Text("${_temp}", style: TextStyle(fontSize: 70),),
              Text(Common.CELSIUS_DEGREES_SYMBOL, style: TextStyle(fontSize: 24),)
            ],
          ),
          Wrap(
            children: [
              Text("Cảm giác: ${_feels_like}", style: TextStyle(fontSize: 16),),
              Text(Common.CELSIUS_DEGREES_SYMBOL),
            ],
          )
        ],
      ),
    );
  }

  Widget showCityName_Description(String cityName, String description){
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(cityName),
        Text(description)
      ],
    );
  }

  Widget showIcon(String iconId){
    return Image.network(Common.getWeatherIconUrl(iconId), scale: 0.5,);
  }
}
