import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygetxapp/controllers/users_controller.dart';
import 'package:mygetxapp/views/user_card.dart';
import 'package:mygetxapp/views/user_creation_form.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});
  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  UsersController usersController = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Users'),
        centerTitle: true,
        backgroundColor: Colors.green[600],
      ),
      body: Obx(
        () {
          Get.snackbar('df', 'df');
          if (usersController.isLoaded.value == false) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: usersController.users.length,
            itemBuilder: (context, index) {
              return UserCard(
                user: usersController.users[index],
                update: usersController.updateUserStatus,
                edit: usersController.editUser,
                delete: usersController.deleteUser,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(UserCreationForm(mutate: usersController.addUser));
        },
        backgroundColor: Colors.green[600],
        child: const Icon(Icons.add),
      ),
    );
  }
}
