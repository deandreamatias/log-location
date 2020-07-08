import 'package:log_location/app/locator.dart';
import 'package:log_location/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> logout() async {
    setBusy(true);
    await _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
    setBusy(false);
  }
}
