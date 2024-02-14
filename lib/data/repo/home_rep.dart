import 'package:dio/dio.dart';
import 'package:watch_store/data/model/home.dart';
import 'package:watch_store/data/src/home_data_src.dart';

abstract class IHomeRepo {
  Future<Home> getHome();
}

class HomeRepository implements IHomeRepo {
  final IHomeDataSrc _homeDataSrc;

  HomeRepository(this._homeDataSrc);

  @override
  Future<Home> getHome() => _homeDataSrc.getHome();
}

final homeRepository = HomeRepository(HomeRemoteDataSrc(Dio()));
