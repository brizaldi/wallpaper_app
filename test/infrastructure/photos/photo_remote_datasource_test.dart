import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wallpaper_app/domain/core/exceptions.dart';
import 'package:wallpaper_app/domain/photos/photo.dart';
import 'package:wallpaper_app/extra/config/configuration.dart';
import 'package:wallpaper_app/infrastructure/photos/dto/photo_dtos.dart';
import 'package:wallpaper_app/infrastructure/photos/photo_remote_datasource.dart';

import '../../fixtures/fixture_reader.dart';
import 'photo_remote_datasource_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late PhotoRemoteDataSource dataSource;
  final mockDio = MockDio();

  setUp(() {
    BuildConfig.init(flavor: 'production');
    dataSource = PhotoRemoteDataSource(mockDio);
  });

  void setUpMockDioSuccess200() {
    when(mockDio.get(
      any,
      queryParameters: anyNamed('queryParameters'),
    )).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: 'https://google.com'),
        statusCode: 200,
        data: jsonDecode(fixture('get_photos.json')),
      ),
    );
  }

  void setUpMockDioFailure404() {
    when(mockDio.get(
      any,
      queryParameters: anyNamed('queryParameters'),
    )).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: 'https://google.com'),
        statusCode: 404,
        data: 'Something went wrong',
      ),
    );
  }

  group('getPhotos', () {
    const tPage = 1;
    const tLimit = 20;
    const tKeyword = null;
    final tPhotos = jsonDecode(fixture('get_photos.json'))['photos']
        .map((e) => PhotoDto.fromJson(e).toDomain())
        .cast<Photo>()
        .toList();

    test(
      '\nGiven a url with search being the endpoint'
      '\nWhen getPhotos called'
      '\nThen perform a GET request on that url',
      () async {
        // arrange
        setUpMockDioSuccess200();
        // act
        await dataSource.getPhotos(page: tPage, limit: tLimit);
        // assert
        verify(mockDio.get(
          'search',
          queryParameters: {
            'page': tPage,
            'per_page': tLimit,
            'query': tKeyword ?? 'random',
          },
        ));
      },
    );

    test(
      '\nGiven a response code is 200 (success)'
      '\nWhen getPhotos called'
      '\nThen return list of photo',
      () async {
        // arrange
        setUpMockDioSuccess200();
        // act
        final result = await dataSource.getPhotos(page: tPage, limit: tLimit);
        // assert
        expect(result, equals(tPhotos));
      },
    );

    test(
      '\nGiven a response code is 404 or other'
      '\nWhen getPhotos called'
      '\nThen throw a ServerException',
      () async {
        // arrange
        setUpMockDioFailure404();
        // act
        final call = dataSource.getPhotos;
        // assert
        expect(
          () => call(page: tPage, limit: tLimit),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });
}
