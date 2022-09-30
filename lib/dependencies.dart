import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:products_clean_architecture/layers/data/repositories/products_repo.dart';
import 'package:products_clean_architecture/layers/domain/repository/products_repo_if.dart';
import 'package:products_clean_architecture/layers/domain/usecases/products_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  // domain use case
  sl.registerFactory(() => ProductsUseCase(repo: sl()));

  //data
  sl.registerLazySingleton<ProductRepoIF>(
    () => ProductsRepo(),
  );
}
