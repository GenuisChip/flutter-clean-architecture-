import 'package:products_clean_architecture/commons/network/api_manager/api_manager_response.dart';
import 'package:products_clean_architecture/layers/data/data_source/network/products_network_data_source.dart';
import 'package:products_clean_architecture/layers/domain/entities/product_entity.dart';
import 'package:products_clean_architecture/layers/domain/repository/products_repo_if.dart';

class ProductsRepo implements ProductRepoIF {
  final productsDataSource = ProductsNetworkDataSource();
  @override
  Future<ApiManagerResponse<List<ProductEntity>>> getAllProducts() {
    return productsDataSource.getAll();
  }

  @override
  Future<ApiManagerResponse<ProductEntity>> getProductId(int id) {
    return productsDataSource.getOne(id.toString());
  }
}
