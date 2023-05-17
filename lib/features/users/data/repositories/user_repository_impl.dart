import 'package:search_users/features/users/data/models/user_model.dart';
import 'package:search_users/features/users/data/sources/user_remote_data_source.dart';
import 'package:search_users/features/users/domain/entities/user_entity.dart';
import 'package:search_users/features/users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required this.userRemoteDataSource});

  final UserRemoteDataSource userRemoteDataSource;

  @override
  Future<void> deleteUser(UserEntity userToDelete) async {
    final userEntity = UserModel.fromJson(userToDelete.toJson());
    await userRemoteDataSource.deleteUser(userEntity);
  }

  @override
  Future<UserEntity?> getUser(String userId) async {
    final userModel = await userRemoteDataSource.getUser(userId);
    if (userModel != null) {
      return UserEntity.fromJson(userModel.toJson());
    }

    return null;
  }

  @override
  Future<List<UserEntity>> getUsers() async {
    final users = await userRemoteDataSource.getUsers();
    return users.map((e) => UserEntity.fromJson(e.toJson())).toList();
  }

  @override
  Future<void> saveUser(UserEntity userToSave) async {
    final userEntity = UserModel.fromJson(userToSave.toJson());
    await userRemoteDataSource.saveUser(userEntity);
  }
}
