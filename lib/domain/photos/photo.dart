import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/value_objects.dart';
import 'photo_source.dart';
import 'value_objects.dart';

part 'photo.freezed.dart';

@freezed
class Photo with _$Photo {
  const factory Photo({
    required UniqueId photoId,
    required int width,
    required int height,
    required PhotoUrl photoUrl,
    required PhotographerName photographerName,
    required PhotographerUrl photographerUrl,
    required UniqueId photographerId,
    required AverageColor averageColor,
    required PhotoSource photoSource,
  }) = _Photo;
}
