import 'package:firebase_miner/modals/uaser_modals.dart';
import 'package:firebase_miner/services/firestore_service.dart';
import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: FireStoreService.instance.getAllUsers(),
            builder: (c, snapsot) {
              if (snapsot.hasData) {
                List<UserModel> friends = snapsot.data?.docs
                        .map((e) => UserModel.froMap(e.data()))
                        .toList() ??
                    [];
                friends.removeWhere((element) =>
                    element.uid == FireStoreService.instance.currentUser!.uid);

                return friends.isEmpty
                    ? const Center(
                        child: Text("You have no friends !!"),
                      )
                    : ListView.builder(
                        itemCount: friends.length,
                        itemBuilder: (c, i) {
                          UserModel userModel = friends[i];

                          return ListTile(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                'add',
                                arguments: userModel,
                              );
                            },
                            leading: CircleAvatar(
                              foregroundImage: NetworkImage(userModel.photoURL),
                            ),
                            title: Text(userModel.displayName),
                            subtitle: Text(userModel.email),
                            trailing: IconButton(
                              onPressed: () async {
                                await FireStoreService.instance
                                    .addFriend(userModel: userModel);
                              },
                              icon: const Icon(Icons.person_add),
                            ),
                          );
                        },
                      );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}
