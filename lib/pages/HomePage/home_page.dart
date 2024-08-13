import 'package:firebase_miner/controller/screen_controller.dart';
import 'package:firebase_miner/controller/user_controller.dart';
import 'package:firebase_miner/pages/AddfriendPage/addfriend_page.dart';
import 'package:firebase_miner/pages/FriendPage/friend_page.dart';
import 'package:firebase_miner/routes.dart';
import 'package:firebase_miner/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> pages = [
      const AddFriendPage(),
      const FriendsPage(),
    ];
    ScreenController screen = Provider.of<ScreenController>(context);
    UserController immutable = Provider.of<UserController>(context);
    int currentScreen = screen.CurrentScreenIndex;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentScreen,
        onTap: (value) => screen.updateScreenIndex(value),
        items: [
          BottomNavigationBarItem(
              label: 'Chats',
              icon: Icon((currentScreen == 0)
                  ? Icons.chat_sharp
                  : Icons.chat_bubble_outline),
              backgroundColor: Colors
                  .indigo // provide color to any one icon as it will overwrite the whole bottombar's color ( if provided any )
              ),
          BottomNavigationBarItem(
              label: 'People',
              icon: Icon((currentScreen == 1)
                  ? Icons.people_alt
                  : Icons.people_alt_outlined),
              backgroundColor: Colors.indigo),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                foregroundImage: NetworkImage(
                  FireStoreService.instance.currentUser?.photoURL ??
                      "https://static.vecteezy.com/system/resources/previews/002/318/271/non_2x/user-profile-icon-free-vector.jpg",
                ),
              ),
              accountName: Text(
                  FireStoreService.instance.currentUser?.displayName ?? ""),
              accountEmail:
                  Text(FireStoreService.instance.currentUser?.email ?? ''),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("My friends"),
              trailing: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('friends');
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () {
              immutable.singOut();
              Navigator.pushReplacementNamed(context, Routes.routes.login);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: pages[currentScreen],
    );
  }
}
