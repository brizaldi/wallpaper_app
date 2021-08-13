import 'package:bloc/bloc.dart';

import '../../domain/layouts/layout_type.dart';
import '../../extra/utils/logging.dart';

class LayoutCubit extends Cubit<LayoutType> {
  LayoutCubit() : super(const LayoutType.gridView());

  @override
  void onChange(Change<LayoutType> change) {
    Log.info(change.toString());
    super.onChange(change);
  }

  void layoutToggled() {
    state.map(
      gridView: (_) => emit(const LayoutType.listView()),
      listView: (_) => emit(const LayoutType.gridView()),
    );
  }
}
