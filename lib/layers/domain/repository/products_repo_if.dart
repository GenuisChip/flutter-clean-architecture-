import 'package:products_clean_architecture/commons/network/api_manager/api_manager_response.dart';
import 'package:products_clean_architecture/layers/domain/entities/product_entity.dart';

abstract class ProductRepoIF {
  Future<ApiManagerResponse<List<ProductEntity>>> getAllProducts();
  Future<ApiManagerResponse<ProductEntity>> getProductId(int id);
}
