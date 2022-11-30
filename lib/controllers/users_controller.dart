import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygetxapp/models/user_model.dart';
import 'package:mygetxapp/services/api.dart';

class UsersController extends GetxController {
  final isLoaded = false.obs;
  final users = <User>[].obs;
  final Api api =
      Api(url: 'https://assessment-users-backend.herokuapp.com/users/');

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      isLoaded.value = false;
      final userList = await api.getUsers();
      if (userList != null) {
        users.value = userList;
      }
    } catch (error) {
      showErrorMessage(error.toString());
    } finally {
      isLoaded.value = true;
    }
  }

  void updateUserStatus(userToUpdate) async {
    final bool isActive = userToUpdate.status == 'active';
    final String newStatus = isActive ? 'locked' : 'active';

    try {
      isLoaded.value = true;
      await api.updateStatus(userToUpdate.id, newStatus);
    } catch (error) {
      showErrorMessage(error.toString());
    } finally {
      fetchUsers();
    }
  }

  void editUser(userToUpdate, newFirstName, newLastName) async {
    try {
      isLoaded.value = false;
      await api.editUser(userToUpdate.id, newFirstName, newLastName);
    } catch (error) {
      showErrorMessage(error.toString());
    } finally {
      fetchUsers();
    }
  }

  void addUser(firstName, lastName) async {
    try {
      isLoaded.value = false;
      await api.addUser(firstName, lastName);
    } catch (error) {
      showErrorMessage(error.toString());
    } finally {
      fetchUsers();
    }
  }

  void deleteUser(userToDelete) async {
    try {
      isLoaded.value = false;
      await api.deleteUser(userToDelete.id);
    } catch (error) {
      showErrorMessage(error.toString());
    } finally {
      fetchUsers();
    }
  }

  void showErrorMessage(error) {
    Get.defaultDialog(
      title: 'Error',
      middleText: error,
      textConfirm: 'OK',
      onConfirm: () {
        Navigator.of(Get.overlayContext!).pop();
      },
    );
  }
}
