import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_miner/modals/chat_modals.dart';
import 'package:firebase_miner/modals/uaser_modals.dart';
import 'package:firebase_miner/services/auth_services.dart';
import 'package:logger/logger.dart';

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

  Future<void> addFriend({required UserModel userModel}) async {
    await fireStore
        .collection(userCollection)
        .doc(currentUser!.uid)
        .collection('friends')
        .doc(userModel.uid)
        .set(userModel.toMap)
        .then((value) => Logger().i("Added...."))
        .onError((error, stackTrace) => Logger().e("ERROR: ${error}"));

    await fireStore
        .collection(userCollection)
        .doc(userModel.uid)
        .collection('friends')
        .doc(currentUser!.uid)
        .set(currentUser!.toMap);
  }

  Future<List<UserModel>> getFriends() async {
    List<UserModel> friends = [];

    friends = (await fireStore
            .collection(userCollection)
            .doc(currentUser!.uid)
            .collection('friends')
            .get())
        .docs
        .map((e) => UserModel.froMap(e.data()))
        .toList();

    return friends;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFriendsStream() {
    return fireStore
        .collection(userCollection)
        .doc(currentUser?.uid)
        .collection('friends')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChats(
      {required UserModel userModel}) {
    return fireStore
        .collection(userCollection)
        .doc(currentUser!.uid)
        .collection('friends')
        .doc(userModel.uid)
        .collection('chats')
        .snapshots();
  }

  Future<void> sendMsg(
      {required UserModel user, required ChatModel chat}) async {
    await fireStore
        .collection(userCollection)
        .doc(currentUser!.uid)
        .collection('friends')
        .doc(user.uid)
        .collection('chats')
        .doc(chat.time.millisecondsSinceEpoch.toString())
        .set(chat.toMap);

    Map<String, dynamic> data = chat.toMap;
    data['type'] = 'received';

    await fireStore
        .collection(userCollection)
        .doc(user.uid)
        .collection('friends')
        .doc(currentUser!.uid)
        .collection('chats')
        .doc(chat.time.millisecondsSinceEpoch.toString())
        .set(data);
  }
  Future<void> seenMsg(
      {required UserModel user, required ChatModel chat}) async {
    await fireStore
        .collection(userCollection)
        .doc(currentUser!.uid.toString())
        .collection('friends')
        .doc(user.uid.toString())
        .collection('chats')
        .doc(chat.time.millisecondsSinceEpoch.toString())
        .update(
      {'status': "seen"},
    );

    await fireStore
        .collection(userCollection)
        .doc(user.uid.toString())
        .collection('friends')
        .doc(currentUser!.uid.toString())
        .collection('chats')
        .doc(chat.time.millisecondsSinceEpoch.toString())
        .update(
      {'status': "seen"},
    );
  }

  Future<void> updateMsg(UserModel userModel, ChatModel chat) async {
    await fireStore
        .collection(userCollection)
        .doc(currentUser!.uid.toString())
        .collection('friends')
        .doc(userModel.uid.toString())
        .collection('chats')
        .doc(chat.time.millisecondsSinceEpoch.toString())
        .update(
      {'msg': chat.msg},
    );

    await fireStore
        .collection(userCollection)
        .doc(userModel.uid.toString())
        .collection('friends')
        .doc(currentUser!.uid.toString())
        .collection('chats')
        .doc(chat.time.millisecondsSinceEpoch.toString())
        .update(
      {'msg': chat.msg},
    );
  }

  Future<void> deleteMsg(UserModel userModel, ChatModel chat) async {
    await fireStore
        .collection(userCollection)
        .doc(currentUser!.uid.toString())
        .collection('friends')
        .doc(userModel.uid.toString())
        .collection('chats')
        .doc(chat.time.millisecondsSinceEpoch.toString())
        .delete();

    await fireStore
        .collection(userCollection)
        .doc(userModel.uid.toString())
        .collection('friends')
        .doc(currentUser!.uid.toString())
        .collection('chats')
        .doc(chat.time.millisecondsSinceEpoch.toString())
        .delete();
  }
}
