import 'package:dio/dio.dart';
import 'package:watch_store/data/model/product.dart';
import 'package:watch_store/data/src/product_data_src.dart';

abstract class IProductReop {
  Future<List<Product>> getAllByCategory(int id);
  Future<List<Product>> getAllByBrand(int id);
  Future<List<Product>> getSorted(String routeParam);
  Future<List<Product>> searchProducts(String searchKey);
}

class ProductRepository implements IProductReop {
  final IProductDataSrc _iProductDataSrc;

  ProductRepository(this._iProductDataSrc);

  @override
  Future<List<Product>> getAllByBrand(int id) =>
      _iProductDataSrc.getAllByBrand(id);

  @override
  Future<List<Product>> getAllByCategory(int id) =>
      _iProductDataSrc.getAllByCategory(id);

  @override
  Future<List<Product>> getSorted(String routeParam) =>
      _iProductDataSrc.getSorted(routeParam);
  @override
  Future<List<Product>> searchProducts(String searchKey) =>
      _iProductDataSrc.searchProducts(searchKey);
}

final productRepository = ProductRepository(ProductRemoteDataSrc(Dio()));
