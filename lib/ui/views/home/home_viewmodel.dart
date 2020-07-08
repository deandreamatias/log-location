import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/locator.dart';
import '../../../app/router.gr.dart';
import '../../../services/location_service.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final LocationService _locationService = locator<LocationService>();

  LatLng _latLng;
  Completer<GoogleMapController> _controller = Completer();

  LatLng get latLng => _latLng;
  Completer<GoogleMapController> get controller => _controller;

  Future<void> init() async {
    _latLng = LatLng(37.43296265331129, -122.08832357078792);
    await _locationService.init();
  }

  Future<void> getLocation() async {
    setBusy(true);
    await _locationService.getLocation();
    _travel();
    setBusy(false);
  }

  Future<void> _travel() async {
    final GoogleMapController controller = await _controller.future;
    _latLng = LatLng(
      _locationService.locationData.latitude,
      _locationService.locationData.longitude,
    );
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _latLng, zoom: 15.0),
      ),
    );
  }

  Future<void> logout() async {
    await _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
  }
}
