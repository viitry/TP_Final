// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_escapes, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/database_helper.dart';

import 'RepasDetailsPage.dart';
import 'profil.dart';
import 'publier.dart';

/*Future<Map<String, dynamic>> getLastUser() async {
  final response = await http.get(Uri.parse(
      'http://192.168.1.94/flutter_application_1/php/get_last_user.php'));

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);

    if (responseBody is Map<String, dynamic>) {
      return responseBody;
    }
  }

  throw Exception('Failed to get last user.');
}*/

class AccueilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(241, 249, 255, 1),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SearchSection(),
                CategorySection(),
                RepasSection(),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilPage()),
                );
              },
              backgroundColor: Colors.red,
              child: Icon(Icons.favorite, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PublierPage()),
                );
              },
              backgroundColor: Colors.blue,
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
      drawer: Drawer(),
    );
  }
}

class SearchSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilPage()),
                          );
                        },
                        backgroundColor: Colors.grey,
                        mini: true,
                        child: Icon(Icons.person),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/logo.jpeg',
                        height: 120.0,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Container(
                    height: 40,
                    child: Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Rechercher un plat, une ville ...',
                          hintStyle: GoogleFonts.imprima(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10.0),
                        ),
                      ),
                    ),
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

class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                'Catégorie',
                style: GoogleFonts.imprima(
                    color: Color.fromRGBO(0, 0, 0, 0.612),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              SizedBox(height: 5),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 3,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.black, width: 0.5),
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Text("Pizza",
                      style: GoogleFonts.imprima(color: Colors.black)),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 3,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.black, width: 0.5),
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Text("Burger",
                      style: GoogleFonts.imprima(color: Colors.black)),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 3,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.black, width: 0.5),
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Text("Dessert",
                      style: GoogleFonts.imprima(color: Colors.black)),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 3,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.black, width: 0.5),
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Text("Végétarien",
                      style: GoogleFonts.imprima(color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RepasSection extends StatelessWidget {
  final List RepasList = [
    {
      'title': 'Pasta very good',
      'place': 'Paris, 16eme',
      'review': 36,
      'picture': 'assets/images/repas.jpeg',
      'price': '3',
      'allergies': 'Oeuf' 'Noix',
      'description':
          'Un plat vraiment delicieux, cest super bon miam miam encore jai faim, Un plat vraiment delicieux, cest super bon miam miam encore jai faim Un plat vraiment delicieux, cest super bon miam miam encore jai faim',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Container(
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          Column(
            children: RepasList.map((repas) {
              return RepasCard(repas);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class RepasCard extends StatelessWidget {
  final Map RepasData;
  RepasCard(this.RepasData);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RepasDetailsPage(repasData: RepasData),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        height: 230,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 4,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
                image: DecorationImage(
                  image: AssetImage(
                    RepasData['picture'],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 5,
                    right: 9,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      color: Color.fromRGBO(46, 88, 123, 1),
                      onPressed: _commander,
                      child: Text(
                        'Commander',
                        style: GoogleFonts.imprima(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    RepasData['title'],
                    style: GoogleFonts.imprima(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '\€' + RepasData['price'],
                    style: GoogleFonts.imprima(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    RepasData['place'],
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        RepasData['description'],
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 3, 10, 0),
            ),
          ],
        ),
      ),
    );
  }
}

class YourScreenName extends StatefulWidget {
  @override
  _YourScreenNameState createState() => _YourScreenNameState();
}

class _YourScreenNameState extends State<YourScreenName> {
  String _username = '';

  @override
  void initState() {
    super.initState();
    _getLastUser();
  }

  Future<void> _getLastUser() async {
    final user = await DatabaseHelper.instance.getLastUser();
    setState(() {
      _username = user['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Bienvenue, $_username!',
          style: TextStyle(fontSize: 10.0),
        ),
      ),
    );
  }
}

void _commander() {}
