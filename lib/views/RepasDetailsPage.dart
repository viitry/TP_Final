import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../RepasInformation.dart';
import 'package:http/http.dart' as http;

class RepasDetailsPage extends StatefulWidget {
  final Map repasData;

  RepasDetailsPage({required this.repasData});

  @override
  _RepasDetailsPageState createState() => _RepasDetailsPageState();
}

class _RepasDetailsPageState extends State<RepasDetailsPage> {
  Map<String, dynamic> productDetails = {};

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    try {
      final int productId = widget.repasData['product_id'];
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
          //color: Colors.green,
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
                //color: Colors.blue,
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
                  //color: Colors.red,
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
                        //color: Color.fromARGB(255, 41, 43, 165),
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Text(
                                'Information allergie bla bla',
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
                        //color: Color.fromARGB(255, 228, 227, 227),
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
                  //color: Color.fromARGB(255, 228, 227, 227),
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
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                            // CircleAvatar(
                            //   backgroundColor: Colors.grey[300],
                            //   child: const Text(
                            //     'M',
                            //     style: TextStyle(
                            //         fontSize: 16, color: Colors.black),
                            //   ),
                            // ),
                            // CircleAvatar(
                            //   backgroundColor: Colors.grey[300],
                            //   child: const Text(
                            //     'Me',
                            //     style: TextStyle(
                            //         fontSize: 16, color: Colors.black),
                            //   ),
                            // ),
                            // CircleAvatar(
                            //   backgroundColor: Colors.grey[300],
                            //   child: const Text(
                            //     'J',
                            //     style: TextStyle(
                            //         fontSize: 16, color: Colors.black),
                            //   ),
                            // ),
                            // CircleAvatar(
                            //   backgroundColor: Colors.grey[300],
                            //   child: const Text(
                            //     'V',
                            //     style: TextStyle(
                            //         fontSize: 16, color: Colors.black),
                            //   ),
                            // ),
                            // CircleAvatar(
                            //   backgroundColor: Colors.grey[300],
                            //   child: const Text(
                            //     'S',
                            //     style: TextStyle(
                            //         fontSize: 16, color: Colors.black),
                            //   ),
                            // ),
                            // CircleAvatar(
                            //   backgroundColor: Colors.grey[300],
                            //   child: const Text(
                            //     'D',
                            //     style: TextStyle(
                            //         fontSize: 16, color: Colors.black),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(bottom: 20),
                child: Center(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    color: Color.fromRGBO(46, 88, 123, 1),
                    onPressed: () {},
                    child: Text(
                      'Commander',
                      style: GoogleFonts.imprima(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
