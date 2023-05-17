import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_users/core/usecase/usecase.dart';
import 'package:search_users/features/users/domain/entities/user_entity.dart';
import 'package:search_users/features/users/domain/usecases/delete_user.dart';
import 'package:search_users/features/users/domain/usecases/get_user.dart';
import 'package:search_users/features/users/domain/usecases/module.dart';
import 'package:search_users/features/users/domain/usecases/save_user.dart';
import 'package:search_users/features/users/presentation/state/providers.dart';
import 'package:uuid/uuid.dart';

class UsersStateNotifier extends StateNotifier<AsyncValue<List<UserEntity>>> {
  UsersStateNotifier(this.ref) : super(const AsyncLoading()) {
    loadUsers();
  }

  final Ref ref;
  late final getUsers = ref.read(getUsersProvider);
  late final scrollController = ScrollController();

  Future<void> loadUsers() async {
    state = const AsyncLoading();
    state = AsyncData(await getUsers(NoParams()));
  }

  Future<void> deleteUser(UserEntity userEntity) async {
    await ref.read(deleteUserProvider)(DeleteUserParams(userEntity));
    state = state.whenData(
      (users) => users
          .where((user) => user.id != userEntity.id)
          .toList(growable: false),
    );
  }

  Future<void> saveUser() async {
    final nameProvider = ref.read(userNameProvider);
    final emailProvider = ref.read(userEmailProvider);
    final avatarUrlProvider = ref.read(userAvatarUrlProvider);
    final userToSave = UserEntity(
      id: const Uuid().v4(),
      name: nameProvider.text,
      email: emailProvider.text,
      avatarUrl: avatarUrlProvider.text,
    );
    await ref.read(saveUserProvider)(SaveUserParams(userToSave));
    state = state.whenData(
      (users) => [
        ...users.where((user) => user.id != userToSave.id),
        userToSave,
      ],
    );

    nameProvider.clear();
    emailProvider.clear();
    avatarUrlProvider.clear();
  }

  Future<UserEntity?> getUser(String id) async {
    return ref.read(getUserProvider)(GetUserParams(id));
  }

  Future<void> searchUsers(String query) async {
    final users = await getUsers(NoParams());
    final queryLower = query.toLowerCase();
    state = AsyncData(
      users.where((user) {
        final nameLower = user.name.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList(growable: false),
    );
  }

  void clearSearch() {
    ref.read(searchProvider).clear();
    searchUsers('');
  }
}
