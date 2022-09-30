import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_clean_architecture/commons/network/api_manager/api_manager_response.dart';
import 'package:products_clean_architecture/layers/domain/entities/product_entity.dart';
import 'package:products_clean_architecture/layers/domain/usecases/products_use_case.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsUseCase products;
  ProductsCubit({required this.products}) : super(ProductsInitial());

  Future<void> getAllProducts() async {
    emit(Loading());
    var res = await products.getAllProducts();
    if (res.isSuccess) {
      emit(Success(products: res.data!));
    } else {
      emit(Failed(response: res));
    }
  }
}
