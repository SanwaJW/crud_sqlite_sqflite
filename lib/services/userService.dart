import 'package:crud_sqlite_sqflite/db_helper/repository.dart';
import 'package:crud_sqlite_sqflite/model/User.dart';

class UserService {
  late Repository _repository;
  UserService() {
    _repository = Repository();
  }
  saveUser(User user) async {
    return await _repository.insertData('users', user.toMap());
  }

  readAllUsers() async {
    return await _repository.readData('users');
  }

  //Edit User
  UpdateUser(User user) async {
    return await _repository.updateData('users', user.toMap());
  }

  deleteUser(userId) async {
    return await _repository.deleteDataById('users', userId);
  }
}
