import 'package:products_clean_architecture/commons/network/api_manager/api_manager_response.dart';
import 'package:products_clean_architecture/layers/data/models/product_model.dart';

abstract class ProductsNetworkDataSourceIF {
  Future<ApiManagerResponse<List<Product>>> getAll();
  Future<ApiManagerResponse<Product>> getOne(String id);
  Future<ApiManagerResponse<List<Product>>> search(String text);
}

abstract class ProductsLocalDataSourceIF {
  Future<List<Product>> getAll();
  Future<Product?> getOne(String id);
  Future<List<Product>> cacheProductsList(List<Product> list);
}
