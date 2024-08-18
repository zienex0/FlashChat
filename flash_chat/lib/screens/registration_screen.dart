import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeId = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Text('Registration screen');
  }
}
