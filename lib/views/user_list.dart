import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:mygetxapp/controllers/users_controller.dart';
import 'package:mygetxapp/views/user_card.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final UsersController usersController = Get.put(UsersController());

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
    );
  }
}
