// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_escapes, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/profil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'repaspage.dart';
import 'publier.dart';

class AccueilPage extends StatefulWidget {
  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  //Declare les variables
  String username = '';
  String searchQuery = '';

  // methode pour recuperer le username stocke avec la methode sharedPref
  Future<void> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    setState(() {
      username = storedUsername ?? '';
    });
  }

  // Stock la variable username avec setState
  @override
  initState() {
    super.initState();
    _getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 249, 255, 1),
      body: ListView(
        children: [
          SearchSection(
            onSearch: (query) {
              setState(() {
                searchQuery = query; // Mets à jour la valeur de searchQuery
              });
            },
          ),
          CategorySection(),
          RepasSection(
              searchQuery:
                  searchQuery), // Passe la valeur de searchQuery à RepasSection
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
    );
  }
}

class SearchSection extends StatelessWidget {
  final ValueChanged<String>
      onSearch; // Ajout de la fonction de rappel onSearch

  SearchSection({required this.onSearch});

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
                      backgroundColor: Color.fromARGB(176, 92, 134, 153),
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
                      onChanged: onSearch,
                      decoration: InputDecoration(
                        hintText: 'Rechercher un plat, une ville ...',
                        hintStyle: GoogleFonts.imprima(fontSize: 13),
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
class CategorySection extends StatefulWidget {
  @override
  _CategorySectionState createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  List<Map<String, dynamic>> repasList = [];

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
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                buildCategoryButton("Pizza", context),
                buildCategoryButton("Burger", context),
                buildCategoryButton("Dessert", context),
                buildCategoryButton("Végétarien", context),
                buildCategoryButton("Italiens", context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryButton(String categoryName, BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 3,
        margin: const EdgeInsets.only(right: 15),
        child: GestureDetector(
          onTap: () {
            getRepasByCategory(categoryName, context);
          },
          child: Text(
            categoryName,
            style: GoogleFonts.imprima(color: Colors.black),
          ),
        ));
  }

  void getRepasByCategory(String category, BuildContext context) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.92/flutter_application_1/php/get_repas_by_category.php?product_categorie=$category'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final repasList =
          data.map((repas) => Map<String, dynamic>.from(repas)).toList();
      setState(() {
        this.repasList = repasList;
      });
    } else {
      print('Erreur pour trouver repas data');
    }
  }
}

class RepasSection extends StatefulWidget {
  final String searchQuery; // Ajout de la variable searchQuery

  RepasSection({required this.searchQuery});

  @override
  _RepasSectionState createState() => _RepasSectionState();
}

class _RepasSectionState extends State<RepasSection> {
  List<Map<String, dynamic>> repasList = [];
  //final _scrollController = ScrollController();

  Future<void> getRepasData() async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.92/flutter_application_1/php/load_products.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      setState(() {
        repasList =
            data.map((repas) => Map<String, dynamic>.from(repas)).toList();
      });
    } else {
      print('Erreur pour trouver repas data');
    }
  }

  void updateRepasList(List<Map<String, dynamic>> data) {
    setState(() {
      repasList = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getRepasData();
  }

  @override
  Widget build(BuildContext context) {
    // Filtrer les repas en fonction de la recherche
    List<Map<String, dynamic>> filteredRepasList = repasList.where((repas) {
      final String title = repas['product_titre'].toLowerCase();
      final String location = repas['product_lieu'].toLowerCase();

      // Vérifier si le titre ou l'emplacement contiennent la recherche
      return title.contains(widget.searchQuery) ||
          location.contains(widget.searchQuery);
    }).toList();

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: filteredRepasList.length, // Utiliser la liste filtrée
          itemBuilder: (context, index) {
            final repas = filteredRepasList[index];
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
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: repasData['image_url'] ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 9,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      color: Color.fromRGBO(46, 88, 123, 1),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RepasDetailsPage(repasData: repasData)),
                        );
                      },
                      child: Text(
                        'En savoir plus',
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
                  SizedBox(height: 5),
                  Text(
                    'Publie par: ${repasData['username']}',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
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
