import 'dart:async';
import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/database_service.dart';
import '../../../models/log_location.dart';
import '../../../services/auth_service.dart';
import '../../../app/locator.dart';
import '../../../app/router.gr.dart';
import '../../../services/location_service.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final LocationService _locationService = locator<LocationService>();
  final AuthService _authService = locator<AuthService>();
  final DatabaseService _databaseService = DatabaseService();

  LatLng _latLng;
  Completer<GoogleMapController> _controller = Completer();

  LatLng get latLng => _latLng;
  Stream<List<LogLocation>> get list => _databaseService.listLocation;
  Completer<GoogleMapController> get controller => _controller;
  String get userId => _authService.user.uid;

  /// Init location and database services and config
  /// interval to get location with [getLocationInterval](seconds)
  Future<void> init({int getLocationInterval = 5}) async {
    _latLng = LatLng(37.43296265331129, -122.08832357078792);
    await _locationService.init();
    await _databaseService.init(userId);
    // TODO: Create a time service and restart timer when get location manually
    Timer.periodic(Duration(seconds: getLocationInterval), _getPeriodLocation);
    notifyListeners();
  }

  /// Get location and save in database
  /// If [random] true, modify original latitude and longitude
  Future<void> getLocation({bool random = false}) async {
    setBusy(true);
    await _locationService.getLocation();
    _travel(random);
    _databaseService.addLogLocation(LogLocation(
      latitude: _latLng.latitude,
      longitude: _latLng.longitude,
      altitude: _locationService.locationData.altitude,
      dateTime: DateTime.now(),
      uid: _authService.user.uid,
    ));
    setBusy(false);
  }

  void _getPeriodLocation(Timer timer) async {
    await getLocation();
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

  Future<void> clearList() async {
    await _databaseService.clear();
  }

  Future<void> logout() async {
    await _databaseService.close();
    await _authService.removeUser();
    await _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
  }
}
