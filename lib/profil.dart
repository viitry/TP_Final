import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  TextEditingController _usernameController = TextEditingController();

  Future getUserInfo(String username) async {
    var url = 'http://192.168.1.94/flutter_application_1/php/get_user_info.php';
    var response = await http.post(Uri.parse(url), body: {
      "username": username,
    });

    if (response.statusCode == 200) {
      // Si la requête est réussie, récupérer les informations de l'utilisateur
      final user = jsonDecode(response.body);
      setState(() {
        _usernameController.text = user['username'];
      });
    } else {
      // Si la requête échoue, afficher un message d'erreur
      throw Exception('Failed to load user info');
    }
  }

  Future<String> _getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? '';
    return username;
  }
  /*final _nomController = TextEditingController(text: "Doe");
  final _emailController = TextEditingController(text: "johndoe@gmail.com");
  final _passwordController = TextEditingController(text: "********");
  final _telephoneController = TextEditingController(text: "+1 555-555-5555");
  final _adresseController = TextEditingController(text: "1234 Main St");*/

  bool _isEditing = false;

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUsername().then((value) {
      setState(() {
        _usernameController.text = value;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        actions: [
          IconButton(
            onPressed: _toggleEdit,
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                enabled: _isEditing,
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Prénom',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                enabled: _isEditing,
                //controller: _nomController,
                decoration: InputDecoration(
                  labelText: 'Nom',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                enabled: _isEditing,
                //controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                enabled: _isEditing,
                //controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                enabled: _isEditing,
                //controller: _telephoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Téléphone',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                enabled: _isEditing,
                //controller: _adresseController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Adresse',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
