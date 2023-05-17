import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_users/features/users/data/repositories/user_repository_impl.dart';
import 'package:search_users/features/users/data/sources/module.dart';
import 'package:search_users/features/users/domain/repositories/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final userRemoteDataSource = ref.read(userRemoteDataSourceProvider);
  return UserRepositoryImpl(userRemoteDataSource: userRemoteDataSource);
});
