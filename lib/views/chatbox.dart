import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  final String
      receiverUsername; // Pseudo de l'utilisateur qui a publié l'annonce

  ChatPage({required this.receiverUsername});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  String?
      senderUsername; // Pseudo de l'utilisateur connecté (récupéré via SharedPreferences)
  List<String> chatMessages = [];

  @override
  void initState() {
    super.initState();
    getSenderUsername();
  }

  Future<void> getSenderUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    setState(() {
      senderUsername = username;
    });
  }

  void sendMessage() {
    String message = messageController.text;
    if (message.isNotEmpty) {
      // Envoyer le message (vous pouvez implémenter votre propre logique ici)
      // Par exemple, vous pouvez envoyer le message à un serveur ou l'enregistrer localement
      // pour le récupérer dans la liste des messages.

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
