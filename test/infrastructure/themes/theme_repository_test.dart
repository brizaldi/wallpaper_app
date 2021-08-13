import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wallpaper_app/domain/core/exceptions.dart';
import 'package:wallpaper_app/domain/themes/theme_failure.dart';
import 'package:wallpaper_app/infrastructure/themes/theme_local_datasource.dart';
import 'package:wallpaper_app/infrastructure/themes/theme_repository.dart';
import 'theme_repository_test.mocks.dart';

@GenerateMocks([IThemeLocalDataSource])
void main() {
  late ThemeRepository repository;
  final mockLocalDataSource = MockIThemeLocalDataSource();

  setUp(() {
    repository = ThemeRepository(mockLocalDataSource);
  });

  group('getTheme', () {
    test(
      '\nWhen the call to local data source is successful'
      '\nThen return the right local data value',
      () async {
        // arrange
        when(mockLocalDataSource.getTheme()).thenAnswer((_) async => true);
        // act
        final result = await repository.getTheme();
        // assert
        verify(mockLocalDataSource.getTheme());
        expect(result, equals(right(true)));
      },
    );

    test(
      '\nWhen the call to local data source is unsuccessful'
      '\nThen return cache failure',
      () async {
        // arrange
        when(mockLocalDataSource.getTheme()).thenThrow(CacheException());
        // act
        final result = await repository.getTheme();
        // assert
        verify(mockLocalDataSource.getTheme());
        expect(result, equals(left(const ThemeFailure.cacheError())));
      },
    );
  });

  group('setTheme', () {
    const tIsDarkMode = true;

    test(
      '\nWhen the call to local data source is successful'
      '\nThen return the right local data value',
      () async {
        // arrange
        when(mockLocalDataSource.setTheme(isDarkMode: anyNamed('isDarkMode')))
            .thenAnswer((_) async => true);
        // act
        final result = await repository.setTheme(isDarkMode: tIsDarkMode);
        // assert
        verify(mockLocalDataSource.setTheme(isDarkMode: tIsDarkMode));
        expect(result, equals(right(true)));
      },
    );

    test(
      '\nWhen the call to local data source is unsuccessful'
      '\nThen return cache failure',
      () async {
        // arrange
        when(mockLocalDataSource.setTheme(isDarkMode: anyNamed('isDarkMode')))
            .thenThrow(CacheException());
        // act
        final result = await repository.setTheme(isDarkMode: tIsDarkMode);
        // assert
        verify(mockLocalDataSource.setTheme(isDarkMode: tIsDarkMode));
        expect(result, equals(left(const ThemeFailure.cacheError())));
      },
    );
  });
}
