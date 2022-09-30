import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_clean_architecture/layers/domain/entities/product_entity.dart';
import 'package:products_clean_architecture/layers/domain/usecases/products_use_case.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductsUseCase products;

  ProductDetailsCubit({required this.products})
      : super(ProductDetailsInitial());

  Future<void> getProductById(int id) async {
    emit(ProductDetailsLoading());
    final res = await products.getProductById(id);
    if (res.isSuccess) {
      emit(ProductDetailsSuccess(product: res.data!));
    } else {
      emit(ProductDetailsFailed());
    }
  }

  void resetState() => emit(ProductDetailsInitial());
}
