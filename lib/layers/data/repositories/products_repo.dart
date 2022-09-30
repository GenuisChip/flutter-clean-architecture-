import 'package:products_clean_architecture/commons/network/api_manager/api_manager_response.dart';
import 'package:products_clean_architecture/commons/network/network_info/network_info.dart';
import 'package:products_clean_architecture/layers/data/data_source_if/products_data_source.dart';
import 'package:products_clean_architecture/layers/data/memory/in_memory_cache.dart';
import 'package:products_clean_architecture/layers/domain/entities/product_entity.dart';
import 'package:products_clean_architecture/layers/domain/repository/products_repo_if.dart';

class ProductsRepo implements ProductRepoIF {
  final ProductsNetworkDataSourceIF productsDataSource;
  final ProductsLocalDataSourceIF localDataSource;
  final InMemoryCache inMemoryCache;
  final NetworkInfoIF networkInfo;

  ProductsRepo({
    required this.productsDataSource,
    required this.localDataSource,
    required this.inMemoryCache,
    required this.networkInfo,
  });

  @override
  Future<ApiManagerResponse<List<ProductEntity>>> getAllProducts() async {
    if (inMemoryCache.isNotEmpty && inMemoryCache.hasNotExpired) {
      var data = inMemoryCache.getCachedValue();
      return ApiManagerResponse(
        data: data,
        error: null,
        isSuccess: true,
        rawData: null,
        serverErrorMsg: null,
        statusCode: 200,
      );
    }
    if (await networkInfo.isConnected) {
      var res = await productsDataSource.getAll();
      if (res.isSuccess) {
        inMemoryCache.save(res.data);
        localDataSource.cacheProductsList(res.data!);
      }
      return res;
    } else {
      return ApiManagerResponse(
        data: await localDataSource.getAll(),
        error: null,
        isSuccess: true,
        rawData: null,
        serverErrorMsg: null,
        statusCode: 200,
      );
    }
  }

  @override
  Future<ApiManagerResponse<ProductEntity>> getProductId(int id) async {
    if (await networkInfo.isConnected) {
      var res = await productsDataSource.getOne(id.toString());
      return res;
    } else {
      return ApiManagerResponse(
        data: await localDataSource.getOne(id.toString()),
        error: null,
        isSuccess: true,
        rawData: null,
        serverErrorMsg: null,
        statusCode: 200,
      );
    }
  }
}
