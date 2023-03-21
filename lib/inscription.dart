import 'package:flutter/material.dart';
import 'main.dart';

class InscriptionPage extends StatefulWidget {
  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final _prenomController = TextEditingController();
  final _nomController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _telephoneController = TextEditingController();

  void _inscrire() {
    String prenom = _prenomController.text;
    String nom = _nomController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String telephone = _telephoneController.text;

    // Enregistrer les données dans une base de données ou un autre système de stockage

    // Naviguer vers la page de connexion
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Text('Inscription'),
          ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _prenomController,
              decoration: InputDecoration(hintText: 'Prénom'),
            ),
            TextField(
              controller: _nomController,
              decoration: InputDecoration(hintText: 'Nom'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(hintText: 'E-mail'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(hintText: 'Mot de passe'),
              obscureText: true,
            ),
            TextField(
              controller: _telephoneController,
              decoration: InputDecoration(hintText: 'Numéro de téléphone'),
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
              onPressed: _inscrire,
              child: Text("S'inscrire"),
            ),
          ],
        ),
      ),
    );
  }
}
