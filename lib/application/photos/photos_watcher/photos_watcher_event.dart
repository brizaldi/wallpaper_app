part of 'photos_watcher_bloc.dart';

@freezed
class PhotosWatcherEvent with _$PhotosWatcherEvent {
  const factory PhotosWatcherEvent.fetched() = _Fetched;

  const factory PhotosWatcherEvent.refreshed() = _Refreshed;

  const factory PhotosWatcherEvent.keywordChanged({
    required String keyword,
  }) = _KeywordChanged;
}
