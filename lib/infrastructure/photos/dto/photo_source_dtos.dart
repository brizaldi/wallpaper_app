import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/photos/photo_source.dart';
import '../../../domain/photos/value_objects.dart';

part 'photo_source_dtos.freezed.dart';
part 'photo_source_dtos.g.dart';

@freezed
class PhotoSourceDto with _$PhotoSourceDto {
  const factory PhotoSourceDto({
    required String original,
    required String large2x,
    required String large,
    required String medium,
    required String small,
    required String portrait,
    required String landscape,
    required String tiny,
  }) = _PhotoSourceDto;

  const PhotoSourceDto._();

  factory PhotoSourceDto.fromDomain(PhotoSource photoSource) {
    return PhotoSourceDto(
      original: photoSource.original.getOrCrash(),
      large2x: photoSource.large2x.getOrCrash(),
      large: photoSource.large.getOrCrash(),
      medium: photoSource.medium.getOrCrash(),
      small: photoSource.small.getOrCrash(),
      portrait: photoSource.portrait.getOrCrash(),
      landscape: photoSource.landscape.getOrCrash(),
      tiny: photoSource.tiny.getOrCrash(),
    );
  }

  PhotoSource toDomain() {
    return PhotoSource(
      original: PhotoSourceUrl(original),
      large2x: PhotoSourceUrl(large2x),
      large: PhotoSourceUrl(large),
      medium: PhotoSourceUrl(medium),
      small: PhotoSourceUrl(small),
      portrait: PhotoSourceUrl(portrait),
      landscape: PhotoSourceUrl(landscape),
      tiny: PhotoSourceUrl(tiny),
    );
  }

  factory PhotoSourceDto.fromJson(Map<String, dynamic> json) =>
      _$PhotoSourceDtoFromJson(json);
}
