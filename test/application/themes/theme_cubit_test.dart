import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wallpaper_app/application/themes/theme_cubit.dart';
import 'package:wallpaper_app/domain/themes/i_theme_repository.dart';
import 'package:wallpaper_app/domain/themes/theme_failure.dart';
import 'package:wallpaper_app/extra/config/configuration.dart';
import 'theme_cubit_test.mocks.dart';

@GenerateMocks([IThemeRepository])
void main() {
  final mockRepository = MockIThemeRepository();

  setUp(() {
    BuildConfig.init(flavor: 'production');
  });

  test('initial state should be true', () {
    // assert
    expect(
      ThemeCubit(mockRepository).state,
      true,
    );
  });

  group('ThemeCubit', () {
    blocTest<ThemeCubit, bool>(
      'emits [] when nothing is called',
      build: () => ThemeCubit(mockRepository),
      expect: () => const <bool>[],
    );

    group('initializeTheme', () {
      const tValue = true;

      blocTest<ThemeCubit, bool>(
        '\nGiven the getTheme result is success'
        '\nWhen initializeTheme is called'
        '\nThen emits the right value',
        build: () => ThemeCubit(mockRepository),
        setUp: () {
          when(mockRepository.getTheme())
              .thenAnswer((_) async => right(tValue));
        },
        act: (cubit) => cubit.initializeTheme(),
        verify: (_) {
          verify(mockRepository.getTheme());
        },
        expect: () => const <bool>[tValue],
      );

      blocTest<ThemeCubit, bool>(
        '\nGiven the getTheme result is failure'
        '\nWhen initializeTheme is called'
        '\nThen emits [true]',
        build: () => ThemeCubit(mockRepository),
        setUp: () {
          when(mockRepository.getTheme())
              .thenAnswer((_) async => left(const ThemeFailure.cacheError()));
        },
        act: (cubit) => cubit.initializeTheme(),
        verify: (_) {
          verify(mockRepository.getTheme());
        },
        expect: () => const <bool>[true],
      );
    });

    group('toggleTheme', () {
      const tState = true;

      blocTest<ThemeCubit, bool>(
        '\nGiven currentState value is true and setTheme result is success'
        '\nWhen toggleTheme is called'
        '\nThen call setTheme with parameter !currentState and '
        'emits result value',
        build: () => ThemeCubit(mockRepository),
        setUp: () {
          when(mockRepository.setTheme(isDarkMode: anyNamed('isDarkMode')))
              .thenAnswer((_) async => right(!tState));
        },
        seed: () => tState,
        act: (cubit) => cubit.toggleTheme(),
        verify: (_) {
          verify(mockRepository.setTheme(isDarkMode: !tState));
        },
        expect: () => <bool>[!tState],
      );

      blocTest<ThemeCubit, bool>(
        '\nGiven currentState value is true and setTheme result is failure'
        '\nWhen toggleTheme is called'
        '\nThen call setTheme with parameter !currentState and '
        'emits nothing',
        build: () => ThemeCubit(mockRepository),
        setUp: () {
          when(mockRepository.setTheme(isDarkMode: anyNamed('isDarkMode')))
              .thenAnswer((_) async => left(const ThemeFailure.cacheError()));
        },
        seed: () => tState,
        act: (cubit) => cubit.toggleTheme(),
        verify: (_) {
          verify(mockRepository.setTheme(isDarkMode: !tState));
        },
        expect: () => <bool>[],
      );
    });
  });
}
