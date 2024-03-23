part of 'product_list_bloc.dart';

sealed class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class ProductListInit extends ProductListEvent {
  final param;
  const ProductListInit({required this.param});
  @override
  List<Object> get props => [param];
}
