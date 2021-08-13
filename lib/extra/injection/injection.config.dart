// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:connectivity_plus/connectivity_plus.dart' as _i4;
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/hive_flutter.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import '../../application/photos/photos_watcher/photos_watcher_bloc.dart'
    as _i13;
import '../../application/themes/theme_cubit.dart' as _i14;
import '../../domain/photos/i_photo_repository.dart' as _i8;
import '../../domain/themes/i_theme_repository.dart' as _i11;
import '../../infrastructure/photos/photo_remote_datasource.dart' as _i7;
import '../../infrastructure/photos/photo_repository.dart' as _i9;
import '../../infrastructure/themes/theme_local_datasource.dart' as _i10;
import '../../infrastructure/themes/theme_repository.dart' as _i12;
import '../network/network_info.dart' as _i6;
import 'register_module.dart' as _i15; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  await gh.lazySingletonAsync<_i3.Box<dynamic>>(() => registerModule.openBox,
      preResolve: true);
  gh.lazySingleton<_i4.Connectivity>(() => registerModule.connectionChecker);
  await gh.lazySingletonAsync<_i5.Dio>(() => registerModule.httpClient,
      preResolve: true);
  gh.lazySingleton<_i6.INetworkInfo>(
      () => _i6.NetworkInfo(get<_i4.Connectivity>()));
  gh.lazySingleton<_i7.IPhotoRemoteDataSource>(
      () => _i7.PhotoRemoteDataSource(get<_i5.Dio>()));
  gh.lazySingleton<_i8.IPhotoRepository>(() => _i9.PhotoRepository(
      get<_i6.INetworkInfo>(), get<_i7.IPhotoRemoteDataSource>()));
  gh.lazySingleton<_i10.IThemeLocalDataSource>(
      () => _i10.ThemeLocalDataSource(get<_i3.Box<dynamic>>()));
  gh.lazySingleton<_i11.IThemeRepository>(
      () => _i12.ThemeRepository(get<_i10.IThemeLocalDataSource>()));
  gh.factory<_i13.PhotosWatcherBloc>(
      () => _i13.PhotosWatcherBloc(get<_i8.IPhotoRepository>()));
  gh.factory<_i14.ThemeCubit>(
      () => _i14.ThemeCubit(get<_i11.IThemeRepository>()));
  return get;
}

class _$RegisterModule extends _i15.RegisterModule {}
