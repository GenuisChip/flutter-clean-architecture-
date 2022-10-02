import 'package:products_clean_architecture/commons/network/api_manager/api_manager_response.dart';
import 'package:products_clean_architecture/layers/data/api_service/api_service.dart';
import 'package:products_clean_architecture/layers/data/data_source_if/posts_data_source_if.dart';
import 'package:products_clean_architecture/layers/data/models/post_model.dart';
import 'package:products_clean_architecture/layers/domain/entities/query_params.dart';
import 'package:products_clean_architecture/layers/domain/entities/post_entity.dart';

class PostsNetworkDataSource extends APIService<Post>
    implements PostsNetworkDataSourceIF {
  PostsNetworkDataSource() : super(endpoint: "posts");

  @override
  Future<ApiManagerResponse<List<PostEntity>>> search(
    String text, {
    QueryParams? params,
  }) {
    return getAll(endpoint: "posts/search?q=$text", params: params);
  }

  @override
  fromCreate(json) {
    throw UnimplementedError();
  }

  @override
  fromDelete(json) {
    throw UnimplementedError();
  }

  @override
  fromJson(json) {
    throw UnimplementedError();
  }

  @override
  fromUpdate(json) {
    throw UnimplementedError();
  }

  @override
  List<Post> fromJsonList(json) {
    return Post.fromJsonList(json["posts"]);
  }
}
