import 'package:products_clean_architecture/commons/network/api_manager/api_manager.dart';
import 'package:products_clean_architecture/layers/domain/entities/user_entity.dart';

import '../entities/query_params.dart';

abstract class UsersRepoIF {
  Future<ApiManagerResponse<List<UserEntity>>> getAllUsers({
    QueryParams? params,
  });
  Future<ApiManagerResponse<List<UserEntity>>> searchUser(
    String text, {
    QueryParams? params,
  });
}
