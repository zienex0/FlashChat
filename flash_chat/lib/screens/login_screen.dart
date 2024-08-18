import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class LoginScreen extends StatefulWidget {
  static const String routeId = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  decoration: kTextFieldInputDecoration.copyWith(
                      hintText: 'Your email'),
                  onChanged: (value) {
                    // TODO make it a username field
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: kTextFieldInputDecoration.copyWith(
                      hintText: 'Your password'),
                  onChanged: (value) {
                    // TODO make it a password field
                  },
                ),
                RoundedButton(
                    color: Colors.black,
                    textColor: Colors.white,
                    buttonText: 'Login',
                    onPressed: () {})
              ],
            ),
          ),
        ],
      ),
    );
  }
}
