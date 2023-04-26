import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'RepasInformation.dart';

class RepasDetailsPage extends StatelessWidget {
  final Map repasData;

  RepasDetailsPage({required this.repasData});

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
                    image: DecorationImage(
                      image: AssetImage(
                        repasData['picture'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      repasData['title'],
                      style: GoogleFonts.imprima(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '\€' + repasData['price'],
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
                      repasData['place'],
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
                child: Container(),
              ),
              Container(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
