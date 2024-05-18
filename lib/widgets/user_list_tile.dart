import 'package:flutter/material.dart';
import '../models/user.dart';

class UserListTile extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  UserListTile({required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(user.name.substring(0, 1)),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Icon(Icons.arrow_forward),
      onTap: onTap,
    );
  }
}
