import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:patrol_pal/pages/home_page.dart';
import 'loginOrRegister_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  //This file Holds the method thats responsible to choose which page to return depending on...
  //..whether the user is logged in or not

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //when User is logged in
            if (snapshot.hasData) {
              return HomeScreen();
            }
            //When user is not logged in
            else {
              return LoginorregisterPage();
            }
          }),
    );
  }
}
