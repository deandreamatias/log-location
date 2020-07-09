import 'dart:async';
import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../models/log_location.dart';
import '../../../services/auth_service.dart';
import '../../../app/locator.dart';
import '../../../app/router.gr.dart';
import '../../../services/location_service.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final LocationService _locationService = locator<LocationService>();
  final AuthService _authService = locator<AuthService>();

  LatLng _latLng;
  List<LogLocation> _list = [];
  Completer<GoogleMapController> _controller = Completer();

  LatLng get latLng => _latLng;
  List<LogLocation> get list => _list;
  Completer<GoogleMapController> get controller => _controller;
  String get userId => _authService.hasUser ? _authService.user.uid : 'No user';
  bool get hasListItems => _list != null && _list.isNotEmpty;

  Future<void> init() async {
    _latLng = LatLng(37.43296265331129, -122.08832357078792);
    await _locationService.init();
  }

  Future<void> getLocation({bool random = false}) async {
    setBusy(true);
    await _locationService.getLocation();
    _travel(random);
    _list
      ..add(LogLocation(
        latitude: _latLng.latitude,
        longitude: _latLng.longitude,
        altitude: _locationService.locationData.altitude,
        dateTime: DateTime.now(),
        uid: _authService.user.uid,
      ));
    setBusy(false);
  }

  void _travel(bool random) {
    if (random) {
      // Get random double to generate random location
      final Random random = Random();
      final double randomOffset = random.nextDouble() * 0.1;
      _latLng = LatLng(
        _locationService.locationData.latitude - randomOffset,
        _locationService.locationData.longitude - randomOffset,
      );
    } else {
      _latLng = LatLng(
        _locationService.locationData.latitude,
        _locationService.locationData.longitude,
      );
    }
  }

  Future<void> logout() async {
    await _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
  }
}
