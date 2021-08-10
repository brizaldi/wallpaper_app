import 'package:dartz/dartz.dart';

import '../core/failures.dart';
import '../core/value_objects.dart';
import '../core/value_validators.dart';

class PhotographerName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory PhotographerName(String input) {
    return PhotographerName._(
      validateStringNotEmpty(input),
    );
  }

  const PhotographerName._(this.value);
}

class PhotographerUrl extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory PhotographerUrl(String input) {
    return PhotographerUrl._(
      validateStringNotEmpty(input),
    );
  }

  const PhotographerUrl._(this.value);
}

class AverageColor extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory AverageColor(String input) {
    return AverageColor._(
      validateStringNotEmpty(input),
    );
  }

  const AverageColor._(this.value);
}

class PhotoUrl extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory PhotoUrl(String input) {
    return PhotoUrl._(
      validateStringNotEmpty(input),
    );
  }

  const PhotoUrl._(this.value);
}

class PhotoSourceUrl extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory PhotoSourceUrl(String input) {
    return PhotoSourceUrl._(
      validateStringNotEmpty(input),
    );
  }

  const PhotoSourceUrl._(this.value);
}
