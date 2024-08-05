import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthServices {
  AuthServices._();
  static final AuthServices authServices = AuthServices._();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> signinWithEmailAndPassword(
      {required String email, required String password}) async {
    User? user;
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = credential.user;
      Logger().i('login success');
    } catch (e) {
      Logger().e('login failed');
    }
    return user;
  }

  Future<User?> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    User? user;
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = credential.user;
      Logger().i('login success');
    } catch (e) {
      Logger().e('login failed');
    }
    return user;
  }

  Future<User?> signout() async {
    try {
      await auth.signOut();
      Logger().i('logout success');
    } catch (e) {
      Logger().e('logout failed');
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<User?> anonymousLogin() async {
    UserCredential credential = await auth.signInAnonymously();

    return credential.user;
  }
}
