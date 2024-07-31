import 'package:flutter/material.dart';
import 'package:patrol_pal/components/my_button.dart';
import 'package:patrol_pal/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:patrol_pal/components/square_tile.dart';
import 'package:patrol_pal/components/square_tile2.dart';
import 'package:patrol_pal/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  //Text edditing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //Sign up button method
  void SignUserUp() async {
    //Show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //try creating the user
    try {
      //check if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );
      } else {
        //Show erroe message: passwords dont match
        showErrorMesage("Passwords don't match!");
      }
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

  // Sign Up with Google
  void signUpWithGoogle() {
    AuthService().signInWithGoogle();
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
              Icon(
                Icons.favorite,
                size: 50,
              ),
              SizedBox(height: 10),
              //some text=============================
              Text(
                "Enter your details below",
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
              //Confirm password textfield=======================
              MyTextfield(
                controller: confirmPasswordController,
                hintText: 'Confirm password',
                obscureText: true,
              ),

              // //forgot password ===============
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       Text(
              //         'Forgot password?',
              //         style: TextStyle(color: Colors.grey[600]),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 15,
              // ),

              //  sign Up button===========================
              MyButton(
                text: 'Sign Up',
                onTap: SignUserUp,
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
                  // //Google button
                  // GestureDetector(
                  //   onTap: AuthService().signInWithGoogle(),
                  //   child: Container(
                  //     padding: EdgeInsets.all(5),
                  //     decoration: BoxDecoration(
                  //         border: Border.all(color: Colors.white),
                  //         borderRadius: BorderRadius.circular(16),
                  //         color: Colors.blue[300]),
                  //     child: IconButton(
                  //       onPressed: () {},
                  //       icon: const FaIcon(FontAwesomeIcons.google),
                  //       iconSize: 42,
                  //     ),
                  //   ),
                  // ),
                  SquareTile(onTap: AuthService().signInWithGoogle()),
                  SizedBox(
                    width: 20,
                  ),
                  // //apple button

                  //   Container(
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
                  SquareTile2(onTap: () {})
                ],
              ),
              SizedBox(
                height: 20,
              ),

              //register=====================================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Sign in now',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
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
