part of 'photos_watcher_bloc.dart';

@freezed
class PhotosWatcherState with _$PhotosWatcherState {
  const factory PhotosWatcherState({
    required FetchStatus status,
    required bool hasReachedMax,
    required int page,
    required int limit,
    required String keyword,
    required List<Photo> listPhoto,
    required Option<Either<PhotoFailure, List<Photo>>> failureOrSuccessOption,
  }) = _PhotosWatcherState;

  factory PhotosWatcherState.initial() => PhotosWatcherState(
        status: const FetchStatus.initial(),
        hasReachedMax: false,
        page: 1,
        limit: 20,
        keyword: 'random',
        listPhoto: [],
        failureOrSuccessOption: none(),
      );
}
