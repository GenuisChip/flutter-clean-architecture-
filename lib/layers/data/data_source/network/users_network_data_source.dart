import 'package:products_clean_architecture/layers/data/api_service/api_service.dart';
import 'package:products_clean_architecture/layers/data/data_source_if/users_data_source_if.dart';
import 'package:products_clean_architecture/layers/data/models/user_model.dart';

class UsersNetworkDataSource extends APIService<User>
    implements UsersNetworkDataSourceIF {
  UsersNetworkDataSource() : super(endpoint: "users");

  @override
  fromCreate(json) {
    // TODO: implement fromCreate
    throw UnimplementedError();
  }

  @override
  fromDelete(json) {
    // TODO: implement fromDelete
    throw UnimplementedError();
  }

  @override
  User fromJson(json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  List<User> fromJsonList(json) {
    return User.fromJsonList(json["users"]);
  }

  @override
  fromUpdate(json) {
    // TODO: implement fromUpdate
    throw UnimplementedError();
  }
}
