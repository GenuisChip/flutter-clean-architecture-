import 'package:products_clean_architecture/commons/network/api_manager/api_manager_response.dart';
import 'package:products_clean_architecture/layers/data/data_source_if/posts_data_source_if.dart';
import 'package:products_clean_architecture/layers/domain/entities/post_entity.dart';
import 'package:products_clean_architecture/layers/domain/entities/query_params.dart';
import 'package:products_clean_architecture/layers/domain/repository/posts_repo_if.dart';

class PostsRepo implements PostsRepoIF {
  final PostsNetworkDataSourceIF networkDataSource;
  PostsRepo({
    required this.networkDataSource,
  });

  @override
  Future<ApiManagerResponse<List<PostEntity>>> getAllPosts(
      {QueryParams? params}) {
    return networkDataSource.getAll();
  }

  @override
  Future<ApiManagerResponse<List<PostEntity>>> search(String text,
      {QueryParams? params}) {
    return networkDataSource.search(text);
  }
}
