import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../application/layouts/view_cubit.dart';
import '../../../application/photos/photos_watcher/photos_watcher_bloc.dart';
import '../../../domain/layouts/layout_type.dart';
import '../../../extra/constants/strings.dart';
import '../../core/widgets/alert_helper.dart';
import '../../core/widgets/error_view.dart';
import 'photo_grid_view.dart';
import 'photo_list_view.dart';

class HomeBody extends HookWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _scrollController = useScrollController();
    _scrollController.addListener(() => _onScroll(context, _scrollController));

    return BlocConsumer<PhotosWatcherBloc, PhotosWatcherState>(
      listener: (context, state) {
        state.failureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) => AlertHelper.showRetrySnackBar(
              context,
              message: failure.map(
                serverError: (_) => Strings.serverErrorMessage,
                noConnectionError: (_) => Strings.noConnectionErrorMessage,
              ),
              onTapRetry: () => _onRetry(context),
            ),
            (_) {},
          ),
        );
      },
      builder: (context, state) {
        return state.status.maybeMap(
          initial: (_) => const SizedBox(),
          orElse: () {
            if (state.listPhoto.isEmpty) {
              return state.status.maybeMap(
                inProgress: (_) => const SizedBox(),
                orElse: () => ErrorView(
                  message: Strings.emptyResultErrorMessage,
                  onRetry: () => _onRetry(context),
                ),
              );
            }

            return BlocBuilder<LayoutCubit, LayoutType>(
              builder: (context, layoutState) {
                return layoutState.map(
                  gridView: (_) => PhotoGridView(
                    controller: _scrollController,
                    onRetry: () => _onRetry(context),
                    photos: state.listPhoto,
                  ),
                  listView: (_) => PhotoListView(
                    controller: _scrollController,
                    onRetry: () => _onRetry(context),
                    photos: state.listPhoto,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _onRetry(BuildContext context) {
    context.read<PhotosWatcherBloc>().add(const PhotosWatcherEvent.refreshed());
  }

  void _onScroll(BuildContext context, ScrollController scrollController) {
    if (_isBottom(scrollController)) {
      context.read<PhotosWatcherBloc>().add(const PhotosWatcherEvent.fetched());
    }
  }

  bool _isBottom(ScrollController scrollController) {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
