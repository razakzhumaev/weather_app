import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appl_weatherapp/features/weather/data/models/weather_model.dart';
import 'package:flutter_appl_weatherapp/features/weather/data/repositories/weather_repositories_impl.dart';
import 'package:flutter_appl_weatherapp/features/weather/domain/use_cases/weather_use_case.dart';
import 'package:flutter_appl_weatherapp/features/weather/presentation/logic/bloc/weather_bloc.dart';
import 'package:flutter_appl_weatherapp/internal/helpers/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class WeatherInfoScreen extends StatefulWidget {
  final WeatherModel weatherModel;

  const WeatherInfoScreen({Key? key, required this.weatherModel})
      : super(key: key);

  @override
  State<WeatherInfoScreen> createState() => _WeatherInfoScreenState();
}

class _WeatherInfoScreenState extends State<WeatherInfoScreen> with Utils {
  final WeatherBloc weatherBloc =
      WeatherBloc(WeatherUseCase(weatherRepository: WeatherRepositoryImpl()));

  @override
  void initState() {
    weatherBloc
        .add(GetWeatherInfoEvent(location: widget.weatherModel.name ?? ''));
    super.initState();
  }

  Widget weatherId(int id) {
    switch (id) {
      case >= 200 && < 300:
        return Lottie.asset('assets/images/Animation groza.json');
      case >= 500 && < 600:
        return Lottie.asset('assets/images/AnimationRain.json');
      case >= 600 && < 700:
        return Lottie.asset('assets/images/Animation Snow.json');
      case == 800:
        return Lottie.asset('assets/images/Animation sun.json');
      case >= 801 && < 900:
        return Lottie.asset('assets/images/Animation Cloud.json');

      default:
        return Lottie.asset('assets/images/Animation sun.json');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff673AB7),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffffAB40),
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 100.0,
                  sigmaY: 100.0,
                ),
                child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  bloc: weatherBloc,
                  builder: (context, state) {
                    if (state is WeatherLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is WeatherErrorState) {
                      return ElevatedButton(
                        onPressed: () {
                          weatherBloc.add(
                            GetWeatherInfoEvent(
                              location: widget.weatherModel.name ?? '',
                            ),
                          );
                        },
                        child: Text('Try Again'),
                      );
                    }
                    if (state is WeatherLoadedState) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          weatherBloc.add(
                            GetWeatherInfoEvent(
                              location: state.weatherModel.name ?? '',
                            ),
                          );
                        },
                        child: ListView(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${widget.weatherModel.name ?? ''}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Text(
                                      "(${widget.weatherModel.sys?.country ?? ''})",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Spacer(),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Current time:  ',
                                        style: TextStyle(color: Colors.white),
                                        children: [
                                          TextSpan(
                                            text: "${formatTime(
                                              state.weatherModel.dt ?? 0,
                                              state.weatherModel.timezone ?? 0,
                                            )}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                weatherId(widget.weatherModel.weather?[0].id ??
                                    0), // анимация
                                Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        "${Utils.kelvinToCelsius(widget.weatherModel.main?.tempMin)?.toStringAsFixed(1) ?? ''}°C",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 55,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${widget.weatherModel.weather?[0].description?.toUpperCase() ?? ''}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "${Utils.formatDate(widget.weatherModel.dt ?? 0)}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/11.png',
                                          scale: 8,
                                        ),
                                        SizedBox(width: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Sunrise',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            SizedBox(height: 3),
                                            Text(
                                              '${Utils.formatDateTime(widget.weatherModel.sys?.sunrise)}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/12.png',
                                          scale: 8,
                                        ),
                                        SizedBox(width: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Sunset',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            SizedBox(height: 3),
                                            Text(
                                              '${Utils.formatDateTime(widget.weatherModel.sys?.sunrise)}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0),
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/13.png',
                                          scale: 8,
                                        ),
                                        SizedBox(width: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Temp Max',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            SizedBox(height: 3),
                                            Text(
                                              "${Utils.kelvinToCelsius(widget.weatherModel.main?.tempMax)?.toStringAsFixed(1) ?? ''}°C",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/14.png',
                                          scale: 8,
                                        ),
                                        SizedBox(width: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Temp Min',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            SizedBox(height: 3),
                                            Text(
                                              "${Utils.kelvinToCelsius(widget.weatherModel.main?.tempMin)?.toStringAsFixed(1) ?? ''}°C",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            // Text("Weather ID: ${widget.weatherModel.weather?[0]?.id ?? 'N/A'}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    return Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.amber,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
