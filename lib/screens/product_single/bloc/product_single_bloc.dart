import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:watch_store/data/model/product_details.dart';
import 'package:watch_store/data/repo/product_repo.dart';

part 'product_single_event.dart';
part 'product_single_state.dart';

class ProductSingleBloc extends Bloc<ProductSingleEvent, ProductSingleState> {
  final IProductReop _iProductReop;

  ProductSingleBloc(this._iProductReop) : super(ProductSingleLoading()) {
    on<ProductSingleEvent>((event, emit) async {
      if (event is ProductSingleInit) {
        try {
          emit(ProductSingleLoading());
          final productDetailes =
              await _iProductReop.getProductDetailes(event.id);
          emit(ProductSingleLoaded(productDetailes));
        } catch (e) {
          emit(ProductSingleError());
        }
      }
    });
  }
}
