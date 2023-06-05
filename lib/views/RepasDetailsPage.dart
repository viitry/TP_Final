import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'chatbox.dart';

class RepasDetailsPage extends StatefulWidget {
  final Map repasData;

  RepasDetailsPage({required this.repasData});

  @override
  _RepasDetailsPageState createState() => _RepasDetailsPageState();
}

class _RepasDetailsPageState extends State<RepasDetailsPage> {
  Map<String, dynamic> productDetails = {};

  Future<String> commanderPlat(int productID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? '';
    String token = prefs.getString('token') ?? '';

    final response = await http.post(
      Uri.parse(
          'http://192.168.1.94/flutter_application_1/php/commanderPlat.php'),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        "username": username,
        "productID": productID.toString(),
        "token": token,
      },
    );
    if (response.statusCode == 200) {
      sendEmailToSeller(widget.repasData['username'], "Nouvelle commande",
          "L'utilisateur $username souhaite acheter un de vos repas '${widget.repasData['product_titre']}'");
    }

    return response.body;
  }

  Future<void> sendEmailToSeller(
      String productUsername, String subject, String message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    final response = await http.post(
      Uri.parse(
          'http://192.168.1.94/flutter_application_1/php/getUserInfos.php'),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        "username": productUsername,
        "token": token,
      },
    );

    final result = jsonDecode(response.body);

    if (result != null &&
        result['success'] == true &&
        result['user'] != null &&
        result['user']['email'] != null) {
      String sellerEmail = result['user']['email'];

      // Envoyer l'e-mail au vendeur en utilisant l'adresse e-mail de l'utilisateur connecté comme expéditeur
      // ...
    } else {
      // Afficher un message d'erreur
      // ...
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    try {
      final int productId = widget.repasData['user_id'];
      final details = await fetchProductDetails(productId);
      setState(() {
        productDetails = details;
      });
    } catch (error) {
      // Gérer les erreurs lors de la récupération des détails du produit
      print('Erreur lors de la récupération des détails du produit: $error');
    }
  }

  Future<Map<String, dynamic>> fetchProductDetails(int id) async {
    final url =
        'http:192.168.1.94/flutter_application_1/php/get_products_details.php?id=$id';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Conversion de la réponse JSON en Map
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to fetch product details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.repasData['image_url'],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.repasData['product_titre'],
                      style: GoogleFonts.imprima(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '\€' + widget.repasData['product_prix'],
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
                      widget.repasData['product_lieu'],
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Text(
                          'Description',
                          style: GoogleFonts.imprima(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          widget.repasData['product_desc'],
                          style: GoogleFonts.imprima(
                            fontSize: 14,
                            color: Color.fromRGBO(46, 88, 123, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Text(
                                'Information allergie',
                                style: GoogleFonts.imprima(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                widget.repasData['product_allergie'],
                                style: GoogleFonts.imprima(
                                  fontSize: 14,
                                  color: Color.fromRGBO(46, 88, 123, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.only(right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Text(
                                'Informations supplémentaires',
                                style: GoogleFonts.imprima(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                widget.repasData['product_info'],
                                style: GoogleFonts.imprima(
                                  fontSize: 14,
                                  color: Color.fromRGBO(46, 88, 123, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Text(
                          'Jour disponible',
                          style: GoogleFonts.imprima(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              child: Text(
                                widget.repasData['product_jour'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 90.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  receiverUsername:
                                      'username', // Remplacer par le pseudo de l'utilisateur qui a publié l'annonce
                                ),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Color.fromRGBO(46, 88, 123, 100),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                          ),
                          child: Text(
                            'Contacter',
                            style: GoogleFonts.imprima(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Container(
              //   color: Colors.white,
              //   margin: EdgeInsets.only(bottom: 20),
              //   child: Center(
              //     child: MaterialButton(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(25),
              //       ),
              //       color: Color.fromRGBO(46, 88, 123, 1),
              //       onPressed: () => commanderPlat(productID),
              //       child: Text(
              //         'Commander',
              //         style: GoogleFonts.imprima(color: Colors.white),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

void _commander() {}
