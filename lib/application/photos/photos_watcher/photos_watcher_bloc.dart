import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/photos/fetch_status.dart';
import '../../../domain/photos/i_photo_repository.dart';
import '../../../domain/photos/photo.dart';
import '../../../domain/photos/photo_failure.dart';
import '../../../extra/utils/logging.dart';

part 'photos_watcher_bloc.freezed.dart';
part 'photos_watcher_event.dart';
part 'photos_watcher_state.dart';

@injectable
class PhotosWatcherBloc extends Bloc<PhotosWatcherEvent, PhotosWatcherState> {
  PhotosWatcherBloc(this._photoRepository)
      : super(PhotosWatcherState.initial());

  final IPhotoRepository _photoRepository;

  @override
  void onTransition(
    Transition<PhotosWatcherEvent, PhotosWatcherState> transition,
  ) {
    Log.info(transition.toString());
    super.onTransition(transition);
  }

  @override
  void onEvent(PhotosWatcherEvent event) {
    Log.info(event.toString());
    super.onEvent(event);
  }

  @override
  Stream<Transition<PhotosWatcherEvent, PhotosWatcherState>> transformEvents(
    Stream<PhotosWatcherEvent> events,
    TransitionFunction<PhotosWatcherEvent, PhotosWatcherState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<PhotosWatcherState> mapEventToState(
    PhotosWatcherEvent event,
  ) async* {
    yield* event.map(
      fetched: (e) async* {
        yield await _mapFetchedToState();
      },
      refreshed: (e) async* {
        final _lastKeyword = state.keyword;
        yield PhotosWatcherState.initial().copyWith(
          keyword: _lastKeyword,
        );
        add(const PhotosWatcherEvent.fetched());
      },
      keywordChanged: (e) async* {
        yield PhotosWatcherState.initial().copyWith(
          keyword: e.keyword,
        );
        add(const PhotosWatcherEvent.fetched());
      },
    );
  }

  Future<PhotosWatcherState> _mapFetchedToState() async {
    if (state.hasReachedMax) return state;

    if (state.status == const FetchStatus.initial()) {
      final either = await _getPhotos();

      return either.fold(
        (failure) => state.copyWith(
          status: const FetchStatus.failure(),
          failureOrSuccessOption: optionOf(either),
        ),
        (listPhoto) => state.copyWith(
          hasReachedMax: listPhoto.length < state.limit,
          page: state.page + 1,
          status: const FetchStatus.success(),
          listPhoto: listPhoto,
        ),
      );
    }

    final either = await _getPhotos();

    return either.fold(
      (failure) => state.copyWith(
        status: const FetchStatus.failure(),
        failureOrSuccessOption: optionOf(either),
      ),
      (listPhoto) {
        if (listPhoto.isEmpty) {
          return state.copyWith(
            hasReachedMax: true,
            failureOrSuccessOption: none(),
          );
        } else {
          return state.copyWith(
            status: const FetchStatus.success(),
            page: state.page + 1,
            listPhoto: List.of(state.listPhoto)..addAll(listPhoto),
            failureOrSuccessOption: none(),
          );
        }
      },
    );
  }

  Future<Either<PhotoFailure, List<Photo>>> _getPhotos() {
    return _photoRepository.getPhotos(
      page: state.page,
      limit: state.limit,
      keyword: state.keyword,
    );
  }
}
