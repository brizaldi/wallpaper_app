import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:wallpaper_app/domain/core/value_objects.dart';
import 'package:wallpaper_app/domain/photos/photo.dart';
import 'package:wallpaper_app/domain/photos/photo_source.dart';
import 'package:wallpaper_app/domain/photos/value_objects.dart';
import 'package:wallpaper_app/infrastructure/photos/dto/photo_dtos.dart';
import 'package:wallpaper_app/infrastructure/photos/dto/photo_source_dtos.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tPhotoDto = PhotoDto(
    id: 2014422,
    width: 3024,
    height: 3024,
    url: 'https://www.pexels.com/photo/brown-rocks-during-golden-hour-2014422/',
    photographer: 'Joey Farina',
    photographerUrl: 'https://www.pexels.com/@joey',
    photographerId: 680589,
    avgColor: '#978E82',
    src: PhotoSourceDto(
      original:
          'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg',
      large2x:
          'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      large:
          'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=650&w=940',
      medium:
          'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=350',
      small:
          'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=130',
      portrait:
          'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800',
      landscape:
          'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200',
      tiny:
          'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280',
    ),
  );

  final tPhotoDomain = Photo(
    photoId: UniqueId.fromInteger(2014422),
    width: 3024,
    height: 3024,
    photoUrl: PhotoUrl(
        'https://www.pexels.com/photo/brown-rocks-during-golden-hour-2014422/'),
    photographerName: PhotographerName('Joey Farina'),
    photographerUrl: PhotographerUrl('https://www.pexels.com/@joey'),
    photographerId: UniqueId.fromInteger(680589),
    averageColor: AverageColor('#978E82'),
    photoSource: PhotoSource(
      original: PhotoSourceUrl(
          'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg'),
      large2x: PhotoSourceUrl(
          'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
      large: PhotoSourceUrl(
          'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=650&w=940'),
      medium: PhotoSourceUrl(
          'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=350'),
      small: PhotoSourceUrl(
          'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=130'),
      portrait: PhotoSourceUrl(
          'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800'),
      landscape: PhotoSourceUrl(
          'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200'),
      tiny: PhotoSourceUrl(
          'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280'),
    ),
  );

  group('fromJson', () {
    test(
      '\nGiven a valid json'
      '\nWhen fromJson called'
      '\nThen return a valid dto',
      () async {
        // arrange
        final jsonMap = jsonDecode(fixture('get_photo.json'));
        // act
        final result = PhotoDto.fromJson(jsonMap);
        // assert
        expect(result, tPhotoDto);
      },
    );
  });

  group('toJson', () {
    test(
      '\nGiven a valid dto'
      '\nWhen toJson called'
      '\nThen return a valid json',
      () async {
        // act
        final result = tPhotoDto.toJson();
        // assert
        final expectedJson = {
          'id': 2014422,
          'width': 3024,
          'height': 3024,
          'url':
              'https://www.pexels.com/photo/brown-rocks-during-golden-hour-2014422/',
          'photographer': 'Joey Farina',
          'photographer_url': 'https://www.pexels.com/@joey',
          'photographer_id': 680589,
          'avg_color': '#978E82',
          'src': {
            'original':
                'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg',
            'large2x':
                'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
            'large':
                'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=650&w=940',
            'medium':
                'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=350',
            'small':
                'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=130',
            'portrait':
                'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800',
            'landscape':
                'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200',
            'tiny':
                'https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280'
          },
        };
        expect(result, expectedJson);
      },
    );
  });

  group('fromDomain', () {
    test(
      '\nGiven a valid domain'
      '\nWhen fromDomain called'
      '\nThen return a valid dto',
      () async {
        // arrange
        // act
        final result = PhotoDto.fromDomain(tPhotoDomain);
        // assert
        expect(result, tPhotoDto);
      },
    );
  });

  group('toDomain', () {
    test(
      '\nGiven a valid dto'
      '\nWhen toDomain called'
      '\nThen return a valid domain',
      () async {
        // arrange
        // act
        final result = tPhotoDto.toDomain();
        // assert
        expect(result, tPhotoDomain);
      },
    );
  });
}
