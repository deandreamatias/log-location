import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

@lazySingleton
class LocationService {
  Location location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  LocationData get locationData => _locationData;
  bool get isEnable => _serviceEnabled;
  bool get isPermissionGranted =>
      _permissionGranted == PermissionStatus.granted;

  Future<void> init() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    if (!isPermissionGranted) {
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
      }
    }
  }

  Future<void> getLocation() async {
    _locationData = await location.getLocation();
  }
}
