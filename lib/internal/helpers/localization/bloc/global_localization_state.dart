part of 'global_localization_bloc.dart';

sealed class GlobalLocalizationState extends Equatable {
  const GlobalLocalizationState();

  @override
  List<Object> get props => [];
}

final class GlobalLocalizationInitialState extends GlobalLocalizationState {}

class GlobalLocalizationLoadingState extends GlobalLocalizationState {}

class GlobalLocalizationLoadedState extends GlobalLocalizationState {
  final String locale;

  const GlobalLocalizationLoadedState({required this.locale});
}

class GlobalLocalizationErrorState extends GlobalLocalizationState {
  final CatchException error;

  const GlobalLocalizationErrorState({required this.error});
}
