import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../services/file_upload_service.dart';

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  dynamic _selectedFile;

  void _pickFile() {
    if (kIsWeb) {
      html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
      uploadInput.accept = '.xlsx,.pdf'; // Limitar a tipos específicos de archivos
      uploadInput.click();

      uploadInput.onChange.listen((e) {
        final files = uploadInput.files;
        if (files!.isNotEmpty) {
          setState(() {
            _selectedFile = files.first;
          });
        }
      });
    } else {
      // Manejo de selección de archivos para otras plataformas, si es necesario
    }
  }

  Future<void> _uploadFile() async {
    if (_selectedFile != null) {
      bool isUploaded;
      if (kIsWeb) {
        isUploaded = await FileUploadService.uploadFileWeb(_selectedFile);
      } else {
        isUploaded = await FileUploadService.uploadFile(io.File(_selectedFile.path));
      }
      if (isUploaded) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Archivo subido con éxito'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al subir archivo'),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor selecciona un archivo primero'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cargar Archivo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Seleccionar Archivo'),
            ),
            if (_selectedFile != null)
              Text('Archivo seleccionado: ${_selectedFile.name}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadFile,
              child: Text('Subir Archivo'),
            ),
          ],
        ),
      ),
    );
  }
}
