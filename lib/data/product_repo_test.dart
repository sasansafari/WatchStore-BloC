import 'package:dio/dio.dart';
import 'package:watch_store/data/constants.dart';
import 'package:watch_store/data/repo/product_repo.dart';
import 'package:watch_store/data/src/product_data_src.dart';

class ProductRepoTest {
  final _productRepo = ProductRepository(ProductRemoteDataSrc(Dio()));
  getProduct() async =>
      await _productRepo.getSorted(ProductSortRoutes.newestProducts);
}
