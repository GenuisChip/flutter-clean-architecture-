import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:products_clean_architecture/commons/network/network_info/network_info.dart';
import 'package:products_clean_architecture/layers/data/data_source/local/products_local_data_source.dart';
import 'package:products_clean_architecture/layers/data/data_source/network/products_network_data_source.dart';
import 'package:products_clean_architecture/layers/data/data_source_if/posts_data_source_if.dart';
import 'package:products_clean_architecture/layers/data/data_source_if/products_data_source.dart';
import 'package:products_clean_architecture/layers/data/data_source_if/users_data_source_if.dart';
import 'package:products_clean_architecture/layers/data/memory/in_memory_cache.dart';
import 'package:products_clean_architecture/layers/data/repositories/posts_repo.dart';
import 'package:products_clean_architecture/layers/data/repositories/products_repo.dart';
import 'package:products_clean_architecture/layers/data/repositories/users_repo.dart';
import 'package:products_clean_architecture/layers/domain/repository/posts_repo_if.dart';
import 'package:products_clean_architecture/layers/domain/repository/products_repo_if.dart';
import 'package:products_clean_architecture/layers/domain/repository/users_repo_if.dart';
import 'package:products_clean_architecture/layers/domain/usecases/posts_use_case.dart';
import 'package:products_clean_architecture/layers/domain/usecases/products_use_case.dart';
import 'package:products_clean_architecture/layers/domain/usecases/users_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'layers/data/data_source/network/posts_network_data_source.dart';
import 'layers/data/data_source/network/users_network_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  // domain use case
  sl.registerFactory(() => ProductsUseCase(repo: sl()));
  sl.registerFactory(() => UsersUseCase(usersRepo: sl()));
  sl.registerFactory(() => PostsUseCase(repo: sl()));

  //data
  sl.registerLazySingleton<ProductRepoIF>(
    () => ProductsRepo(
      productsDataSource: sl(),
      localDataSource: sl(),
      inMemoryCache: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<UsersRepoIF>(
    () => UsersRepo(networkDataSource: sl()),
  );

  sl.registerLazySingleton<PostsRepoIF>(
    () => PostsRepo(networkDataSource: sl()),
  );

  var pref = await SharedPreferences.getInstance();
  //local data source
  sl.registerFactory<ProductsLocalDataSourceIF>(
      () => ProductsLocalDataSource(preferences: sl()));

  //network data source
  sl.registerFactory<ProductsNetworkDataSourceIF>(
      () => ProductsNetworkDataSource());

  sl.registerFactory<UsersNetworkDataSourceIF>(() => UsersNetworkDataSource());
  sl.registerFactory<PostsNetworkDataSourceIF>(() => PostsNetworkDataSource());

  //common
  sl.registerFactory<NetworkInfoIF>(() => NetworkInfo(sl()));
  sl.registerFactory(() => InMemoryCache());
  sl.registerFactory(() => pref);

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
