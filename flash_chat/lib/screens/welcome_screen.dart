import 'package:flutter/material.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeId = 'welcome_screen';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 32,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  AnimatedTextKit(
                    pause: const Duration(seconds: 3),
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Flash Chat',
                        textStyle: const TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        speed: const Duration(milliseconds: 200),
                      ),
                    ],
                    // style: TextStyle(fontSize: 32),
                    // textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              RoundedButton(
                  color: Colors.black,
                  textColor: Colors.white,
                  buttonText: 'Login',
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.routeId);
                  }),
              RoundedButton(
                color: Colors.black,
                textColor: Colors.white,
                buttonText: 'Register',
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.routeId);
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
