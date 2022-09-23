import 'package:flutter/material.dart';

class AddUser extends StatelessWidget {
  final Function add;
  AddUser({required this.add, super.key});

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
        centerTitle: true,
        backgroundColor: Colors.green[600],
      ),
      body: Column(
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
              add(firstNameController.text, lastNameController.text);
              Navigator.pop(context);
            },
            child: const Text('Add User'),
          ),
        ],
      ),
    );
  }
}
