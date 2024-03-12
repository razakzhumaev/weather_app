part of 'global_localization_bloc.dart';

sealed class GlobalLocalizationEvent extends Equatable {
  const GlobalLocalizationEvent();

  @override
  List<Object> get props => [];
}

class ChangeLocalizationEvent extends GlobalLocalizationEvent {
  final String locale;

  ChangeLocalizationEvent({required this.locale});
}
