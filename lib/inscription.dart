// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unused_local_variable, library_private_types_in_public_api, use_key_in_widget_constructors, unused_import

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'connexion.dart';
import 'main.dart';
import 'accueil.dart';

class InscriptionPage extends StatefulWidget {
  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repeatpassword = TextEditingController();

  Future register(BuildContext cont) async {
    if (username.text == "" ||
        password.text == "" ||
        repeatpassword.text == "") {
      Fluttertoast.showToast(
          msg: "Veuillez remplir tous les champs",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0);
    } else {
      if (password.text == repeatpassword.text) {
        var url = "http://192.168.1.94/flutter_application_1/php/register.php";
        var response = await http.post(Uri.parse(url), body: {
          "username": username.text,
          "password": password.text,
        });

        var data = json.decode(response.body);
        if (data['status'] == "success") {
          String token =
              data['token']; // Récupérer le token généré depuis la réponse
          Fluttertoast.showToast(
              msg: "Vous avez créé votre compte !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              fontSize: 16.0);

          // Enregistrer le token dans le stockage local (par exemple, Shared Preferences)

          Navigator.push(
              cont, MaterialPageRoute(builder: (context) => AccueilPage()));
        } else {
          Fluttertoast.showToast(
              msg: "La combinaison n'existe pas",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: "La combinaison n'existe pas",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 249, 255, 1),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.jpeg',
                  height: 150.0,
                ),
                SizedBox(height: 15),
                Text('Bienvenue !', style: GoogleFonts.bebasNeue(fontSize: 50)),
                SizedBox(height: 10),
                Text('Entrez vos informations pour vous inscrire!',
                    style: GoogleFonts.imprima(fontSize: 18)),
                SizedBox(height: 35),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(55, 134, 150, 150),
                            border: Border.all(
                              width: 0.3,
                              color: Color.fromARGB(55, 89, 119, 100),
                            ),
                          ),

                          // Champ de texte pour l'email
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 11.0),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: TextField(
                                    controller: username,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'Email',
                                      hintStyle: GoogleFonts.imprima(),
                                    ),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),

                              // champ de texte pour le mot de passe
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: TextField(
                                  controller: password,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'Mot de passe',
                                    hintStyle: GoogleFonts.imprima(),
                                  ),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              SizedBox(height: 20.0),

                              // Champ texte confirmer le mdp
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: TextField(
                                  controller: repeatpassword,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'Confirmer Mot de passe',
                                    hintStyle: GoogleFonts.imprima(),
                                  ),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),

                              // ignore: prefer_const_constructors
                              SizedBox(height: 27.0),

                              // Bouton S'inscrire
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 90.0),
                                child: TextButton(
                                  onPressed: () {
                                    register(context);
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(46, 88, 123, 100),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.0),
                                  ),
                                  child: Text(
                                    'S\'inscrire',
                                    style: GoogleFonts.imprima(
                                        color: Colors.white),
                                  ),
                                ),
                              ),

                              SizedBox(height: 5),

                              // Texte "deja membre ? Connectez-vous"
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Deja membre ? ',
                                    style: GoogleFonts.imprima(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConnexionPage()),
                                      );
                                    },
                                    child: Text(
                                      'connectez-vous ',
                                      style: GoogleFonts.imprima(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
