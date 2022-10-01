import 'package:products_clean_architecture/commons/network/api_manager/api_manager_response.dart';
import 'package:products_clean_architecture/layers/domain/entities/user_entity.dart';
import 'package:products_clean_architecture/layers/domain/repository/users_repo_if.dart';

class UsersUseCase {
  final UsersRepoIF usersRepo;
  UsersUseCase({
    required this.usersRepo,
  });

  Future<ApiManagerResponse<List<UserEntity>>> getAllUsers() {
    return usersRepo.getAllUsers();
  }
}
