// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/hive_flutter.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import '../../domain/photos/i_photo_repository.dart' as _i7;
import '../../infrastructure/photos/photo_remote_datasource.dart' as _i5;
import '../../infrastructure/photos/photo_repository.dart' as _i8;
import '../network/network_info.dart' as _i6;
import 'register_module.dart' as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  await gh.lazySingletonAsync<_i3.Box<dynamic>>(() => registerModule.openBox,
      preResolve: true);
  await gh.lazySingletonAsync<_i4.Dio>(() => registerModule.httpClient,
      preResolve: true);
  gh.lazySingleton<_i5.IPhotoRemoteDataSource>(
      () => _i5.PhotoRemoteDataSource(get<_i4.Dio>()));
  gh.lazySingleton<_i6.NetworkInfo>(() => _i6.NetworkInfo());
  gh.lazySingleton<_i7.IPhotoRepository>(() => _i8.PhotoRepository(
      get<_i6.NetworkInfo>(), get<_i5.IPhotoRemoteDataSource>()));
  return get;
}

class _$RegisterModule extends _i9.RegisterModule {}
