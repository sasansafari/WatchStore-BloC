import 'package:flutter/material.dart';
import 'package:watch_store/data/conf/remote_conf.dart';
import 'package:watch_store/data/model/cart.dart';
import 'package:watch_store/data/src/cart_data_src.dart';

abstract class ICartRepository {
  Future<UserCart> getUserCart();
  Future<UserCart> addToCart({required int productId});
  Future<UserCart> removeFromCart({required int productId});
  Future<UserCart> deleteFromCart({required int productId});
  Future<int> countCartItems();
  Future<String> payCart();
}

class CartRepo implements ICartRepository {
  final ICartDataSrc _cartDataSrc;
  ValueNotifier<int> cartCount = ValueNotifier(0);
  CartRepo(this._cartDataSrc);

  @override
  Future<UserCart> addToCart({required int productId}) =>
      _cartDataSrc.addToCart(productId: productId).then((value) {
        cartCount.value = value.cartList.length;
        return value;
      });

  @override
  Future<UserCart> deleteFromCart({required int productId}) =>
      _cartDataSrc.deleteFromCart(productId: productId).then((value) {
        cartCount.value = value.cartList.length;
        return value;
      });
  @override
  Future<UserCart> getUserCart() => _cartDataSrc.getUserCart();

  @override
  Future<UserCart> removeFromCart({required int productId}) =>
      _cartDataSrc.removeFromCart(productId: productId);

  @override
  Future<int> countCartItems() =>
      _cartDataSrc.countCartItems().then((value) => cartCount.value = value);

  @override
  Future<String> payCart() => _cartDataSrc.payCart();
}

final cartRepository = CartRepo(CartRemoteDataSrc(DioManager.dio));
