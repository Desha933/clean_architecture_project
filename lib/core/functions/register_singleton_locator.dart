import 'package:bookly/Features/home/data/data_source/home_local_data_source.dart';
import 'package:bookly/Features/home/data/data_source/home_remote_data_source.dart';
import 'package:bookly/Features/home/data/repos_impl/home_repos_impl.dart';
import 'package:bookly/core/utils/api_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void registerSingletonLocator() {
  getIt.registerSingleton<HomeReposImpl>(
    HomeReposImpl(
      homeLocalDataSource: HomeLocalDataSourceImplement(),
      homeRemoteDataSource: HomeRemoteDataSourceImplement(
        getIt.get<ApiService>(),
      ),
    ),
  );

  getIt.registerSingleton<ApiService>(ApiService(Dio()));
}
