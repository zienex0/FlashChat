import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.routeId,
      routes: {
        WelcomeScreen.routeId: (context) => const WelcomeScreen(),
        RegistrationScreen.routeId: (context) => const RegistrationScreen(),
        LoginScreen.routeId: (context) => const LoginScreen(),
        ChatScreen.routeId: (context) => const ChatScreen()
      },
    );
  }
}
