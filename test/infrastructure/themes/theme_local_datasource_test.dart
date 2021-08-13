import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wallpaper_app/domain/core/exceptions.dart';
import 'package:wallpaper_app/extra/config/configuration.dart';
import 'package:wallpaper_app/extra/constants/strings.dart';
import 'package:wallpaper_app/infrastructure/themes/theme_local_datasource.dart';
import 'theme_local_datasource_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late ThemeLocalDataSource dataSource;
  final mockBox = MockBox();

  setUp(() {
    BuildConfig.init(flavor: 'production');
    dataSource = ThemeLocalDataSource(mockBox);
  });

  group('getTheme', () {
    test(
      '\nWhen a cached value is equals to `false`'
      '\nThen return false',
      () async {
        // arrange
        when(mockBox.get(any)).thenReturn('false');
        // act
        final result = await dataSource.getTheme();
        // assert
        verify(mockBox.get(Strings.isDarkMode));
        expect(result, false);
      },
    );

    test(
      '\nWhen a cached value is not equals to `false`'
      '\nThen return true',
      () async {
        // arrange
        when(mockBox.get(any)).thenReturn(null);
        // act
        final result = await dataSource.getTheme();
        // assert
        verify(mockBox.get(Strings.isDarkMode));
        expect(result, true);
      },
    );

    test(
      '\nWhen getting cached value throws any error'
      '\nThen return cache failure',
      () async {
        // arrange
        when(mockBox.get(any)).thenThrow(HiveError('Something went wrong'));
        // act
        final call = dataSource.getTheme;
        // assert
        expect(
          call,
          throwsA(const TypeMatcher<CacheException>()),
        );
      },
    );
  });

  group('setTheme', () {
    const tIsDarkMode = true;

    test(
      '\nWhen saving theme value'
      '\nThen call put() method',
      () async {
        // arrange
        // act
        await dataSource.setTheme(isDarkMode: tIsDarkMode);
        // assert
        verify(mockBox.put(Strings.isDarkMode, tIsDarkMode.toString()));
      },
    );
  });
}
