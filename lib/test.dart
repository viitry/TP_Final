import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/database_helper.dart';

import 'views/RepasDetailsPage.dart';
import 'profil.dart';
import 'AuthService.dart';

/*class FoodApp extends StatefulWidget {
  @override
  _FoodAppState createState() => _FoodAppState();
}

class _FoodAppState extends State<FoodApp> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Food App'),
      ),
      body: ListView.builder(
        itemCount: repasList.length,
        itemBuilder: (context, index) {
          final repas = repasList[index];
          return RepasCard(repas);
        },
      ),
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

void _commander() {}
*/

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Future<Map<String, dynamic>> getLastUser() async {
    var response = await http.get(Uri.parse(
        'http://192.168.1.94/flutter_application_1/php/get_user.php'));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);

      if (responseBody is Map<String, dynamic>) {
        return responseBody;
      }
    }

    throw Exception('Failed to get last user.');
  }

  String _username = '';

  @override
  void initState() {
    super.initState();
    _getLastUser();
  }

  Future<void> _getLastUser() async {
    final user = await getLastUser();
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
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}

// class _TestPageState extends State<TestPage> {
//   AuthService authService = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Accueil'),
//       ),
//       body: Center(
//         child: FutureBuilder<String>(
//           future: authService.getCurrentUser(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasData) {
//               String username = snapshot.data ?? 'Unknown User';
//               return Text('Bienvenue, $username');
//             } else {
//               return Text('Utilisateur non connecté');
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
