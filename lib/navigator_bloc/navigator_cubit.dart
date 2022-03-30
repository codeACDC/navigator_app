import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

part 'navigator_state.dart';

class NavigatorCubit extends Cubit<Navigator2State> {
  NavigatorCubit() : super(const NavigatorInitial());

  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    try {
      if (permission != LocationPermission.denied ||
          permission != LocationPermission.deniedForever) {
        emit(const NavigatorLoading());
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        emit(NavigatorLoaded(
            longitude: position.longitude, latitude: position.latitude));
      }
    } catch (error) {
      // ignore: avoid_print
      print(error);

      emit(const NavigatorError());
    }
  }
}
