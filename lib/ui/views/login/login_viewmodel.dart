import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/locator.dart';
import '../../../app/router.gr.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser _user;
  String _email;
  String get email => _email;
  String _password;
  String get password => _password;

  FirebaseUser get user => _user;

  bool get hasUser => _user != null && _user.uid.isNotEmpty;

  Future<void> signIn() async {
    setBusy(true);
    _user = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    if (hasUser) {
      debugPrint("Signed in: " + user.email);
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
