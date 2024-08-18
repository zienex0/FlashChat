import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String routeId = 'chat_screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Text('Chat screen');
  }
}
