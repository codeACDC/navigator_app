part of 'navigator_cubit.dart';

@immutable
abstract class Navigator2State extends Equatable {
  const Navigator2State();

  @override
  List<Object> get props => [];
}

class NavigatorInitial extends Navigator2State {
  const NavigatorInitial();
}

class NavigatorLoading extends Navigator2State {
  const NavigatorLoading();
}

class NavigatorLoaded extends Navigator2State {
  final double longitude, latitude;

  const NavigatorLoaded({required this.longitude, required this.latitude});

  @override
  List<Object> get props => [longitude, latitude];
}

class NavigatorError extends Navigator2State {
  const NavigatorError();
}
