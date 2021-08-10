import 'package:dartz/dartz.dart';

import 'photo.dart';
import 'photo_failure.dart';

abstract class IPhotoRepository {
  Future<Either<PhotoFailure, List<Photo>>> getPhotos({
    required int page,
    required int limit,
    String? keyword,
  });
}
