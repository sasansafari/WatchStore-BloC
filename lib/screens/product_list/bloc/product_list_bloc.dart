import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/physics.dart';
import 'package:watch_store/data/model/product.dart';
import 'package:watch_store/data/repo/product_repo.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final IProductReop _iProductReop;

  ProductListBloc(this._iProductReop) : super(ProductListLoading()) {
    on<ProductListEvent>((event, emit) async {
      if (event is ProductListInit) {
        try {
          emit(ProductListLoading());
          final productList = await _iProductReop.getAllByCategory(event.param);
          emit(ProductListLoaded(productList));
        } catch (e) {
          emit(ProductListError());
        }
      }
    });
  }
}
