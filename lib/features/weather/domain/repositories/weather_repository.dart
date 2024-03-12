import 'package:flutter_appl_weatherapp/features/weather/data/models/weather_model.dart';

abstract class WeatherRepository {
  ///RU : Получение информации о погоде
  ///
  ///ENG: Getting information about weather
  Future<WeatherModel> getWeatherInfo({required String location});
}
