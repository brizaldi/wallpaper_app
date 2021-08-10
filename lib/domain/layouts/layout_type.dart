import 'package:freezed_annotation/freezed_annotation.dart';

part 'layout_type.freezed.dart';

@freezed
class LayoutType with _$LayoutType {
  const factory LayoutType.gridView() = _GridView;
  const factory LayoutType.listView() = _ListView;
}
