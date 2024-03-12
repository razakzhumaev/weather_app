part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class GetWeatherInfoEvent extends WeatherEvent {
  final String location;

  GetWeatherInfoEvent({required this.location});
}

class RefreshWeatherEvent extends WeatherEvent {}
