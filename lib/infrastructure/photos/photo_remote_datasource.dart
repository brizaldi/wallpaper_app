import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/exceptions.dart';
import '../../domain/photos/photo.dart';
import '../../extra/utils/logging.dart';
import 'dto/photo_dtos.dart';

abstract class IPhotoRemoteDataSource {
  Future<List<Photo>> getPhotos({
    required int page,
    required int limit,
    String? keyword,
  });
}

@LazySingleton(as: IPhotoRemoteDataSource)
class PhotoRemoteDataSource implements IPhotoRemoteDataSource {
  PhotoRemoteDataSource(this._dio);

  final Dio _dio;

  @override
  Future<List<Photo>> getPhotos({
    required int page,
    required int limit,
    String? keyword,
  }) async {
    try {
      final _response = await _dio.get(
        'search',
        queryParameters: {
          'page': page,
          'per_page': limit,
          'query': keyword ?? 'random',
        },
      );

      if (_response.statusCode == 200) {
        final listPhoto = _response.data['photos']
            .map((e) => PhotoDto.fromJson(e).toDomain())
            .cast<Photo>()
            .toList();

        return listPhoto;
      } else {
        throw ServerException();
      }
    } catch (e, s) {
      Log.severe(e.toString());
      Log.severe(s.toString());
      throw ServerException();
    }
  }
}
