import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../config/configuration.dart';
import '../constants/strings.dart';

@module
abstract class RegisterModule {
  @preResolve
  @lazySingleton
  Future<Box> get openBox async {
    await Hive.initFlutter();
    return Hive.openBox<String>(Strings.appCodeName);
  }

  @preResolve
  @lazySingleton
  Future<Dio> get httpClient async {
    final options = BaseOptions(
      connectTimeout: BuildConfig.get().connectTimeout,
      receiveTimeout: BuildConfig.get().receiveTimeout,
      validateStatus: (status) {
        return true;
      },
      baseUrl: BuildConfig.get().baseUrl,
    );

    final dio = Dio(options);

    dio.interceptors.add(AuthInterceptor());

    if (BuildConfig.get().flavor != Flavor.release) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ));
    }

    return dio;
  }

  @lazySingleton
  Connectivity get connectionChecker {
    return Connectivity();
  }
}
