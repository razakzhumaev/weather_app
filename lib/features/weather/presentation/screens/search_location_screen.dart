import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appl_weatherapp/features/weather/data/repositories/weather_repositories_impl.dart';
import 'package:flutter_appl_weatherapp/features/weather/domain/use_cases/weather_use_case.dart';
import 'package:flutter_appl_weatherapp/features/weather/presentation/logic/bloc/weather_bloc.dart';
import 'package:flutter_appl_weatherapp/features/weather/presentation/screens/weather_info_screen.dart';
// import 'package:flutter_appl_weatherapp/generated/l10n.dart';
// import 'package:flutter_appl_weatherapp/generated/l10n.dart';
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
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
        // title: Text(S.of(context).hello),
        // backgroundColor: Colors.blue,
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.abc),
        //   ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.abc),
        //   ),
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.abc),
        //   ),
        // ],
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
                alignment: AlignmentDirectional(-1, -0.4),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.amber,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(1, -0.4),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
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
                  decoration: BoxDecoration(color: Colors.transparent),
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
                        Text(
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
                            Text(
                              'Discover the Weather',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'in the World',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Get to know your weather maps and',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            Text(
                              'radar precipitation forecast',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            SizedBox(height: 60),
                            TextField(
                              controller: controller,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: 'choose city or country',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 5,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 60,
                              width: 300,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.blue),
                                  foregroundColor:
                                      MaterialStatePropertyAll(Colors.white),
                                  overlayColor:
                                      MaterialStatePropertyAll(Colors.white),
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
                                child: Text(
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
