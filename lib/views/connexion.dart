// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/inscription.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'accueil.dart';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key});

  @override
  _ConnexionPageState createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future login(BuildContext context) async {
    if (username.text == "" || password.text == "") {
      Fluttertoast.showToast(
          msg: "Veuillez remplir tous les champs",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16.0);
    } else {
      var url = "http://192.168.1.92/flutter_application_1/php/login.php";
      var response = await http.post(Uri.parse(url), body: {
        "username": username.text,
        "password": password.text,
      });
      var data = json.decode(response.body);

      if (data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Bienvenue",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);

        // Stocke le token d'authentification dans SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        await prefs.setString('username', username.text);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AccueilPage()));
      } else {
        Fluttertoast.showToast(
            msg: "Nom d'utilisateur ou/et mot de passe incorrect",
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
                Text('Bonjour !',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 50,
                    )),
                SizedBox(height: 10),
                Text(
                  'Connectez-vous pour découvrir de delicieux plats!',
                  style: GoogleFonts.imprima(fontSize: 18),
                ),
                SizedBox(height: 35),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(55, 134, 150, 150),
                            border: Border.all(
                              width: 0.3,
                              color: Color.fromARGB(55, 89, 119, 100),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // champ de texte pour l'email
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

                              SizedBox(
                                height: 27.0,
                              ),

                              // Bouton pour se connecter
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 90.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(46, 88, 123, 100),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.0),
                                  ),
                                  onPressed: () {
                                    login(context);
                                  },
                                  child: Text(
                                    'Se connecter',
                                    style: GoogleFonts.imprima(
                                        color: Colors.white),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 5,
                              ),

                              // Texte "Pas Membre Cree un compte"
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Pas membre ? ',
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
                                                InscriptionPage()),
                                      );
                                    },
                                    child: Text(
                                      'Cree un compte ',
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
