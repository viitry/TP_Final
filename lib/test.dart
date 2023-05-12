import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/database_helper.dart';

import 'RepasDetailsPage.dart';
import 'profil.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Future<Map<String, dynamic>> getLastUser() async {
    var response = await http.get(Uri.parse(
        'http://192.168.1.94/flutter_application_1/php/get_last_user.php'));

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
