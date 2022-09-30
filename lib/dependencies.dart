import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:products_clean_architecture/commons/network/network_info/network_info.dart';
import 'package:products_clean_architecture/layers/data/data_source/local/products_local_data_source.dart';
import 'package:products_clean_architecture/layers/data/data_source/network/products_network_data_source.dart';
import 'package:products_clean_architecture/layers/data/data_source_if/products_data_source.dart';
import 'package:products_clean_architecture/layers/data/memory/in_memory_cache.dart';
import 'package:products_clean_architecture/layers/data/repositories/products_repo.dart';
import 'package:products_clean_architecture/layers/domain/repository/products_repo_if.dart';
import 'package:products_clean_architecture/layers/domain/usecases/products_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  // domain use case
  sl.registerFactory(() => ProductsUseCase(repo: sl()));

  //data
  sl.registerLazySingleton<ProductRepoIF>(
    () => ProductsRepo(
      productsDataSource: sl(),
      localDataSource: sl(),
      inMemoryCache: sl(),
      networkInfo: sl(),
    ),
  );

  var pref = await SharedPreferences.getInstance();

  sl.registerFactory<ProductsLocalDataSourceIF>(
      () => ProductsLocalDataSource(preferences: sl()));
  sl.registerFactory<ProductsNetworkDataSourceIF>(
      () => ProductsNetworkDataSource());
  sl.registerFactory<NetworkInfoIF>(() => NetworkInfo(sl()));
  sl.registerFactory(() => InMemoryCache());
  sl.registerFactory(() => pref);

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
