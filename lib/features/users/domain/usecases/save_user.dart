import 'package:search_users/core/usecase/usecase.dart';
import 'package:search_users/features/users/domain/entities/user_entity.dart';
import 'package:search_users/features/users/domain/repositories/user_repository.dart';

class SaveUser extends UseCase<void, SaveUserParams> {
  SaveUser(this._userRepository);
  final UserRepository _userRepository;

  @override
  Future<void> call(SaveUserParams params) async {
    return _userRepository.saveUser(params.userToSave);
  }
}

class SaveUserParams {
  SaveUserParams(this.userToSave);

  final UserEntity userToSave;
}
