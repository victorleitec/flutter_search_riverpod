import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_users/features/users/data/repositories/module.dart';
import 'package:search_users/features/users/domain/usecases/delete_user.dart';
import 'package:search_users/features/users/domain/usecases/get_user.dart';
import 'package:search_users/features/users/domain/usecases/get_users.dart';
import 'package:search_users/features/users/domain/usecases/save_user.dart';

final getUsersProvider = Provider<GetUsers>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return GetUsers(userRepository);
});

final getUserProvider = Provider<GetUser>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return GetUser(userRepository);
});

final saveUserProvider = Provider<SaveUser>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return SaveUser(userRepository);
});

final deleteUserProvider = Provider<DeleteUser>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return DeleteUser(userRepository);
});
