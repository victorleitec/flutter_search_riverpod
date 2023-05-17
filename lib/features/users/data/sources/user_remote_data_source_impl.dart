import 'package:dio/dio.dart';
import 'package:retry/retry.dart';
import 'package:search_users/core/errors/exceptions.dart';
import 'package:search_users/features/users/data/models/user_model.dart';
import 'package:search_users/features/users/data/sources/user_remote_data_source.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<void> deleteUser(UserModel userToDelete) async {
    try {
      await dio.delete<void>(
        '/users/${userToDelete.id}',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getUser(String userId) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        '/users/$userId',
      );

      if (response.data != null) {
        return UserModel.fromJson(response.data!);
      }

      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await retry(
        () => dio.get<List<dynamic>>(
          '/users',
        ),
        retryIf: (e) => e is DioError && e.response?.statusCode == 429,
        maxAttempts: 3,
        delayFactor: const Duration(seconds: 5),
        onRetry: (_) => print('retrying...'),
      );

      if (response.statusCode == 200) {
        return response.data!
            .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> saveUser(UserModel userToSave) async {
    try {
      await dio.post<void>(
        '/users',
        data: userToSave.toJson(),
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
