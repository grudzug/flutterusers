import 'package:flutter/material.dart';
import 'package:mygetxapp/models/user_model.dart';

class UserCreationForm extends StatelessWidget {
  final User? user;
  final Function mutate;

  UserCreationForm({this.user, required this.mutate, super.key});

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  void handleSubmit(context) {
    if (user != null) {
      mutate(user, firstNameController.text, lastNameController.text);
    } else {
      mutate(firstNameController.text, lastNameController.text);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var isEditing = user != null;
    firstNameController.text = isEditing ? user!.firstName : '';
    lastNameController.text = isEditing ? user!.lastName : '';
    return Scaffold(
      appBar: AppBar(
        title: isEditing
            ? Text('Edit User: ${user!.firstName} ${user!.lastName}')
            : const Text('Add new User'),
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
                handleSubmit(context);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
