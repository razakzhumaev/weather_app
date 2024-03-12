import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_appl_weatherapp/internal/helpers/catch_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'global_localization_event.dart';
part 'global_localization_state.dart';

class GlobalLocalizationBloc
    extends Bloc<GlobalLocalizationEvent, GlobalLocalizationState> {
  GlobalLocalizationBloc() : super(GlobalLocalizationInitialState()) {
    on<ChangeLocalizationEvent>((event, emit) async {
      emit(GlobalLocalizationLoadingState());
      try {
        setCurrentLocale(event.locale);
        String currentLocale = await getCurrentLocale();
        emit(GlobalLocalizationLoadedState(locale: currentLocale));
      } catch (e) {
        emit(GlobalLocalizationErrorState(
          error: CatchException.convertException(e),
        ));
      }
    });
  }
}

Future<void> setCurrentLocale(String currentLocale) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('vocale', currentLocale);
}

Future<String> getCurrentLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String value = prefs.getString('locale') ?? 'ru';

  return value;
}
