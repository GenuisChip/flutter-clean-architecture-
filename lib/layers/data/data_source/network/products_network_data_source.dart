import 'package:products_clean_architecture/layers/data/api_service/api_service.dart';
import 'package:products_clean_architecture/layers/data/data_source_if/products_data_source.dart';
import 'package:products_clean_architecture/layers/data/models/product_model.dart';

class ProductsNetworkDataSource extends APIService<Product>
    implements ProductsNetworkDataSourceIF {
  ProductsNetworkDataSource() : super(endpoint: "products");

  @override
  fromCreate(json) {
    // TODO: implement fromCreate
    throw UnimplementedError();
  }

  @override
  fromDelete(json) {
    // TODO: implement fromDelete
    throw UnimplementedError();
  }

  @override
  Product fromJson(json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  List<Product> fromJsonList(json) {
    return Product.fromJsonList(json["products"]);
  }

  @override
  fromUpdate(json) {
    // TODO: implement fromUpdate
    throw UnimplementedError();
  }
}
