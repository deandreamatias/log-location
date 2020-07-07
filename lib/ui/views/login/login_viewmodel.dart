import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser _user;
  String _email;
  String get email => _email;
  String _password;
  String get password => _password;

  FirebaseUser get user => _user;

  bool get hasUser => _user != null && _user.uid.isNotEmpty;

  Future<void> signIn() async {
    _user = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    debugPrint("Signed in: " + user.email);
    notifyListeners();
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
