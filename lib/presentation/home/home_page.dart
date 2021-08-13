import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/layouts/layout_cubit.dart';
import '../../application/photos/photos_watcher/photos_watcher_bloc.dart';
import '../../extra/injection/injection.dart';
import 'widgets/home_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LayoutCubit(),
        ),
        BlocProvider(
          create: (context) => getIt<PhotosWatcherBloc>()
            ..add(const PhotosWatcherEvent.fetched()),
        ),
      ],
      child: const HomeScaffold(),
    );
  }
}
