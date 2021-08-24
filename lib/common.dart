class Common {
  static const String WEATHER_HOST_NAME =
      "http://api.openweathermap.org/data/2.5/";
  static const String WEATHER_API_KEY = "36eaaed6e133045427b062a8e6ed573d";
  static const String HUE_CITY_ID = "1565033";
  static const String CELSIUS_DEGREES_SYMBOL = "\u2103";
  static String getWeatherIconUrl(String iconId){
    return "http://openweathermap.org/img/wn/${iconId}@2x.png";
  }
}
