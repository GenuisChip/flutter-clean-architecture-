import 'package:products_clean_architecture/layers/domain/entities/product_entity.dart';

abstract class ProductRepoIF {
  Future<List<ProductEntity>> getAllProducts();
  Future<ProductEntity> getProductId(int id);
}
