import 'package:flutter/material.dart';
import 'package:mygetxapp/models/user_model.dart';
import 'package:mygetxapp/services/api.dart';
import 'package:mygetxapp/views/user_card.dart';
import 'package:mygetxapp/views/user_creation_form.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User>? users = [];
  bool isLoaded = false;
  Api api = Api(url: 'https://assessment-users-backend.herokuapp.com/users/');

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void updateUserStatus(userToUpdate) async {
    setState(() {
      isLoaded = false;
    });

    var isActive = userToUpdate.status == 'active';
    var newStatus = isActive ? 'locked' : 'active';

    try {
      await api.updateStatus(userToUpdate.id, newStatus);
      setState(() {
        users!.forEach((user) {
          if (user.id == userToUpdate.id) {
            user.status = newStatus;
          }
        });
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    } finally {
      setState(() {
        isLoaded = true;
      });
    }
  }

  void editUser(userToUpdate, newFirstName, newLastName) async {
    setState(() {
      isLoaded = false;
    });

    try {
      await api.editUser(userToUpdate.id, newFirstName, newLastName);
      setState(() {
        users!.forEach((user) {
          if (user.id == userToUpdate.id) {
            user.firstName = newFirstName;
            user.lastName = newLastName;
          }
        });
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    } finally {
      setState(() {
        isLoaded = true;
      });
    }
  }

  void addUser(firstName, lastName) async {
    setState(() {
      isLoaded = false;
    });

    try {
      await api.addUser(firstName, lastName);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    } finally {
      fetchUsers();
    }
  }

  void deleteUser(userToDelete) async {
    setState(() {
      isLoaded = false;
    });

    try {
      await api.deleteUser(userToDelete.id);
      setState(() {
        users!.removeWhere((user) => user.id == userToDelete.id);
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    } finally {
      setState(() {
        isLoaded = true;
      });
    }
  }

  void fetchUsers() async {
    setState(() {
      isLoaded = false;
    });
    try {
      final users = await api.getUsers();
      setState(() {
        this.users = users;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    } finally {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Users'),
        centerTitle: true,
        backgroundColor: Colors.green[600],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          fetchUsers();
        },
        child: isLoaded
            ? ListView.builder(
                itemCount: users!.length,
                itemBuilder: (context, index) {
                  return UserCard(
                    user: users![index],
                    update: updateUserStatus,
                    edit: editUser,
                    delete: deleteUser,
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserCreationForm(mutate: addUser)));
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
