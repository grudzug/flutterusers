import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygetxapp/controllers/secure_storage.dart';
import 'package:mygetxapp/controllers/users_controller.dart';
import 'package:mygetxapp/views/user_card.dart';
import 'package:mygetxapp/views/user_creation_form.dart';

class UserList extends StatefulWidget {
  UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final UsersController usersController = Get.put(UsersController());
  String user = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    user = await UserSecureStorage.getUser();
    setState(
      () {
        user = user;
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Users'),
          centerTitle: true,
          backgroundColor: Colors.green[600],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            usersController.fetchUsers();
          },
          child: Obx(
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(UserCreationForm(mutate: usersController.addUser));
          },
          backgroundColor: Colors.green[600],
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.green[600],
          child: Row(
            children: [
              Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await UserSecureStorage.saveUser('Aladár');
                      init();
                    },
                    child: const Text('Write to storage'),
                  )),
              Container(
                child: Text('user: $user'),
              ),
            ],
          ),
        ));
  }
}
