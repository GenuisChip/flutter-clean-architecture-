import 'package:products_clean_architecture/commons/network/api_manager/api_manager_response.dart';
import 'package:products_clean_architecture/layers/domain/entities/post_entity.dart';
import 'package:products_clean_architecture/layers/domain/entities/query_params.dart';
import 'package:products_clean_architecture/layers/domain/repository/posts_repo_if.dart';

class PostsUseCase {
  final PostsRepoIF repo;
  PostsUseCase({
    required this.repo,
  });

  Future<ApiManagerResponse<List<PostEntity>>> getAllPosts(
      {QueryParams? params}) {
    return repo.getAllPosts(params: params);
  }

  Future<ApiManagerResponse<List<PostEntity>>> search(String text,
      {QueryParams? params}) {
    return repo.search(text, params: params);
  }
}
