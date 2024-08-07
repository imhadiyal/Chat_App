import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_miner/modals/uaser_modals.dart';
import 'package:firebase_miner/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';

class FirestoreController extends ChangeNotifier {
  Future<void> getData() async {
    await FireStoreService.instance.getUser();
  }

  Future<void> addUser({required User user}) async {
    await FireStoreService.instance.addUser(user: user);
  }
}
