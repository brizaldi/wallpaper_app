import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallpaper_app/application/layouts/layout_cubit.dart';
import 'package:wallpaper_app/domain/layouts/layout_type.dart';
import 'package:wallpaper_app/extra/config/configuration.dart';

void main() {
  setUp(() {
    BuildConfig.init(flavor: 'production');
  });

  test('initial state should be LayoutType.gridView()', () {
    // assert
    expect(
      LayoutCubit().state,
      const LayoutType.gridView(),
    );
  });

  group('LayoutCubit', () {
    blocTest<LayoutCubit, LayoutType>(
      'emits [] when nothing is called',
      build: () => LayoutCubit(),
      expect: () => const <LayoutType>[],
    );

    blocTest<LayoutCubit, LayoutType>(
      '\nGiven current state is LayoutType.gridView()'
      '\nWhen layoutToggled is called'
      '\nThen emits [LayoutType.listView()]',
      build: () => LayoutCubit(),
      seed: () => const LayoutType.gridView(),
      act: (cubit) => cubit.layoutToggled(),
      expect: () => const <LayoutType>[LayoutType.listView()],
    );
  });
}
