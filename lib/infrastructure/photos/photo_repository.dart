import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/exceptions.dart';
import '../../domain/photos/i_photo_repository.dart';
import '../../domain/photos/photo.dart';
import '../../domain/photos/photo_failure.dart';
import '../../extra/network/network_info.dart';
import 'photo_remote_datasource.dart';

@LazySingleton(as: IPhotoRepository)
class PhotoRepository implements IPhotoRepository {
  PhotoRepository(
    this._networkInfo,
    this._remoteDataSource,
  );

  final NetworkInfo _networkInfo;
  final IPhotoRemoteDataSource _remoteDataSource;

  @override
  Future<Either<PhotoFailure, List<Photo>>> getPhotos({
    required int page,
    required int limit,
    String? keyword,
    String? category,
  }) async {
    if (await _networkInfo.isConnected()) {
      try {
        final _listPhoto = await _remoteDataSource.getPhotos(
          page: page,
          limit: limit,
          keyword: keyword,
        );
        return right(_listPhoto);
      } on ServerException {
        return left(const PhotoFailure.serverError());
      }
    } else {
      return left(const PhotoFailure.noConnectionError());
    }
  }
}
