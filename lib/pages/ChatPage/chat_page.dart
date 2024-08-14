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
        backgroundColor: Colors.blueGrey.shade300,
        title: Row(
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(userModel.photoURL),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(userModel.displayName),
          ],
        ),
      ),
      backgroundColor: Colors.blueGrey.shade100,
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
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.sizeOf(context).width * 0.7,
                                ),
                                child: chat.type == 'sent'
                                    ? Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.only(
                                          bottom: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              chat.msg,
                                              style: const TextStyle(
                                                fontSize: 21,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              ' ${chat.time.hour}:${chat.time.minute}',
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Image(
                                              image: chat.status == 'seen'
                                                  ? const AssetImage(
                                                      'assets/images/seen.png',
                                                    )
                                                  : const AssetImage(
                                                      'assets/images/unseen.png'),
                                              fit: BoxFit.fill,
                                              height: 20,
                                              width: 20,
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.only(
                                          bottom: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(),
                                          borderRadius: const BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                        ),
                                        child: Stack(
                                          children: [
                                            Text(
                                              chat.msg,
                                              style: const TextStyle(
                                                fontSize: 21,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 100,
                                              height: 30,
                                            ),
                                            Positioned(
                                              height: 50,
                                              right: 9,
                                              top: 18,
                                              child: Text(
                                                ' ${chat.time.hour}:${chat.time.minute}',
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
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
              decoration: const InputDecoration(
                hintText: "Enter message",
                hintStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
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
