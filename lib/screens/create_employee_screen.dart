import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/employee_service.dart';

class CreateEmployeeScreen extends StatefulWidget {
  @override
  _CreateEmployeeScreenState createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _nombre;
  late String _correo;
  late String _rfc;
  late String _domicilioFiscal;
  late String _curp;
  late int _numeroSeguridadSocial; // Cambiado a int
  late String _fechaInicioLaboral;
  late String _tipoContrato;
  late String _departamento;
  late String _puesto;
  late int _salarioDiario;
  late int _salario;
  late int _claveEntidad; // Cambiado a int
  late String _estado;

  Future<void> _saveEmployee() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Employee newEmployee = Employee(
        id: '',
        nombre: _nombre,
        correo: _correo,
        rfc: _rfc,
        domicilioFiscal: _domicilioFiscal,
        curp: _curp,
        numeroSeguridadSocial: _numeroSeguridadSocial, // Cambiado a int
        fechaInicioLaboral: _fechaInicioLaboral,
        tipoContrato: _tipoContrato,
        departamento: _departamento,
        puesto: _puesto,
        salarioDiario: _salarioDiario,
        salario: _salario,
        claveEntidad: _claveEntidad, // Cambiado a int
        estado: _estado,
      );
      await EmployeeService.createEmployee(newEmployee);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Empleado'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveEmployee,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                onSaved: (value) => _nombre = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Correo'),
                onSaved: (value) => _correo = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa un correo';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'RFC'),
                onSaved: (value) => _rfc = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa un RFC';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Domicilio Fiscal'),
                onSaved: (value) => _domicilioFiscal = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa un domicilio fiscal';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'CURP'),
                onSaved: (value) => _curp = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa un CURP';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Número de Seguridad Social'),
                onSaved: (value) => _numeroSeguridadSocial = int.parse(value!), // Convertido a int
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa un número de seguridad social';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Fecha de Inicio Laboral'),
                onSaved: (value) => _fechaInicioLaboral = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa una fecha de inicio laboral';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tipo de Contrato'),
                onSaved: (value) => _tipoContrato = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa un tipo de contrato';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Departamento'),
                onSaved: (value) => _departamento = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa un departamento';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Puesto'),
                onSaved: (value) => _puesto = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa un puesto';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Salario Diario'),
                onSaved: (value) => _salarioDiario = int.parse(value!),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa un salario diario';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Salario'),
                onSaved: (value) => _salario = int.parse(value!),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa un salario';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Clave Entidad'),
                onSaved: (value) => _claveEntidad = int.parse(value!), // Convertido a int
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa una clave de entidad';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Estado'),
                onSaved: (value) => _estado = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa un estado';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
