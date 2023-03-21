import 'package:flutter/material.dart';

class ConnexionPage extends StatefulWidget {
  @override
  _ConnexionPageState createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _connecter() {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Vérifier les données dans une base de données ou un autre système de stockage

    // Naviguer vers la page d'accueil
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(hintText: 'E-mail'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(hintText: 'Mot de passe'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _connecter,
              child: Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}
