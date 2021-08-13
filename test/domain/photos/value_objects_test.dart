import 'package:flutter_test/flutter_test.dart';
import 'package:wallpaper_app/domain/core/failures.dart';
import 'package:wallpaper_app/domain/photos/value_objects.dart';

void main() {
  group('PhotographerName', () {
    test(
      '\nGiven a valid photographer name'
      '\nWhen it is inputted'
      '\nThen return Right with the same input',
      () async {
        const photographerName = 'John Doe';
        final photographerNameValueObject =
            PhotographerName(photographerName).value;

        expect(photographerNameValueObject.isRight(), isTrue);
        photographerNameValueObject.fold(
          (_) {},
          (value) {
            expect(value, photographerName);
          },
        );
      },
    );

    test(
      '\nGiven an invalid photographer name'
      '\nWhen it is inputted'
      '\nThen return Left with an Empty failure',
      () async {
        const photographerName = '';
        final photographerNameValueObject =
            PhotographerName(photographerName).value;

        expect(photographerNameValueObject.isLeft(), isTrue);
        photographerNameValueObject.fold(
          (failure) {
            expect(failure, isA<Empty<String>>());
          },
          (_) {},
        );
      },
    );
  });

  group('PhotographerUrl', () {
    test(
      '\nGiven a valid photographer url'
      '\nWhen it is inputted'
      '\nThen return Right with the same input',
      () async {
        const photographerUrl = 'https://google.com';
        final photographerUrlValueObject =
            PhotographerUrl(photographerUrl).value;

        expect(photographerUrlValueObject.isRight(), isTrue);
        photographerUrlValueObject.fold(
          (_) {},
          (value) {
            expect(value, photographerUrl);
          },
        );
      },
    );

    test(
      '\nGiven an invalid photographer url'
      '\nWhen it is inputted'
      '\nThen return Left with an Empty failure',
      () async {
        const photographerUrl = '';
        final photographerUrlValueObject =
            PhotographerUrl(photographerUrl).value;

        expect(photographerUrlValueObject.isLeft(), isTrue);
        photographerUrlValueObject.fold(
          (failure) {
            expect(failure, isA<Empty<String>>());
          },
          (_) {},
        );
      },
    );
  });

  group('AverageColor', () {
    test(
      '\nGiven a valid average color'
      '\nWhen it is inputted'
      '\nThen return Right with the same input',
      () async {
        const averageColor = '#ffffff';
        final averageColorValueObject = AverageColor(averageColor).value;

        expect(averageColorValueObject.isRight(), isTrue);
        averageColorValueObject.fold(
          (_) {},
          (value) {
            expect(value, averageColor);
          },
        );
      },
    );

    test(
      '\nGiven an invalid average color'
      '\nWhen it is inputted'
      '\nThen return Left with an Empty failure',
      () async {
        const averageColor = '';
        final averageColorValueObject = AverageColor(averageColor).value;

        expect(averageColorValueObject.isLeft(), isTrue);
        averageColorValueObject.fold(
          (failure) {
            expect(failure, isA<Empty<String>>());
          },
          (_) {},
        );
      },
    );
  });

  group('PhotoSourceUrl', () {
    test(
      '\nGiven a valid photo source url'
      '\nWhen it is inputted'
      '\nThen return Right with the same input',
      () async {
        const photoSourceUrl = 'https://google.com';
        final photoSourceUrlValueObject = PhotoSourceUrl(photoSourceUrl).value;

        expect(photoSourceUrlValueObject.isRight(), isTrue);
        photoSourceUrlValueObject.fold(
          (_) {},
          (value) {
            expect(value, photoSourceUrl);
          },
        );
      },
    );

    test(
      '\nGiven an invalid photo source url'
      '\nWhen it is inputted'
      '\nThen return Left with an Empty failure',
      () async {
        const photoSourceUrl = '';
        final photoSourceUrlValueObject = PhotoSourceUrl(photoSourceUrl).value;

        expect(photoSourceUrlValueObject.isLeft(), isTrue);
        photoSourceUrlValueObject.fold(
          (failure) {
            expect(failure, isA<Empty<String>>());
          },
          (_) {},
        );
      },
    );
  });

  group('PhotoUrl', () {
    test(
      '\nGiven a valid photo url'
      '\nWhen it is inputted'
      '\nThen return Right with the same input',
      () async {
        const photoUrl = 'https://google.com';
        final photoUrlValueObject = PhotoUrl(photoUrl).value;

        expect(photoUrlValueObject.isRight(), isTrue);
        photoUrlValueObject.fold(
          (_) {},
          (value) {
            expect(value, photoUrl);
          },
        );
      },
    );

    test(
      '\nGiven an invalid photo url'
      '\nWhen it is inputted'
      '\nThen return Left with an Empty failure',
      () async {
        const photoUrl = '';
        final photoUrlValueObject = PhotoUrl(photoUrl).value;

        expect(photoUrlValueObject.isLeft(), isTrue);
        photoUrlValueObject.fold(
          (failure) {
            expect(failure, isA<Empty<String>>());
          },
          (_) {},
        );
      },
    );
  });
}
