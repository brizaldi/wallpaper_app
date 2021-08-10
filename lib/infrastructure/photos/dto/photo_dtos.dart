import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/core/value_objects.dart';
import '../../../domain/photos/photo.dart';
import '../../../domain/photos/value_objects.dart';
import 'photo_source_dtos.dart';

part 'photo_dtos.freezed.dart';
part 'photo_dtos.g.dart';

@freezed
class PhotoDto with _$PhotoDto {
  const factory PhotoDto({
    required int id,
    required int width,
    required int height,
    required String url,
    required String photographer,
    @JsonKey(name: 'photographer_url') required String photographerUrl,
    @JsonKey(name: 'photographer_id') required int photographerId,
    @JsonKey(name: 'avg_color') required String avgColor,
    required PhotoSourceDto src,
  }) = _PhotoDto;

  const PhotoDto._();

  factory PhotoDto.fromDomain(Photo photo) {
    return PhotoDto(
      id: int.tryParse(photo.photoId.getOrCrash()) ?? 0,
      width: photo.width,
      height: photo.height,
      url: photo.photoUrl.getOrCrash(),
      photographer: photo.photographerName.getOrCrash(),
      photographerUrl: photo.photographerUrl.getOrCrash(),
      photographerId: int.tryParse(photo.photographerId.getOrCrash()) ?? 0,
      avgColor: photo.averageColor.getOrCrash(),
      src: PhotoSourceDto.fromDomain(photo.photoSource),
    );
  }

  Photo toDomain() {
    return Photo(
      photoId: UniqueId.fromInteger(id),
      width: width,
      height: height,
      photoUrl: PhotoUrl(url),
      photographerName: PhotographerName(photographer),
      photographerUrl: PhotographerUrl(photographerUrl),
      photographerId: UniqueId.fromInteger(photographerId),
      averageColor: AverageColor(avgColor),
      photoSource: src.toDomain(),
    );
  }

  factory PhotoDto.fromJson(Map<String, dynamic> json) =>
      _$PhotoDtoFromJson(json);
}
