import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String routeId = 'chat_screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messagesController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messageText = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        setState(() {
          loggedInUser = currentUser;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    messagesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.grey,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _auth.signOut();
              });
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: loggedInUser != null
          ? SafeArea(
              child: Column(
                children: [
                  const MessagesStream(),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 20),
                          child: TextField(
                            controller: messagesController,
                            onChanged: (value) {
                              messageText = value;
                            },
                            decoration: kSendMessageTextFieldInputDecoration,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 20),
                        child: RoundedButton(
                          color: Colors.black,
                          textColor: Colors.white,
                          buttonText: 'Send',
                          verticalPadding: 15,
                          horizontalPadding: 20,
                          onPressed: () async {
                            if (messageText.isNotEmpty) {
                              await _firestore
                                  .collection(kmessagesFireStoreCollectionName)
                                  .add({
                                'text': messageText,
                                'sender': loggedInUser!.email,
                                'timestamp': FieldValue.serverTimestamp()
                              });
                              messageText = '';
                              messagesController.clear();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const Center(
              child: Text('You have to be logged in to continue'),
            ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: _firestore
            .collection(kmessagesFireStoreCollectionName)
            .orderBy('timestamp', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            );
          }

          final messages = snapshot.data!.docs.reversed;
          List<Widget> messagesWidgets = [];

          for (var message in messages) {
            final messageText = message.data()['text'];
            final messageSender = message.data()['sender'];

            bool isMe = false;

            if (loggedInUser != null && loggedInUser!.email == messageSender) {
              isMe = true;
            }

            final messageWidget = MessageBubble(
              text: '$messageText',
              sender: '$messageSender',
              isMe: isMe,
            );
            messagesWidgets.add(messageWidget);
          }

          return ListView(
            reverse: true,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messagesWidgets,
          );
        },
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
      required this.text,
      required this.sender,
      required this.isMe});

  final String text;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Material(
            elevation: 5,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            color: isMe ? Colors.black : Colors.blueAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
