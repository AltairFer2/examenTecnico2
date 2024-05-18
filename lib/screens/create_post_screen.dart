import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/post.dart';
import '../services/post_service.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _body;

  Future<void> _savePost() async {
    print('Método _savePost llamado'); // Verificación inicial
    if (_formKey.currentState!.validate()) {
      print('Formulario validado'); // Verificación de validación del formulario
      _formKey.currentState!.save();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      if (userId == null) {
        throw Exception('ID del usuario no encontrado');
      }

      print('Guardando publicación...'); // Antes de guardar la publicación
      Post newPost = Post(id: '', title: _title, body: _body, userId: userId);

      try {
        await PostService.createPost(newPost);
        print('Publicación guardada. Cerrando pantalla...'); // Después de guardar la publicación

        // Verificar si el contexto es válido antes de intentar cerrarlo
        if (!mounted) return;
        Navigator.of(context).pop(true);
      } catch (e) {
        print('Error al guardar la publicación: $e');
      }
    } else {
      print('Formulario no validado'); // Si la validación falla
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Publicación'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _savePost,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Título'),
                onSaved: (value) => _title = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contenido'),
                onSaved: (value) => _body = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa el contenido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePost,
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
