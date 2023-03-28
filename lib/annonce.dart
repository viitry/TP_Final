import 'package:flutter/material.dart';

class AnnoncePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Annonce'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text(
            'Mon titre',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/momo.jpg',
                height: 200.0,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: ElevatedButton(
                  child: Text('Réserver'),
                  onPressed: () {
                    // Action à réaliser lors de la réservation
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text(
            'Ma description',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Informations allergie',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Informations supplémentaires',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
