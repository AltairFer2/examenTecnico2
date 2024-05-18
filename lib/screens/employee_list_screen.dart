// employee_list_screen.dart
import 'package:flutter/material.dart';
import '../services/employee_service.dart';
import '../models/employee.dart';
import 'edit_employee_screen.dart';
import 'create_employee_screen.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late Future<List<Employee>> futureEmployees;

  @override
  void initState() {
    super.initState();
    futureEmployees = EmployeeService.getEmployees();
  }

  void _editEmployee(Employee employee) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => EditEmployeeScreen(employee: employee)),
    );
    if (result == true) {
      setState(() {
        futureEmployees = EmployeeService.getEmployees();
      });
    }
  }

  void _deleteEmployee(String id) async {
    await EmployeeService.deleteEmployee(id);
    setState(() {
      futureEmployees = EmployeeService.getEmployees();
    });
  }

  void _createEmployee() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CreateEmployeeScreen()),
    );
    if (result == true) {
      setState(() {
        futureEmployees = EmployeeService.getEmployees();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empleados'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _createEmployee,
          ),
        ],
      ),
      body: FutureBuilder<List<Employee>>(
        future: futureEmployees,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Employee employee = snapshot.data![index];
                return ListTile(
                  title: Text(employee.nombre),
                  subtitle: Text('${employee.correo} - ${employee.rfc}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _editEmployee(employee),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteEmployee(employee.id),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("No hay empleados"));
          }
        },
      ),
    );
  }
}
