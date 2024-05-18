import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';

class EditPostScreen extends StatefulWidget {
  final Post post;

  EditPostScreen({required this.post});

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _body;

  @override
  void initState() {
    super.initState();
    _title = widget.post.title;
    _body = widget.post.body;
  }

  Future<void> _savePost() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Post updatedPost = Post(
        id: widget.post.id,
        title: _title,
        body: _body,
        userId: widget.post.userId,
      );
      await PostService.updatePost(widget.post.id, updatedPost);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Publicación'),
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
                initialValue: _title,
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
                initialValue: _body,
                decoration: InputDecoration(labelText: 'Contenido'),
                onSaved: (value) => _body = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa el contenido';
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
