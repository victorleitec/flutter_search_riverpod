import 'package:search_users/features/users/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel?> getUser(String userId);

  Future<List<UserModel>> getUsers();

  Future<void> saveUser(UserModel userToSave);

  Future<void> deleteUser(UserModel userToDelete);
}
