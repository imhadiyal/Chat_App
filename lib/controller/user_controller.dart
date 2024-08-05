import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_miner/modals/uaser_modals.dart';
import 'package:firebase_miner/services/auth_services.dart';
import 'package:flutter/cupertino.dart';

class UserController extends ChangeNotifier {
  Future<User?> singInWithAnonymous() async {
    return await AuthServices.authServices.anonymousLogin();
  }

  Future<User?> singInWithEmailAndPassword(
      {required String email, required String password}) async {
    return await AuthServices.authServices
        .signinWithEmailAndPassword(email: email, password: password);
  }

  Future<User?> singUnWithEmailAndPassword(
      {required String email, required String password}) async {
    return await AuthServices.authServices
        .signUpWithEmailAndPassword(email: email, password: password);
  }

  Future<User?> singOut() async {
    return await AuthServices.authServices.signout();
  }

  Future<UserCredential> signInWithGoogle() async {
    return await AuthServices.authServices.signInWithGoogle();
  }
}
