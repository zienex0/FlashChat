import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeId = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                TextField(
                  // EMAIL FIELD
                  keyboardType: TextInputType.emailAddress,
                  decoration: kTextFieldInputDecoration.copyWith(
                      hintText: 'Your email'),
                  onChanged: (value) {
                    // TODO make it email field
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  // PASSWORD FIELD
                  obscureText: true,
                  decoration: kTextFieldInputDecoration.copyWith(
                      hintText: 'Your password'),
                  onChanged: (value) {
                    // TODO make it a password field
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: RoundedButton(
                      color: Colors.black,
                      textColor: Colors.white,
                      buttonText: 'Login',
                      onPressed: () async {
                        // TODO login the user
                        if (email.isNotEmpty && password.isNotEmpty) {
                          try {
                            await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            Navigator.pushNamed(context, ChatScreen.routeId);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                          }
                        }
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
