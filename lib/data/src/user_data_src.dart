import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:watch_store/data/model/order.dart';
import 'package:watch_store/data/model/userInfo.dart';

abstract class IUserDataSrc {
  Future<UserInfo> getUserInfo();
  Future<Address> getUserAddresses();
  Future<Order> userReceivedOrders();
  Future<Order> userCancelledOrders();
  Future<Order> userProcessingOrders();
}

class RemoteDataSrc implements IUserDataSrc {
  @override
  Future<Address> getUserAddresses() {
    // TODO: implement getUserAddresses
    throw UnimplementedError();
  }

  @override
  Future<UserInfo> getUserInfo() {
    // TODO: implement getUserInfo
    throw UnimplementedError();
  }

  @override
  Future<Order> userCancelledOrders() {
    // TODO: implement userCancelledOrders
    throw UnimplementedError();
  }

  @override
  Future<Order> userProcessingOrders() {
    // TODO: implement userProcessingOrders
    throw UnimplementedError();
  }

  @override
  Future<Order> userReceivedOrders() {
    // TODO: implement userReceivedOrders
    throw UnimplementedError();
  }
}
