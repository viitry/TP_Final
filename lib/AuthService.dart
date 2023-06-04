import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  // Crée une instance statique de la classe
  static final AuthService _instance = AuthService._internal();

  // Constructeur privé pour empêcher l'instanciation directe de la classe
  AuthService._internal();

  // Renvoie l'instance unique de la classe
  static AuthService get instance => _instance;
  Future<String> getCurrentUser() async {
    final url = Uri.parse(
        'http://192.168.1.94/flutter_application_1/php/get_current_user.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);

      // Analyser la réponse JSON
      final data = jsonDecode(response.body);
      final username = data as String;
      return username;
    } else {
      // Gérer les erreurs de la requête HTTP
      throw Exception(
          'Erreur lors de la récupération du pseudo de l\'utilisateur');
    }
  }

  // Autres fonctions liées à l'authentification et à l'utilisateur...
}
