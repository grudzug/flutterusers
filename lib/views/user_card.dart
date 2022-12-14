import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mygetxapp/models/user_model.dart';
import 'package:mygetxapp/views/user_creation_form.dart';
import 'package:get/get.dart';

class UserCard extends StatelessWidget {
  final User user;
  final Function update;
  final Function edit;
  final Function delete;
  const UserCard(
      {required this.user,
      required this.update,
      required this.edit,
      required this.delete,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${user.firstName} ${user.lastName}'),
      subtitle: Text(DateFormat.yMMMMEEEEd().format(user.createdAt)),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () {
              update(user);
            },
            icon: Icon(user.status == 'active'
                ? Icons.lock_open_rounded
                : Icons.lock_rounded),
            color:
                user.status == 'active' ? Colors.green[500] : Colors.pink[700],
          ),
          IconButton(
            onPressed: () {
              Get.to(UserCreationForm(user: user, mutate: edit));
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            onPressed: () {
              delete(user);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
