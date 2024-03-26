part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartInitEvent extends CartEvent {}

class CartItemCountEvent extends CartEvent {}

class PayEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final int productId;
  const AddToCartEvent(this.productId);
  @override
  List<Object> get props => [productId];
}

class RemoveFromCartEvent extends CartEvent {
  final int productId;
  const RemoveFromCartEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class DeleteFromCart extends CartEvent {
  final int productId;
  const DeleteFromCart(this.productId);

  @override
  List<Object> get props => [productId];
}
