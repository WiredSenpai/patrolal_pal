import 'package:flutter/material.dart';
import 'package:patrol_pal/components/my_button.dart';
import 'package:patrol_pal/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:patrol_pal/components/square_tile.dart';
import 'package:patrol_pal/components/square_tile2.dart';
import 'package:patrol_pal/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  final Function()? signInWGoogle;
  const LoginPage({
    super.key,
    required this.onTap,
    required this.signInWGoogle,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text edditing controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  //Sign in button method
  void SignUserIn() async {
    //Indicate that its loading with a loading circle animation
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);

      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      //Show error message
      showErrorMesage(e.code);
    }
  }

  //Error message
  void showErrorMesage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
            message,
            style: const TextStyle(color: Colors.black),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200]),
                  height: 150,
                  width: 150,
                  child: const CircleAvatar(
                    child: Image(
                      image: AssetImage('assets/images/logo.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              //some text=============================
              Text(
                "Sign in with your details ",
                style: TextStyle(color: Colors.grey[700], fontSize: 18),
              ),
              SizedBox(height: 10),

              //username textfield====================
              MyTextfield(
                controller: usernameController,
                hintText: "Email",
                obscureText: false,
              ),

              //password textfield=======================
              MyTextfield(
                controller: passwordController,
                hintText: 'password',
                obscureText: true,
              ),

              //forgot password textfield================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),

              //  sign in button===========================
              MyButton(
                text: 'sign in',
                onTap: SignUserIn,
              ),
              SizedBox(
                height: 50,
              ),

              // or continue with===========================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //Google and apple sign in=================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // //Google button================================

                  // GestureDetector(
                  //   onTap: AuthService().signInWithGoogle(),
                  //   child: Container(
                  //     padding: EdgeInsets.all(5),
                  //     decoration: BoxDecoration(
                  //         border: Border.all(color: Colors.white),
                  //         borderRadius: BorderRadius.circular(16),
                  //         color: Colors.blue[300]),
                  //     child: IconButton(
                  //       onPressed: () {

                  //       },
                  //       icon: const FaIcon(FontAwesomeIcons.google),
                  //       iconSize: 42,
                  //     ),
                  //   ),
                  // ),
                  SquareTile(
                    onTap: () => AuthService().signInWithGoogle(),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  // //apple button

                  // GestureDetector(
                  //   onDoubleTap: () {},
                  //   child: Container(
                  //     padding: EdgeInsets.all(5),
                  //     decoration: BoxDecoration(
                  //         border: Border.all(color: Colors.white),
                  //         borderRadius: BorderRadius.circular(16),
                  //         color: Colors.grey[200]),
                  //     child: IconButton(
                  //       onPressed: () {
                  //         print('pressed');
                  //       },
                  //       icon: const FaIcon(FontAwesomeIcons.apple),
                  //       iconSize: 42,
                  //     ),
                  //   ),
                  // ),
                  SquareTile2(
                    onTap: () => AuthService().signInWithGoogle(),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),

              //register=====================================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont have an account?'),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'register now',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
