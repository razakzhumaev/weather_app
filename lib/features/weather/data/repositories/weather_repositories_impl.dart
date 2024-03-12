import 'package:dio/dio.dart';
import 'package:flutter_appl_weatherapp/features/weather/data/models/weather_model.dart';
import 'package:flutter_appl_weatherapp/features/weather/domain/repositories/weather_repository.dart';
import 'package:flutter_appl_weatherapp/internal/helpers/api_requester.dart';
import 'package:flutter_appl_weatherapp/internal/helpers/catch_exception.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<WeatherModel> getWeatherInfo({required String location}) async {
    try {
      Response response = await apiRequester.toGet(
        'data/2.5/weather',
        params: {
          'q': location,
          'appid': 'd0617a5c2dca461ecff826af2453a679',
        },
      );
      print('getWeatherInfo result == ${response.data}');

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      }
      throw response;
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
