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
  final UserCart userCart;
  const CartLoadedState(this.userCart);
  @override
  List<Object> get props => [userCart];
}

final class CartItemDeletedState extends CartState {
  final UserCart userCart;
  const CartItemDeletedState(this.userCart);

  @override
  List<Object> get props => [userCart];
}

final class CartItemRemovedState extends CartState {
  final UserCart userCart;
  const CartItemRemovedState(this.userCart);
  @override
  List<Object> get props => [userCart];
}

final class CartItemAddedState extends CartState {
  final UserCart userCart;
  const CartItemAddedState(this.userCart);
  @override
  List<Object> get props => [userCart];
}

final class CartCountState extends CartState {}

final class RecivedPayLinkState extends CartState {
  final String url;

  const RecivedPayLinkState({required this.url});

  @override
  List<Object> get props => [url];
}
