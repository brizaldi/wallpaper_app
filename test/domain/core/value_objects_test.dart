import 'package:flutter_test/flutter_test.dart';
import 'package:wallpaper_app/domain/core/failures.dart';
import 'package:wallpaper_app/domain/core/value_objects.dart';

void main() {
  group('UniqueId', () {
    test(
      '\nGiven a valid id with type String'
      '\nWhen it is inputted'
      '\nThen return Right with the same input',
      () async {
        const validId = '1';
        final uniqueIdValueObject = UniqueId(validId).value;

        expect(uniqueIdValueObject.isRight(), isTrue);
        uniqueIdValueObject.fold(
          (_) {},
          (value) {
            expect(value, validId);
          },
        );
      },
    );

    test(
      '\nGiven a valid id with type int'
      '\nWhen it is inputted'
      '\nThen return Right with the input formatted as String',
      () async {
        const validId = 1;
        final uniqueIdValueObject = UniqueId.fromInteger(validId).value;

        expect(uniqueIdValueObject.isRight(), isTrue);
        uniqueIdValueObject.fold(
          (_) {},
          (value) {
            expect(value, validId.toString());
          },
        );
      },
    );

    test(
      '\nGiven a invalid id'
      '\nWhen it is inputted'
      '\nThen return Left with an Empty failure',
      () async {
        const invalidId = '';
        final uniqueIdValueObject = UniqueId(invalidId).value;

        expect(uniqueIdValueObject.isLeft(), isTrue);
        uniqueIdValueObject.fold(
          (failure) {
            expect(failure, isA<Empty<String>>());
          },
          (_) {},
        );
      },
    );
  });
}
