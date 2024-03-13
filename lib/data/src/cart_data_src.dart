import 'package:dio/dio.dart';
import 'package:watch_store/data/constants.dart';
import 'package:watch_store/data/model/cart.dart';
import 'package:watch_store/utils/response_validator.dart';

abstract class ICartDataSrc {
  Future<List<CartModel>> getUserCart();
  Future<void> addToCart({required int productId});
  Future<void> removeFromCart({required int productId});
  Future<void> deleteFromCart({required int productId});
}

class CartRemoteDataSrc implements ICartDataSrc {
  final Dio httpCilent;
  static const productIdJsonKey = 'product_id';
  CartRemoteDataSrc(this.httpCilent);

  @override
  Future<void> addToCart({required int productId}) async => await httpCilent
      .post(Endpoints.addToCart, data: {productIdJsonKey: productId}).then(
          (value) =>
              HTTPResponseValidator.isValidStatusCode(value.statusCode ?? 0));
  @override
  Future<void> deleteFromCart({required int productId}) async =>
      await httpCilent.post(Endpoints.deleteFromCart, data: {
        productIdJsonKey: productId
      }).then((value) =>
          HTTPResponseValidator.isValidStatusCode(value.statusCode ?? 0));
  @override
  Future<void> removeFromCart({required int productId}) async =>
      await httpCilent.post(Endpoints.removeFromCart, data: {
        productIdJsonKey: productId
      }).then((value) =>
          HTTPResponseValidator.isValidStatusCode(value.statusCode ?? 0));

  @override
  Future<List<CartModel>> getUserCart() async {
    List<CartModel> cartList = <CartModel>[];

    final response = await httpCilent.post(Endpoints.userCart);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    for (var e in (response.data['data']['user_cart'] as List)) {
      cartList.add(CartModel.fromJson(e));
    }

    return cartList;
  }
}
