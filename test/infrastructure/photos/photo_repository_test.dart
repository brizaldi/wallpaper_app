import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wallpaper_app/domain/core/exceptions.dart';
import 'package:wallpaper_app/domain/photos/photo.dart';
import 'package:wallpaper_app/domain/photos/photo_failure.dart';
import 'package:wallpaper_app/extra/network/network_info.dart';
import 'package:wallpaper_app/infrastructure/photos/dto/photo_dtos.dart';
import 'package:wallpaper_app/infrastructure/photos/photo_remote_datasource.dart';
import 'package:wallpaper_app/infrastructure/photos/photo_repository.dart';
import '../../fixtures/fixture_reader.dart';
import 'photo_repository_test.mocks.dart';

@GenerateMocks([INetworkInfo, IPhotoRemoteDataSource])
void main() {
  late PhotoRepository repository;
  final mockNetworkInfo = MockINetworkInfo();
  final mockRemoteDataSource = MockIPhotoRemoteDataSource();

  setUp(() {
    repository = PhotoRepository(mockNetworkInfo, mockRemoteDataSource);
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getPhotos', () {
    const tPage = 1;
    const tLimit = 20;
    final tPhotos = jsonDecode(fixture('get_photos.json'))['photos']
        .map((e) => PhotoDto.fromJson(e).toDomain())
        .cast<Photo>()
        .toList();

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getPhotos(
          page: anyNamed('page'),
          limit: anyNamed('limit'),
        )).thenAnswer((_) => Future.value(tPhotos));
        // act
        await repository.getPhotos(page: tPage, limit: tLimit);
        // assert
        verify(mockNetworkInfo.isConnected());
      },
    );

    runTestsOnline(() {
      test(
        '\nWhen the call to remote data source is successful'
        '\nThen return remote data',
        () async {
          // arrange
          when(mockRemoteDataSource.getPhotos(
            page: anyNamed('page'),
            limit: anyNamed('limit'),
          )).thenAnswer((_) => Future.value(tPhotos));
          // act
          final result = await repository.getPhotos(
            page: tPage,
            limit: tLimit,
          );
          // assert
          verify(mockRemoteDataSource.getPhotos(
            page: tPage,
            limit: tLimit,
          ));
          expect(result, equals(right(tPhotos)));
        },
      );

      test(
        '\nWhen the call to remote data source is unsuccessful'
        '\nThen return server failure',
        () async {
          // arrange
          when(mockRemoteDataSource.getPhotos(
            page: anyNamed('page'),
            limit: anyNamed('limit'),
          )).thenThrow(ServerException());
          // act
          final result = await repository.getPhotos(
            page: tPage,
            limit: tLimit,
          );
          // assert
          verify(mockRemoteDataSource.getPhotos(
            page: tPage,
            limit: tLimit,
          ));
          expect(result, equals(left(const PhotoFailure.serverError())));
        },
      );
    });

    runTestsOffline(() {
      test(
        '\nWhen the device is offline'
        '\nThen return no connection failure',
        () async {
          // arrange
          // act
          final result = await repository.getPhotos(
            page: tPage,
            limit: tLimit,
          );
          // assert
          verifyNever(mockRemoteDataSource.getPhotos(
            page: tPage,
            limit: tLimit,
          ));
          expect(result, equals(left(const PhotoFailure.noConnectionError())));
        },
      );
    });
  });
}
