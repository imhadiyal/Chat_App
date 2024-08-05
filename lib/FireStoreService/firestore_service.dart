import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_miner/modals/uaser_modals.dart';
import 'package:firebase_miner/services/auth_services.dart';

class FireStoreService {
  FireStoreService._();
  static final FireStoreService instance = FireStoreService._();

  // Initialize
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  String userCollection = "allUsers";

  UserModel? currentUser;

  // Add user
  Future<void> addUser({required User user}) async {
    Map<String, dynamic> data = {
      'uid': user.uid,
      'displayName': user.displayName ?? "DEMO USER",
      'email': user.email ?? "demo_mail",
      'phoneNumber': user.phoneNumber ?? "NO DATA",
      'photoURL': user.photoURL ??
          "https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg",
    };

    await fireStore.collection(userCollection).doc(user.uid).set(data);
  }

  Future<void> getUser() async {
    DocumentSnapshot snapshot = await fireStore
        .collection(userCollection)
        .doc(AuthServices.authServices.auth.currentUser!.uid)
        .get();

    currentUser = UserModel.froMap(snapshot.data() as Map);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStream() {
    return fireStore
        .collection(userCollection)
        .doc(currentUser!.uid)
        .collection(userCollection)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return fireStore.collection(userCollection).snapshots();
  }
}
