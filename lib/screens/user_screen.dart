import 'package:examen/screens/user_details_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/user_list_tile.dart';
import '../models/user.dart';

class UsersScreen extends StatelessWidget {
  final List<User> users = [
    User(id: '1', name: 'John Doe', email: 'john@example.com', rfc: 'RFC123'),
    User(id: '2', name: 'Jane Doe', email: 'jane@example.com', rfc: 'RFC456'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return UserListTile(
            user: users[index],
            onTap: () {
              // Acción al tocar el usuario, por ejemplo, navegar a una pantalla de detalles
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UserDetailsScreen(user: users[index])));
            },
          );
        },
      ),
    );
  }
}
