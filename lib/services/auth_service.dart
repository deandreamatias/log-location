import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthResult _authResult;

  FirebaseUser get user => _authResult?.user;
  bool get hasUser =>
      _authResult?.user != null && _authResult?.user.uid.isNotEmpty;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _authResult = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInAnonymous() async {
    _authResult = await _auth.signInAnonymously();
  }

  Future<void> removeUser() async {
    _authResult = null;
  }
}
