import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:wallpaper_app/application/photos/photos_watcher/photos_watcher_bloc.dart';
import 'package:wallpaper_app/domain/photos/i_photo_repository.dart';
import 'package:wallpaper_app/extra/config/configuration.dart';
import 'photos_watcher_bloc_test.mocks.dart';

@GenerateMocks([IPhotoRepository])
void main() {
  final mockRepository = MockIPhotoRepository();

  setUp(() {
    BuildConfig.init(flavor: 'production');
  });

  test('initial state should be PhotosWatcherState.initial()', () {
    // assert
    expect(
      PhotosWatcherBloc(mockRepository).state,
      PhotosWatcherState.initial(),
    );
  });

  blocTest<PhotosWatcherBloc, PhotosWatcherState>(
    'emits [] when nothing is called',
    build: () => PhotosWatcherBloc(mockRepository),
    expect: () => const <PhotosWatcherState>[],
  );

  // TODO: Add remaining unit test case
}
