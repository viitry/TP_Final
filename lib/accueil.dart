// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_escapes, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/database_helper.dart';

import 'RepasDetailsPage.dart';
import 'profil.dart';
import 'publier.dart';

class AccueilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 249, 255, 1),
      body: ListView(
        children: [
          SearchSection(),
          CategorySection(),
          RepasSection(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilPage()),
              );
            },
            backgroundColor: Colors.red,
            mini: true,
            child: Icon(Icons.favorite, color: Colors.white),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PublierPage()),
              );
            },
            backgroundColor: Colors.blue,
            child: Icon(Icons.add, color: Colors.white),
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
      height: 255,
      child: SafeArea(
        child: Center(
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
                          MaterialPageRoute(builder: (context) => ProfilPage()),
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
                  child: Flexible(
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
    );
  }
}

// ignore: use_key_in_widget_constructors
class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
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
          //SizedBox(height: 10),
          Container(
            height: 40,
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

class RepasSection extends StatefulWidget {
  @override
  _RepasSectionState createState() => _RepasSectionState();
}

class _RepasSectionState extends State<RepasSection> {
  List<Map<String, dynamic>> repasList = [];

  @override
  void initState() {
    super.initState();
    fetchRepasData();
  }

  Future<void> fetchRepasData() async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.94/flutter_application_1/php/loadproducts.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      setState(() {
        repasList =
            data.map((repas) => Map<String, dynamic>.from(repas)).toList();
      });
    } else {
      print('Failed to fetch repas data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: repasList.length,
          itemBuilder: (context, index) {
            final repas = repasList[index];
            return RepasCard(repas);
          },
        ),
      ],
    );
  }
}

class RepasCard extends StatelessWidget {
  final Map<String, dynamic> repasData;

  RepasCard(this.repasData);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RepasDetailsPage(repasData: repasData),
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
                    repasData['picture'] ?? '',
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
                    repasData['product_titre'] ?? '',
                    style: GoogleFonts.imprima(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '\€${repasData['product_prix'] ?? ''}',
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
                    repasData['product_lieu'] ?? '',
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
                        repasData['product_desc'] ?? '',
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

/*class YourScreenName extends StatefulWidget {
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
}*/

void _commander() {}
