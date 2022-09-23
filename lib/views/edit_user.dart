import 'package:flutter/material.dart';
import 'package:mygetxapp/models/user_model.dart';

class EditUser extends StatelessWidget {
  final User user;
  final Function edit;

  EditUser({required this.user, required this.edit, super.key});

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    firstNameController.text = user.firstName;
    lastNameController.text = user.lastName;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User: ${user.firstName} ${user.lastName}'),
        centerTitle: true,
        backgroundColor: Colors.green[600],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  hintText: 'First Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  hintText: 'Last Name',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                edit(user, firstNameController.text, lastNameController.text);
                Navigator.pop(context);
              },
              child: const Text('Edit User'),
            ),
          ],
        ),
      ),
    );
  }
}
