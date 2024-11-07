import '../data_base/database_helper.dart';
import '../models/user.dart';

class UserViewModel {
  final _dbHelper = DatabaseHelper();

  Future<void> registerUser(User user) async {
    await _dbHelper.insertUser(user);
  }

  Future<List<User>> getUsers() async {
    return await _dbHelper.getUsers();
  }

  Future<bool> loginUser(String username, String password) async {
    final users = await _dbHelper.getUsers();
    return users
        .any((user) => user.username == username && user.password == password);
  }

  Future<void> updateUser(User user) async {
    await _dbHelper.updateUser(user);
  }

  Future<void> deleteUser(int id) async {
    await _dbHelper.deleteUser(id);
  }
}
