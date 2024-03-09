part of 'product_single_bloc.dart';

sealed class ProductSingleState extends Equatable {
  const ProductSingleState();

  @override
  List<Object> get props => [];
}

final class ProductSingleLoading extends ProductSingleState {}

final class ProductSingleError extends ProductSingleState {}

final class ProductSingleLoaded extends ProductSingleState {
  final ProductDetailes productDetailes;
  const ProductSingleLoaded(this.productDetailes);
}
