import 'package:products_clean_architecture/commons/network/api_manager/api_manager_response.dart';
import 'package:products_clean_architecture/layers/data/data_source_if/users_data_source_if.dart';
import 'package:products_clean_architecture/layers/domain/entities/query_params.dart';
import 'package:products_clean_architecture/layers/domain/entities/user_entity.dart';
import 'package:products_clean_architecture/layers/domain/repository/users_repo_if.dart';

class UsersRepo implements UsersRepoIF {
  final UsersNetworkDataSourceIF networkDataSource;
  UsersRepo({
    required this.networkDataSource,
  });

  @override
  Future<ApiManagerResponse<List<UserEntity>>> getAllUsers(
      {QueryParams? params}) {
    return networkDataSource.getAll(params: params);
  }

  @override
  Future<ApiManagerResponse<List<UserEntity>>> searchUser(String text,
      {QueryParams? params}) {
    return networkDataSource.searchUser(text, params: params);
  }
}
