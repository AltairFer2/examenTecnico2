import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/post.dart';

class PostService {
  static const String _baseUrl = 'http://localhost:3000';

  static Future<List<Post>> getPosts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt');

      if (token == null) {
        throw Exception('Token no encontrado');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/api/posts'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> postJson = json.decode(response.body);
        return postJson.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar publicaciones: ${response.body}');
      }
    } catch (e) {
      print('Error al cargar publicaciones: $e');
      throw Exception('Error al cargar publicaciones: $e');
    }
  }  

  static Future<void> createPost(Post post) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt');

      if (token == null) {
        throw Exception('Token no encontrado');
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/api/posts'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'title': post.title,
          'body': post.body,
          'userId': post.userId,
        }),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode != 201) {
        throw Exception('Error al crear la publicación: ${response.body}');
      } else {
        print('Publicación creada con éxito');
      }
    } catch (e) {
      print('Error al crear la publicación: $e');
      throw Exception('Error al crear la publicación: $e');
    }
  }

  static Future<void> updatePost(String postId, Post post) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt');

      if (token == null) {
        throw Exception('Token no encontrado');
      }

      final response = await http.put(
        Uri.parse('$_baseUrl/api/posts/$postId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'title': post.title,
          'body': post.body,
          'userId': post.userId,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Error al actualizar la publicación: ${response.body}');
      }
    } catch (e) {
      print('Error al actualizar la publicación: $e');
      throw Exception('Error al actualizar la publicación: $e');
    }
  }

  static Future<void> deletePost(String postId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt');

      if (token == null) {
        throw Exception('Token no encontrado');
      }

      final response = await http.delete(
        Uri.parse('$_baseUrl/api/posts/$postId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Error al eliminar la publicación: ${response.body}');
      }
    } catch (e) {
      print('Error al eliminar la publicación: $e');
      throw Exception('Error al eliminar la publicación: $e');
    }
  }
}
