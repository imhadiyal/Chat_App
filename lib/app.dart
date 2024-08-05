import 'package:firebase_miner/routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Routes.routes.allRoutes,
    );
  }
}
