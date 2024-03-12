import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appl_weatherapp/features/weather/data/repositories/weather_repositories_impl.dart';
import 'package:flutter_appl_weatherapp/features/weather/domain/use_cases/weather_use_case.dart';
import 'package:flutter_appl_weatherapp/features/weather/presentation/logic/bloc/weather_bloc.dart';
import 'package:flutter_appl_weatherapp/features/weather/presentation/screens/weather_info_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchLocationScreen extends StatelessWidget {
  const SearchLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc =
        WeatherBloc(WeatherUseCase(weatherRepository: WeatherRepositoryImpl()));

    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(-1, -0.4),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.amber,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(1, -0.4),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 100.0,
                  sigmaY: 100.0,
                ),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: BlocListener<WeatherBloc, WeatherState>(
                  bloc: weatherBloc,
                  listener: (context, state) {
                    if (state is WeatherLoadedState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (contex) => WeatherInfoScreen(
                            weatherModel: state.weatherModel,
                          ),
                        ),
                      );
                    }
                    if (state is WeatherErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error.message.toString()),
                        ),
                      );
                    }
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text(
                          "Welcome to Razak Weather App",
                          style: TextStyle(
                            fontFamily: 'ProtestRiot',
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Image.asset('assets/images/7.png'),
                        Column(
                          children: [
                            const Text(
                              'Discover the Weather',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text(
                              'in the World',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Get to know your weather maps and',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            const Text(
                              'radar precipitation forecast',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            const SizedBox(height: 60),
                            TextField(
                              controller: controller,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(color: Colors.white),
                                labelText: 'choose city or country',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 5,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 60,
                              width: 300,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      const MaterialStatePropertyAll(Colors.blue),
                                  foregroundColor:
                                      const MaterialStatePropertyAll(Colors.white),
                                  overlayColor:
                                      const MaterialStatePropertyAll(Colors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  weatherBloc.add(
                                    GetWeatherInfoEvent(
                                      location: controller.text,
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Get started',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
