import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String _baseUrl = 'http://localhost:3000/api/users';

  // Método para obtener los detalles de un usuario por ID
  static Future<User?> getUserById(String userId) async {
    try {
      var response = await http.get(Uri.parse('$_baseUrl/$userId'));
      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        print('Error al cargar el usuario');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<List<User>> getUsers() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt');
      if (token == null) {
        throw Exception('Token no encontrado');
      }
      print('Token utilizado para solicitar usuarios: $token');

      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        List<dynamic> userJson = json.decode(response.body);
        return userJson.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar usuarios: ${response.body}');
      }
    } catch (e) {
      print('Error al cargar usuarios: $e');
      throw Exception('Error al cargar usuarios: $e');
    }
  }

  // Método para actualizar un usuario
  static Future<bool> updateUser(User user) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt');
      if (token == null) {
        throw Exception('Token no encontrado');
      }

      var response = await http.put(
        Uri.parse('$_baseUrl/${user.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(user.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error al actualizar el usuario: $e');
      return false;
    }
  }

  // Método para crear un nuevo usuario
  static Future<User?> createUser(User user) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt');
      if (token == null) {
        throw Exception('Token no encontrado');
      }

      var response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(user.toJson()),
      );
      if (response.statusCode == 201) {
        return User.fromJson(json.decode(response.body));
      } else {
        print('Fallo al crear el usuario');
        return null;
      }
    } catch (e) {
      print('Error creando al usuario: $e');
      return null;
    }
  }

  static Future<bool> deleteUser(String userId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt');
      if (token == null) {
        throw Exception('Token no encontrado');
      }

      final response = await http.delete(
        Uri.parse('$_baseUrl/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error al eliminar usuario: $e');
      return false;
    }
  }
}
