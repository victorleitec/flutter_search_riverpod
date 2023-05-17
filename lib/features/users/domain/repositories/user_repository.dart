import 'package:search_users/features/users/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity?> getUser(String userId);

  Future<List<UserEntity>> getUsers();

  Future<void> saveUser(UserEntity userToSave);

  Future<void> deleteUser(UserEntity userToDelete);
}
