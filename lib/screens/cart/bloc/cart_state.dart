part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitialState extends CartState {}

final class CartLoadingState extends CartState {}

final class CartErrorState extends CartState {}

final class CartLoadedState extends CartState {
  final List<CartModel> cartList;
  const CartLoadedState(this.cartList);
}

final class CartItemDeletedState extends CartState {}

final class CartItemRemovedState extends CartState {}

final class CartItemAddedState extends CartState {}
