part of 'product_list_bloc.dart';

sealed class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

final class ProductListLoading extends ProductListState {}

final class ProductListError extends ProductListState {}

final class ProductListLoaded extends ProductListState {
  final List<Product> productList;

  const ProductListLoaded(this.productList);
  @override
  List<Object> get props => productList;
}
