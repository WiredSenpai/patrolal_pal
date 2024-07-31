import 'package:flutter/material.dart';
import 'package:patrol_pal/pages/register_page.dart';
import 'login_page.dart';

class LoginorregisterPage extends StatefulWidget {
  const LoginorregisterPage({
    super.key,
  });

  @override
  State<LoginorregisterPage> createState() => _LoginorregisterPageState();
}

class _LoginorregisterPageState extends State<LoginorregisterPage> {
  //initially show login page
  bool showLoginPage = true;

  //toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
        signInWGoogle: () {},
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
