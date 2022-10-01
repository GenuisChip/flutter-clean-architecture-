import 'package:products_clean_architecture/commons/network/api_manager/api_manager_response.dart';
import 'package:products_clean_architecture/layers/domain/entities/product_entity.dart';
import 'package:products_clean_architecture/layers/domain/repository/products_repo_if.dart';

class ProductsUseCase {
  final ProductRepoIF repo;

  ProductsUseCase({required this.repo});
  Future<ApiManagerResponse<List<ProductEntity>>> getAllProducts() async {
    return repo.getAllProducts();
  }

  Future<ApiManagerResponse<ProductEntity>> getProductById(int id) async {
    return repo.getProductId(id);
  }

  Future<ApiManagerResponse<List<ProductEntity>>> search(String text) async {
    return repo.search(text);
  }
}
