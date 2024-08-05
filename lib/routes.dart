import 'package:firebase_miner/pages/HomePage/home_page.dart';
import 'package:firebase_miner/pages/Login%20Page/login_page.dart';
import 'package:firebase_miner/pages/SignupPage/signup_page.dart';
import 'package:firebase_miner/pages/splash_page/splash_page.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();
  static final Routes routes = Routes._();

  String splash = '/';
  String login = 'login_page';
  String signup = 'signup_page';
  String home = 'home_page';

  Map<String, WidgetBuilder> get allRoutes => {
        '/': (context) => const SplashScreen(),
        'login_page': (context) => const LoginPage(),
        'signup_page': (context) => SignupPage(),
        'home_page': (context) => const HomePage(),
      };
}
