import 'package:products_clean_architecture/commons/network/api_manager/api_manager.dart';
import 'package:products_clean_architecture/layers/data/models/user_model.dart';

abstract class UsersNetworkDataSourceIF {
  Future<ApiManagerResponse<List<User>>> getAll();
}
