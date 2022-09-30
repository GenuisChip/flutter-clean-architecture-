import 'package:products_clean_architecture/layers/domain/entities/product_entity.dart';
import 'package:products_clean_architecture/layers/domain/repository/products_repo_if.dart';

class ProductsRepo implements ProductRepoIF {
  
  @override
  Future<List<ProductEntity>> getAllProducts() {
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }

  @override
  Future<ProductEntity> getProductId(int id) {
    // TODO: implement getProductId
    throw UnimplementedError();
  }
  
}