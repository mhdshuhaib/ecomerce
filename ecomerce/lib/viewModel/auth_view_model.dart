import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Authentication with ChangeNotifier {
  String errorMessage = "";
  bool isRegistered = false;
  bool loadingAuth = false;
  String? userId;

  // creating a new user in firebase
  Future registerUser({required String email, required String password}) async {
    isRegistered = false;
    loadAuth(true);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      userId = userCredential.user!.uid;
      isRegistered = true;
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
        // this user is already registred in the db
        message('This email is already registered');
      } else {
        //some error occurred while creating the user
        message('Failed to register: $e');
      }
    }
    loadAuth(false);
    notifyListeners();
  }

  Future login({required String email, required String password}) async {
    isRegistered = false;
    loadAuth(true);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      userId = userCredential.user!.uid;
      isRegistered = true;
    } catch (e) {
      // incorrect credentials
      message('Invalid user name or password');
    }
    loadAuth(false);
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }

  // loading auth submit button
  void loadAuth(bool val) {
    loadingAuth = val;
    notifyListeners();
  }

  // message to login screen
  void message(String message) {
    errorMessage = message;
    notifyListeners();
  }
}

bool isEmailValid(String email) {
  // Define a regular expression for email validation
  final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    caseSensitive: false,
    multiLine: false,
  );

  // Check if the email matches the regular expression
  return emailRegex.hasMatch(email);
}
