import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_users/features/users/domain/entities/user_entity.dart';
import 'package:search_users/features/users/presentation/state/notifiers.dart';

final usersListProvider =
    StateNotifierProvider<UsersStateNotifier, AsyncValue<List<UserEntity>>>(
        (ref) {
  return UsersStateNotifier(ref);
});

final searchProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final userNameProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final userEmailProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final userAvatarUrlProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});
