import 'package:flutter_appl_weatherapp/features/weather/data/models/weather_model.dart';
import 'package:flutter_appl_weatherapp/features/weather/domain/repositories/weather_repository.dart';

class WeatherUseCase {
  final WeatherRepository weatherRepository;

  WeatherUseCase({required this.weatherRepository});

  Future<WeatherModel> getWeatherInfo({required String location}) async =>
      await weatherRepository.getWeatherInfo(location: location);
}
