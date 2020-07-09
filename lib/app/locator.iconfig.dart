// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:log_location/services/auth_service.dart';
import 'package:log_location/services/database_service.dart';
import 'package:log_location/services/location_service.dart';
import 'package:log_location/services/third_party_services_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<AuthService>(() => AuthService());
  g.registerLazySingleton<DatabaseService>(() => DatabaseService());
  g.registerLazySingleton<LocationService>(() => LocationService());
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  NavigationService get navigationService => NavigationService();
}
