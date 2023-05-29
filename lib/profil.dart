import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  Future getUserInfo(String token) async {
    var url = 'http://192.168.1.94/flutter_application_1/php/getUserInfo.php';
    var response = await http.post(Uri.parse(url), body: {
      "token": token,
    });

    if (response.statusCode == 200) {
      // Si la requête est réussie, récupérer les informations de l'utilisateur
      final user = jsonDecode(response.body) as Map<String, dynamic>;

      setState(() {
        _usernameController.text = user['username'];
        _nameController.text = user['name'];
        _emailController.text = user['email'];
        _phoneController.text = user['phone'];
        _addressController.text = user['address'];
      });
    } else {
      // Si la requête échoue, afficher un message d'erreur
      throw Exception('Failed to load user info');
    }
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    return token;
  }

  @override
  void initState() {
    super.initState();
    _getToken().then((value) {
      if (value.isNotEmpty) {
        getUserInfo(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              enabled: false,
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Nom d\'utilisateur',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              _usernameController.text,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              enabled: false,
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nom',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              enabled: false,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              enabled: false,
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Téléphone',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              enabled: false,
              controller: _addressController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Adresse',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
