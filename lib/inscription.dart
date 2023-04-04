import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'connexion.dart';
import 'main.dart';

class InscriptionPage extends StatefulWidget {
  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  //final _prenomController = TextEditingController();
  //final _nomController = TextEditingController();
  //final _telephoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  void _inscrire() {
    //String prenom = _prenomController.text;
    //String nom = _nomController.text;
    //String telephone = _telephoneController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmpassword = _confirmpasswordController.text;

    // Enregistrer les données dans une base de données ou un autre système de stockage

    // Naviguer vers la page de connexion
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
                // Bonjour
                Text('Bienvenue !',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 50,
                    )),
                SizedBox(height: 10),

                Text(
                  'Entrez vos informations pour vous inscrire!',
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
                          height: 250,
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
                                    controller: _emailController,
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
                                  controller: _passwordController,
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
                                  controller: _confirmpasswordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'Confirmer Mot de passe',
                                    hintStyle: GoogleFonts.imprima(),
                                  ),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),

                              SizedBox(
                                height: 27.0,
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 90.0),
                                child: TextButton(
                                  onPressed: _inscrire,
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
                                    'Sign up',
                                    style: GoogleFonts.imprima(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
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


/* 
@override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Inscription'),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(217, 217, 217, 217),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Text(
                          'Nom',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          style: TextStyle(height: 0.8),
                          controller: _nomController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        const Text(
                          'Prénom',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          style: TextStyle(height: 0.8),
                          controller: _prenomController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        const Text(
                          'E-mail',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          style: TextStyle(height: 0.8),
                          controller: _emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        const Text(
                          'Mot de passe',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          style: TextStyle(height: 0.8),
                          controller: _passwordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        const Text(
                          'Numero de telephone',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          style: TextStyle(height: 0.8),
                          controller: _telephoneController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _inscrire,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Color.fromARGB(255, 0, 0, 0),
                          ),
                          child: Text("S'inscrire"),
                        ),
                      ],
                    )),
              )),
        ));
  }
*/
