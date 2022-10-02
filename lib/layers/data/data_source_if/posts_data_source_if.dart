import 'package:products_clean_architecture/commons/network/api_manager/api_manager.dart';
import 'package:products_clean_architecture/layers/data/models/post_model.dart';
import 'package:products_clean_architecture/layers/domain/entities/post_entity.dart';
import 'package:products_clean_architecture/layers/domain/entities/query_params.dart';

abstract class PostsNetworkDataSourceIF {
  Future<ApiManagerResponse<List<Post>>> getAll({QueryParams? params});

  Future<ApiManagerResponse<List<PostEntity>>> search(String text,
      {QueryParams? params});
}
