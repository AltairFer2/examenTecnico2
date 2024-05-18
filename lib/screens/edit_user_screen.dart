import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class EditUserScreen extends StatefulWidget {
  final User user;

  EditUserScreen({required this.user});

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _rfc;

  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _email = widget.user.email;
    _rfc = widget.user.rfc;
  }

  void _saveUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      User updatedUser = User(
        id: widget.user.id,
        name: _name,
        email: _email,
        rfc: _rfc,
      );
      bool isUpdated = await UserService.updateUser(updatedUser);
      if (isUpdated) {
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al actualizar usuario'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Nombre'),
                onSaved: (value) {
                  _name = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa el nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Correo electrónico'),
                onSaved: (value) {
                  _email = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa el correo electrónico';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _rfc,
                decoration: InputDecoration(labelText: 'RFC'),
                onSaved: (value) {
                  _rfc = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa el RFC';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveUser,
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
