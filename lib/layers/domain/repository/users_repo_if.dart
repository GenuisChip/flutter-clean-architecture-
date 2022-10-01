import 'package:products_clean_architecture/commons/network/api_manager/api_manager.dart';
import 'package:products_clean_architecture/layers/domain/entities/user_entity.dart';

abstract class UsersRepoIF {
  Future<ApiManagerResponse<List<UserEntity>>> getAllUsers();
}
