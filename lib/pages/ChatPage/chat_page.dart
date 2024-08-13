import 'package:firebase_miner/modals/chat_modals.dart';
import 'package:firebase_miner/modals/uaser_modals.dart';
import 'package:firebase_miner/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserModel userModel =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(userModel.displayName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream:
                    FireStoreService.instance.getChats(userModel: userModel),
                builder: (context, snapShots) {
                  if (snapShots.hasData) {
                    List<ChatModel> chats = snapShots.data?.docs
                            .map(
                              (e) => ChatModel.fromMap(
                                e.data(),
                              ),
                            )
                            .toList() ??
                        [];

                    return ListView.builder(
                      itemCount: chats.length,
                      itemBuilder: (c, i) {
                        ChatModel chat = chats[i];

                        if (chat.type == 'received') {
                          FireStoreService.instance.seenMsg(
                            user: userModel,
                            chat: chat,
                          );
                        }

                        return Row(
                          mainAxisAlignment: chat.type == "sent"
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Update !!"),
                                    content: TextFormField(
                                      initialValue: chat.msg,
                                      onChanged: (val) {
                                        chat.msg = val;
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "Enter message",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    ),
                                    actions: [
                                      OutlinedButton(
                                        onPressed: () {
                                          FireStoreService.instance
                                              .deleteMsg(userModel, chat)
                                              .then(
                                                (value) =>
                                                    Navigator.pop(context),
                                              );
                                        },
                                        child: const Text("DELETE"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          FireStoreService.instance
                                              .updateMsg(userModel, chat)
                                              .then(
                                                (value) =>
                                                    Navigator.pop(context),
                                              );
                                        },
                                        child: const Text("DONE"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child:message;
                            ),
                          ],
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
            TextField(
              controller: controller,
              onSubmitted: (val) {
                FireStoreService.instance
                    .sendMsg(
                      user: userModel,
                      chat: ChatModel(
                        DateTime.now(),
                        controller.text,
                        'sent',
                        'unseen',
                      ),
                    )
                    .then(
                      (value) => controller.clear(),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
