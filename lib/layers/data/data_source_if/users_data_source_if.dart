import 'package:products_clean_architecture/commons/network/api_manager/api_manager.dart';
import 'package:products_clean_architecture/layers/data/models/user_model.dart';
import 'package:products_clean_architecture/layers/domain/entities/query_params.dart';
import 'package:products_clean_architecture/layers/domain/entities/user_entity.dart';

abstract class UsersNetworkDataSourceIF {
  Future<ApiManagerResponse<List<User>>> getAll({QueryParams? params});

  Future<ApiManagerResponse<List<UserEntity>>> searchUser(String text,
      {QueryParams? params});
}
