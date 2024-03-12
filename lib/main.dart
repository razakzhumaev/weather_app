import 'package:flutter/material.dart';
import 'package:flutter_appl_weatherapp/features/weather/presentation/screens/search_location_screen.dart';
import 'package:flutter_appl_weatherapp/generated/l10n.dart';
import 'package:flutter_appl_weatherapp/internal/helpers/localization/bloc/global_localization_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalLocalizationBloc bloc = GlobalLocalizationBloc();
  String? locale;

  @override
  void initState() {
    localeHelper();
    super.initState();
  }

  localeHelper() async {
    String locale = await getCurrentLocale();
    bloc.add(ChangeLocalizationEvent(locale: locale));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale.fromSubtags(languageCode: locale ?? 'ru'),
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        // TRY THIS: Try running your application with "flutter run". You'll see
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocListener<GlobalLocalizationBloc, GlobalLocalizationState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is GlobalLocalizationLoadedState) {
            locale = state.locale;
          }
        },
        child: const SearchLocationScreen(),
      ),
    );
  }
}
