import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RepasInformation extends StatelessWidget {
  final String allergenes;
  final String informations;
  final String jour;
  final String heure;
  final double prix;
  final Function()? onCommander;

  RepasInformation({
    required this.allergenes,
    required this.informations,
    required this.jour,
    required this.heure,
    required this.prix,
    this.onCommander,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Color.fromRGBO(46, 88, 123, 1),
          width: 2,
        ),
      ),
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Text(
              "Information allergène",
              style: GoogleFonts.imprima(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              allergenes,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Text(
              "Information complémentaire",
              style: GoogleFonts.imprima(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              informations,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choisir le Jour",
                    style: GoogleFonts.imprima(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    jour,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choisir l'heure",
                    style: GoogleFonts.imprima(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    heure,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MaterialButton(
              minWidth: double.infinity,
              height: 60,
              color: Color.fromRGBO(255, 0, 0, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: onCommander,
              child: Text(
                "Commander pour ${prix.toString()} €",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
