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
  @override
  List<Object> get props => cartList;
}

final class CartItemDeletedState extends CartState {
  final List<CartModel> cartList;
  const CartItemDeletedState(this.cartList);

  @override
  List<Object> get props => cartList;
}

final class CartItemRemovedState extends CartState {
  final List<CartModel> cartList;
  const CartItemRemovedState(this.cartList);
  @override
  List<Object> get props => cartList;
}

final class CartItemAddedState extends CartState {
  final List<CartModel> cartList;
  const CartItemAddedState(this.cartList);
  @override
  List<Object> get props => cartList;
}

final class CartCountState extends CartState {}
