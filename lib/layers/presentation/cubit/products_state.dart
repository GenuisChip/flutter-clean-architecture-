part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class Loading extends ProductsState {}
class ProductSearch extends ProductsState {}

class Success extends ProductsState {
  final List<ProductEntity> products;

  const Success({
    required this.products,
  });
}

class Failed extends ProductsState {
  final ApiManagerResponse response;

  const Failed({
    required this.response,
  });
}
