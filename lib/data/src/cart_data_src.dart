import 'package:dio/dio.dart';
import 'package:watch_store/data/constants.dart';
import 'package:watch_store/data/model/cart.dart';
import 'package:watch_store/utils/response_validator.dart';

abstract class ICartDataSrc {
  Future<UserCart> getUserCart();
  Future<UserCart> addToCart({required int productId});
  Future<UserCart> removeFromCart({required int productId});
  Future<UserCart> deleteFromCart({required int productId});
  Future<int> countCartItems();
  Future<String> payCart();
}

class CartRemoteDataSrc implements ICartDataSrc {
  final Dio httpCilent;
  static const productIdJsonKey = 'product_id';
  CartRemoteDataSrc(this.httpCilent);

  @override
  Future<UserCart> addToCart({required int productId}) async =>
      await httpCilent.post(Endpoints.addToCart,
          data: {productIdJsonKey: productId}).then((value) {
        HTTPResponseValidator.isValidStatusCode(value.statusCode ?? 0);
        return UserCart.fromJson(value.data['data']);
      });

  @override
  Future<UserCart> deleteFromCart({required int productId}) async =>
      await httpCilent.post(Endpoints.deleteFromCart,
          data: {productIdJsonKey: productId}).then((value) {
        HTTPResponseValidator.isValidStatusCode(value.statusCode ?? 0);
        return UserCart.fromJson(value.data['data']);
      });
  @override
  Future<UserCart> removeFromCart({required int productId}) async =>
      await httpCilent.post(Endpoints.removeFromCart,
          data: {productIdJsonKey: productId}).then((value) {
        HTTPResponseValidator.isValidStatusCode(value.statusCode ?? 0);
        return UserCart.fromJson(value.data['data']);
      });

  @override
  Future<UserCart> getUserCart() async {
    final response = await httpCilent.post(Endpoints.userCart);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    return UserCart.fromJson(response.data['data']);
  }

  @override
  Future<int> countCartItems() async {
    final response = await httpCilent.post(Endpoints.userCart);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    return (response.data['data']['user_cart'] as List).length;
  }

  @override
  Future<String> payCart() async {
    final response = await httpCilent.post(Endpoints.payment);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    return response.data['action'];
  }
}
