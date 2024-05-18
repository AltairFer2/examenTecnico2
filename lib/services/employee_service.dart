// employee_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/employee.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeService {
  static const String _baseUrl =
      'http://localhost:3000'; // Ajusta esto a la URL de tu servidor

  static Future<List<Employee>> getEmployees() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt');
    if (token == null) {
      throw Exception('Token no encontrado');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/api/employees'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> employeeJson = json.decode(response.body);
      return employeeJson.map((json) => Employee.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar empleados: ${response.body}');
    }
  }

  static Future<Employee> createEmployee(Employee employee) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt');
    if (token == null) {
      throw Exception('Token no encontrado');
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/api/employees'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(employee.toJson()),
    );

    if (response.statusCode == 200) {
      return Employee.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al crear empleado: ${response.body}');
    }
  }

  static Future<bool> updateEmployee(String id, Employee employee) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt');
    if (token == null) {
      throw Exception('Token no encontrado');
    }

    final response = await http.put(
      Uri.parse('$_baseUrl/api/employees/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(employee.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error al actualizar el empleado: ${response.body}');
    }
  } catch (e) {
    print('Error al actualizar el empleado: $e');
    throw Exception('Error al actualizar el empleado: $e');
  }
}


  static Future<void> deleteEmployee(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt');
    if (token == null) {
      throw Exception('Token no encontrado');
    }

    final response = await http.delete(
      Uri.parse('$_baseUrl/api/employees/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar empleado: ${response.body}');
    }
  }
}
