// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_appl_weatherapp/features/weather/data/models/weather_model.dart';
import 'package:flutter_appl_weatherapp/features/weather/domain/use_cases/weather_use_case.dart';
import 'package:flutter_appl_weatherapp/internal/helpers/catch_exception.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherUseCase weatherUseCase;

  WeatherBloc(this.weatherUseCase) : super(WeatherInitialState()) {
    on<GetWeatherInfoEvent>((event, emit) async {
      emit(WeatherLoadingState());
      try {
        final WeatherModel weatherModel =
            await weatherUseCase.getWeatherInfo(location: event.location);

        emit(WeatherLoadedState(weatherModel: weatherModel));
      } catch (e) {
        log('kljhvgcfvjbkjbnkhvgchvj');
        emit(WeatherErrorState(error: CatchException.convertException(e)));
      }
    });
  }
}
