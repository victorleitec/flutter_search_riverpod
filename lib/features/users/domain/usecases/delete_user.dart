import 'package:search_users/core/usecase/usecase.dart';
import 'package:search_users/features/users/domain/entities/user_entity.dart';
import 'package:search_users/features/users/domain/repositories/user_repository.dart';

class DeleteUser extends UseCase<void, DeleteUserParams> {
  DeleteUser(this._userRepository);
  final UserRepository _userRepository;

  @override
  Future<void> call(DeleteUserParams params) async {
    return _userRepository.deleteUser(params.userEntity);
  }
}

class DeleteUserParams {
  DeleteUserParams(this.userEntity);

  final UserEntity userEntity;
}
