import 'package:get/get.dart';
import 'package:mygetxapp/models/user_model.dart';
import 'package:mygetxapp/services/api.dart';

class UsersController extends GetxController {
  var isLoaded = false.obs;
  var errorMessage = ''.obs;
  final users = <User>[].obs;
  Api api = Api(url: 'https://assessment-users-backend.herokuapp.com/users/');

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
      errorMessage.value = error.toString();
    } finally {
      isLoaded.value = true;
    }
  }

  void updateUserStatus(userToUpdate) async {
    bool isActive = userToUpdate.status == 'active';
    String newStatus = isActive ? 'locked' : 'active';

    try {
      isLoaded.value = true;
      await api.updateStatus(userToUpdate.id, newStatus);
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      fetchUsers();
    }
  }

  void editUser(userToUpdate, newFirstName, newLastName) async {
    try {
      isLoaded.value = false;
      await api.editUser(userToUpdate.id, newFirstName, newLastName);
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      fetchUsers();
    }
  }

  void addUser(firstName, lastName) async {
    try {
      isLoaded.value = false;
      await api.addUser(firstName, lastName);
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      fetchUsers();
    }
  }

  void deleteUser(userToDelete) async {
    try {
      isLoaded.value = false;
      await api.deleteUser(userToDelete.id);
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      fetchUsers();
    }
  }
}
