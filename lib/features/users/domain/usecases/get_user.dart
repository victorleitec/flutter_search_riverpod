import 'package:search_users/core/usecase/usecase.dart';
import 'package:search_users/features/users/domain/entities/user_entity.dart';
import 'package:search_users/features/users/domain/repositories/user_repository.dart';

class GetUser extends UseCase<UserEntity, GetUserParams> {
  GetUser(this._userRepository);
  final UserRepository _userRepository;

  @override
  Future<UserEntity?> call(GetUserParams params) async {
    return _userRepository.getUser(params.userId);
  }
}

class GetUserParams {
  GetUserParams(this.userId);

  final String userId;
}
