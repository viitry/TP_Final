// ignore_for_file: equal_keys_in_map

import 'package:flutter/material.dart';
import 'inscription.dart';
import 'connexion.dart';
import 'accueil.dart';
import 'annonce.dart';
import 'profil.dart';

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
        '/annonce': (context) => AnnoncePage(),
        '/profil': (context) => ProfilPage(),
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
                Navigator.pushNamed(context, '/annonce');
              },
              child: Text('Annonce'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profil');
              },
              child: Text('Profil'),
            )
          ],
        ),
      ),
    );
  }
}
