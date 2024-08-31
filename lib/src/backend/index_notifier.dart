import 'package:riverpod_annotation/riverpod_annotation.dart';
part '.g.dart';

enum IndexState {
  initial,
  loading,
  loaded,
  error,
}

@riverpod
class IndexNotifier extends _$IndexNotifier {
  @override
  IndexState build() => IndexState.initial;
}
