import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_miner/controller/firestore_controller.dart';
import 'package:firebase_miner/controller/user_controller.dart';
import 'package:firebase_miner/routes.dart';
import 'package:firebase_miner/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserController immutable = Provider.of<UserController>(context);
    FirestoreController fireStore = Provider.of<FirestoreController>(context);
    TextEditingController emailController = TextEditingController();
    TextEditingController pswController = TextEditingController();
    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
        width: double.infinity,
        height: double.infinity,
        color: Colors.white70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text("Create \nAccount :)",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
            Flexible(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: emailController,
                    showCursor: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.email,
                        color: const Color(0xFF666666),
                        size: defaultIconSize,
                      ),
                      fillColor: const Color(0xFFF2F3F5),
                      hintStyle: TextStyle(
                          color: const Color(0xFF666666),
                          fontFamily: defaultFontFamily,
                          fontSize: defaultFontSize),
                      hintText: "Email",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: pswController,
                    showCursor: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.password,
                        color: const Color(0xFF666666),
                        size: defaultIconSize,
                      ),
                      fillColor: const Color(0xFFF2F3F5),
                      hintStyle: TextStyle(
                          color: const Color(0xFF666666),
                          fontFamily: defaultFontFamily,
                          fontSize: defaultFontSize),
                      hintText: "Password",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 16,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF2F3F7),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        User? user = await immutable.singUnWithEmailAndPassword(
                            email: emailController.text,
                            password: pswController.text);

                        if (user != null) {
                          fireStore.addUser(user: user);
                          fireStore.getData();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("SIGN UP !!"),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );

                          Navigator.pushNamed(context, Routes.routes.home);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("FAILLED !!"),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFBC1F26),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: const BorderSide(
                            color: Color(0xFFBC1F26),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins-Medium.ttf',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const Text('Login with', style: TextStyle(fontSize: 17)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {
                          UserCredential userCredential = await AuthServices
                              .authServices
                              .signInWithGoogle();
                          User? user = userCredential.user;
                          if (user != null) {
                            await fireStore.addUser(user: user);
                            await fireStore.getData();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("SIGN UP !!"),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );

                            Navigator.pushNamed(context, Routes.routes.home);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("FAILED !!"),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            height: 30,
                            width: 30,
                            "assets/images/google.png",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () async {
                            User? user = await AuthServices.authServices
                                .anonymousLogin();

                            if (user != null) {
                              await fireStore.addUser(user: user);
                              await fireStore.getData();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("SIGN UP !!"),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );

                              Navigator.pushNamed(context, Routes.routes.home);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("FAILED !!"),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: const BorderSide(
                                color: Color(0xFFBC1F26),
                              ),
                            ),
                          ),
                          child: const Text("Guest",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Poppins-Medium.ttf',
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: const Color(0xFF666666),
                        fontFamily: defaultFontFamily,
                        fontSize: defaultFontSize,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pushNamed(Routes.routes.login);
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Color(0xFFAC252B),
                          fontFamily: defaultFontFamily,
                          fontSize: defaultFontSize,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
