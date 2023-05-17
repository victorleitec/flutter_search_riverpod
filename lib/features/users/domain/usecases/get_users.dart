import 'package:search_users/core/usecase/usecase.dart';
import 'package:search_users/features/users/domain/entities/user_entity.dart';
import 'package:search_users/features/users/domain/repositories/user_repository.dart';

class GetUsers extends UseCase<List<UserEntity>, NoParams> {
  GetUsers(this._userRepository);
  final UserRepository _userRepository;

  @override
  Future<List<UserEntity>> call(NoParams params) async {
    return _userRepository.getUsers();
  }
}
