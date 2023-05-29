// ignore_for_file: equal_keys_in_map

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'inscription.dart';
import 'connexion.dart';
import 'accueil.dart';
import 'profil.dart';
import 'RepasInformation.dart';
import 'test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mon application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: {
        '/inscription': (context) => InscriptionPage(),
        '/connexion': (context) => ConnexionPage(),
        '/accueil': (context) => AccueilPage(),
        //'/accueil': (context) => SearchSection(),
        //'/accueil': (context) => RepasSection(),
        '/RepasInformation': (context) => RepasInformation(
              allergenes: '',
              heure: '',
              informations: '',
              jour: '',
              prix: 2,
            ),
        '/profil': (context) => ProfilPage(),
        '/test': (context) => TestPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page d\'accueil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/inscription');
              },
              child: Text('S\'inscrire'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/connexion');
              },
              child: Text('Se connecter'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/accueil');
              },
              child: Text('Accueil'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profil');
              },
              child: Text('Profil'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/test');
              },
              child: Text('test'),
            )
          ],
        ),
      ),
    );
  }
}
