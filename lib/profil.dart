import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final _prenomController = TextEditingController(text: "John");
  final _nomController = TextEditingController(text: "Doe");
  final _emailController = TextEditingController(text: "johndoe@gmail.com");
  final _passwordController = TextEditingController(text: "********");
  final _telephoneController = TextEditingController(text: "+1 555-555-5555");
  final _adresseController = TextEditingController(text: "1234 Main St");

  bool _isEditing = false;

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
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
                controller: _prenomController,
                decoration: InputDecoration(
                  labelText: 'Prénom',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                enabled: _isEditing,
                controller: _nomController,
                decoration: InputDecoration(
                  labelText: 'Nom',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                enabled: _isEditing,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                enabled: _isEditing,
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                enabled: _isEditing,
                controller: _telephoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Téléphone',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                enabled: _isEditing,
                controller: _adresseController,
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
