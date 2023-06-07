import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    getMessages();
  }

  Future<void> getMessages() async {
    // Récupérer les messages de l'utilisateur depuis l'API
    var response = await http.get(Uri.parse(
        'http://192.168.1.94/flutter_application_1/php/get_messages.php'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      setState(() {
        messages = List.from(jsonData)
            .map((message) => Message.fromJson(message))
            .toList();
      });
    } else {
      // Gérer l'erreur de récupération des messages
      print('Erreur lors de la récupération des messages');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Boîte de réception'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(messages[index].sender),
            subtitle: Text(messages[index].message),
            // Vous pouvez afficher d'autres détails du message ici
          );
        },
      ),
    );
  }
}

class Message {
  String sender;
  String message;

  Message({required this.sender, required this.message});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: json['sender'],
      message: json['message'],
    );
  }
}
