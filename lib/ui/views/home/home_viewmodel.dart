import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/locator.dart';
import '../../../app/router.gr.dart';
import '../../../services/location_service.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final LocationService _locationService = locator<LocationService>();

  Future<void> init() async {
    await _locationService.init();
  }

  Future<void> getLocation() async {
    setBusy(true);
    await _locationService.getLocation();
    debugPrint(
        'Latitude: ${_locationService.locationData.latitude} Longitude: ${_locationService.locationData.longitude}');
    setBusy(false);
  }

  Future<void> logout() async {
    await _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
  }
}
