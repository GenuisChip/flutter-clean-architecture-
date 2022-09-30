import 'package:products_clean_architecture/layers/api_manager/api_manager_response.dart';
import 'package:products_clean_architecture/layers/data/models/product_model.dart';

abstract class ProductsNetworkDataSourceIF {
  Future<ApiManagerResponse<List<Product>>> getAll();
  Future<ApiManagerResponse<Product>> getOne(String id);
}

abstract class ProductsLocalDataSourceIF {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductById();
  Future<List<Product>> cacheProductsList(List<Product> list);
}
