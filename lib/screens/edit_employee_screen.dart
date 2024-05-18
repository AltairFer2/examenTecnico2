import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/employee_service.dart';

class EditEmployeeScreen extends StatefulWidget {
  final Employee employee;

  EditEmployeeScreen({required this.employee});

  @override
  _EditEmployeeScreenState createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
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

  @override
  void initState() {
    super.initState();
    _nombre = widget.employee.nombre;
    _correo = widget.employee.correo;
    _rfc = widget.employee.rfc;
    _domicilioFiscal = widget.employee.domicilioFiscal;
    _curp = widget.employee.curp;
    _numeroSeguridadSocial = widget.employee.numeroSeguridadSocial; // Cambiado a int
    _fechaInicioLaboral = widget.employee.fechaInicioLaboral;
    _tipoContrato = widget.employee.tipoContrato;
    _departamento = widget.employee.departamento;
    _puesto = widget.employee.puesto;
    _salarioDiario = widget.employee.salarioDiario;
    _salario = widget.employee.salario;
    _claveEntidad = widget.employee.claveEntidad; // Cambiado a int
    _estado = widget.employee.estado;
  }

  Future<void> _saveEmployee() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Employee updatedEmployee = Employee(
        id: widget.employee.id,
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
      await EmployeeService.updateEmployee(widget.employee.id, updatedEmployee);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Empleado'),
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
                initialValue: _nombre,
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
                initialValue: _correo,
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
                initialValue: _rfc,
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
                initialValue: _domicilioFiscal,
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
                initialValue: _curp,
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
                initialValue: _numeroSeguridadSocial.toString(), // Convertido a String
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
                initialValue: _fechaInicioLaboral,
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
                initialValue: _tipoContrato,
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
                initialValue: _departamento,
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
                initialValue: _puesto,
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
                initialValue: _salarioDiario.toString(),
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
                initialValue: _salario.toString(),
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
                initialValue: _claveEntidad.toString(), // Convertido a String
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
                initialValue: _estado,
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
