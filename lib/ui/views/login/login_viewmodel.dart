import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/auth_service.dart';
import '../../../app/locator.dart';
import '../../../app/router.gr.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();

  String _email;
  String _password;

  String get email => _email;
  String get password => _password;

  Future<void> signIn() async {
    setBusy(true);
    await _authService.signInWithEmailAndPassword(email, password);
    if (_authService.hasUser) {
      await _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
    }
    setBusy(false);
  }

  Future<void> signInAnonymous() async {
    setBusy(true);
    await _authService.signInAnonymous();
    if (_authService.hasUser) {
      await _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
    }
    setBusy(false);
  }

  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }
}
