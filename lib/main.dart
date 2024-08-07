import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_miner/controller/firestore_controller.dart';
import 'package:firebase_miner/controller/screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'controller/user_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserController()),
      ChangeNotifierProvider(create: (_) => FirestoreController()),
      ChangeNotifierProvider(create: (_) => ScreenController()),
    ],
    child: MyApp(),
  ));
}
