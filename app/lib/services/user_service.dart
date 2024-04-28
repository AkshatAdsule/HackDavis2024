import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:app/util/user.dart';

import 'api.dart';

class UserService extends ChangeNotifier {
  static UserService? _instance;
  static UserService get instance {
    _instance ??= UserService._();
    return _instance!;
  }

  User? _currentUser;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  UserService._() {
    _auth.authStateChanges().listen(_authStateListener);
  }

  void _authStateListener(auth.User? user) {
    if (user == null) {
      log("[UserService] User logged out");
      _currentUser = null;
    } else {
      log("[UserService] User logged in");
      _init();
    }
  }

  Future<void> _init() async {
    String uid = _auth.currentUser!.uid;
    print("getting current user");
    _currentUser = await APIService.instance.getUser(uid);
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<String> createAccountWithEmailAndPassword(
      String email, String password, String name) async {
    log("[UserService] Creating account with email: $email");
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log(credential.user!.uid);
      await APIService.instance.createUser(User(
        uid: credential.user!.uid,
        email: email,
        name: name,
      ));
      await _init();
      return credential.user!.uid;
    } catch (e) {
      log(e.toString());
    }

    return "";
  }

  User? get currentUser => _currentUser;

  Future<void> refresh() async {
    await _init();
    notifyListeners();
  }

  void signOut() {
    _auth.signOut();
    notifyListeners();
  }
}
