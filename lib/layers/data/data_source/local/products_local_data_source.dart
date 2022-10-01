// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:products_clean_architecture/layers/data/data_source_if/products_data_source.dart';
import 'package:products_clean_architecture/layers/data/models/product_model.dart';

const CACHED_PRODUCTS_LIST = "CACHED_PRODUCTS_LIST";

class ProductsLocalDataSource implements ProductsLocalDataSourceIF {
  final SharedPreferences preferences;
  ProductsLocalDataSource({
    required this.preferences,
  });

  @override
  Future<List<Product>> cacheProductsList(List<Product> list) {
    final jsonList = list.map((c) => json.encode(c.toJson())).toList();
    preferences.setStringList(CACHED_PRODUCTS_LIST, jsonList);
    return Future.value(list);
  }

  @override
  Future<List<Product>> getAll() {
    final jsonList = preferences.getStringList(CACHED_PRODUCTS_LIST);
    if (jsonList != null) {
      return Future.value(
          jsonList.map((j) => Product.fromJson(json.decode(j))).toList());
    } else {
      return Future.value([]);
    }
  }

  @override
  Future<Product?> getOne(String id) async {
    final list = await getAll();
    Product? product;

    for (var prod in list) {
      if (int.parse(id) == prod.id) {
        product = prod;
        break;
      }
    }
    return product;
  }
}
