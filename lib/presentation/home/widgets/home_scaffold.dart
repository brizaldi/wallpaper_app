import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../application/layouts/layout_cubit.dart';
import '../../../application/photos/photos_watcher/photos_watcher_bloc.dart';
import '../../../application/themes/theme_cubit.dart';
import '../../../domain/layouts/layout_type.dart';
import '../../../extra/constants/strings.dart';
import '../../../extra/style/style.dart';
import 'custom_search_delegate.dart';
import 'home_body.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          Strings.appName,
          style: _textTheme.headline6,
        ),
        actions: [
          IconButton(
            onPressed: () => context.read<LayoutCubit>().layoutToggled(),
            tooltip: 'Layout',
            icon: BlocBuilder<LayoutCubit, LayoutType>(
              builder: (context, state) {
                return state.map(
                  gridView: (_) => const Icon(
                    MaterialCommunityIcons.view_grid,
                  ),
                  listView: (_) => const Icon(
                    MaterialCommunityIcons.view_list,
                  ),
                );
              },
            ),
          ),
          IconButton(
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            tooltip: 'Theme',
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onTapSearch(context),
        tooltip: 'Search',
        child: const Icon(
          Icons.search,
        ),
      ),
      body: BlocBuilder<PhotosWatcherBloc, PhotosWatcherState>(
        buildWhen: (p, c) => p.status != c.status,
        builder: (context, state) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              const HomeBody(),
              state.status.maybeMap(
                orElse: () => const SizedBox(),
                inProgress: (_) => const LinearProgressIndicator(
                  color: Palette.amaranth,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _onTapSearch(BuildContext context) async {
    final _result = await showSearch(
      context: context,
      delegate: CustomSearchDelegate(),
    );

    if (_result != null) {
      context
          .read<PhotosWatcherBloc>()
          .add(PhotosWatcherEvent.keywordChanged(keyword: _result));
    }
  }
}
