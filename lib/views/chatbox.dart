import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  final String receiverUsername;
  ChatPage({required this.receiverUsername}) : super(key: UniqueKey());

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  String?
      senderUsername; // Pseudo de l'utilisateur connecté (récupéré via SharedPreferences)
  String? receiverUsername; // Pseudo de l'utilisateur qui a publié l'annonce
  List<String> chatMessages = [];

  @override
  void initState() {
    super.initState();
    getSenderUsername();
    receiverUsername = widget.receiverUsername;
  }

  Future<void> getSenderUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    setState(() {
      senderUsername = username;
    });
  }

  Future<void> sendMessage() async {
    String message = messageController.text;
    if (message.isNotEmpty) {
      // Envoyer le message (vous pouvez implémenter votre propre logique ici)
      // Par exemple, vous pouvez envoyer le message à un serveur ou l'enregistrer localement
      // pour le récupérer dans la liste des messages.
      // Envoyer le message au serveur en incluant le champ recipient
      await http.post(
          Uri.parse(
              'http://192.168.1.93/flutter_application_1/php/send_messages.php'),
          body: {
            'sender': senderUsername!,
            'recipient': receiverUsername!,
            'message': message
          });

      setState(() {
        chatMessages.add('$senderUsername: $message');
        messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat avec ${widget.receiverUsername}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(chatMessages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Entrez votre message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  String sender;
  String message;
  String dateTime;

  Message(
      {required this.sender, required this.message, required this.dateTime});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        sender: json['sender'],
        message: json['message'],
        dateTime: json['date_time']);
  }
}
