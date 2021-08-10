import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_failure.freezed.dart';

@freezed
class PhotoFailure with _$PhotoFailure {
  const factory PhotoFailure.serverError() = ServerError;
  const factory PhotoFailure.noConnectionError() = NoConnectionError;
}
