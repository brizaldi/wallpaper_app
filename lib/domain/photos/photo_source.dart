import 'package:freezed_annotation/freezed_annotation.dart';

import 'value_objects.dart';

part 'photo_source.freezed.dart';

@freezed
class PhotoSource with _$PhotoSource {
  const factory PhotoSource({
    required PhotoSourceUrl original,
    required PhotoSourceUrl large2x,
    required PhotoSourceUrl large,
    required PhotoSourceUrl medium,
    required PhotoSourceUrl small,
    required PhotoSourceUrl portrait,
    required PhotoSourceUrl landscape,
    required PhotoSourceUrl tiny,
  }) = _PhotoSource;
}
