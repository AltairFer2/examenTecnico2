import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:universal_html/html.dart' as html;

class FileUploadService {
  static const String _baseUrl = 'http://localhost:3000/api/files';

  static Future<bool> uploadFile(File file) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt');
      if (token == null) {
        throw Exception('Token no encontrado');
      }

      var uri = Uri.parse('$_baseUrl/upload');
      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..files.add(await http.MultipartFile.fromPath('file', file.path,
            filename: path.basename(file.path)));

      var response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error al cargar archivo: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error al cargar archivo: $e');
      return false;
    }
  }

  static Future<bool> uploadFileWeb(html.File file) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwt');
      if (token == null) {
        throw Exception('Token no encontrado');
      }

      var uri = Uri.parse('$_baseUrl/upload');
      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token';

      var reader = html.FileReader();
      reader.readAsArrayBuffer(file);
      await reader.onLoad.first;

      var data = reader.result as List<int>;
      var multipartFile = http.MultipartFile.fromBytes('file', data, filename: file.name);

      request.files.add(multipartFile);

      var response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error al cargar archivo: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error al cargar archivo: $e');
      return false;
    }
  }
}
