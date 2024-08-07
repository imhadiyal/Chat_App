import 'package:firebase_miner/modals/uaser_modals.dart';
import 'package:firebase_miner/services/firestore_service.dart';
import 'package:flutter/material.dart';

class AddFriendPage extends StatelessWidget {
  const AddFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder(
          stream: FireStoreService.instance.getFriendsStream(),
          builder: (c, snap) {
            if (snap.hasData) {
              List<UserModel> friends = snap.data?.docs
                      .map((e) => UserModel.froMap(e.data()))
                      .toList() ??
                  [];

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
                        );
                      },
                    );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
