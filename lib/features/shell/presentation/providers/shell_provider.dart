import 'package:flutter_riverpod/flutter_riverpod.dart';

final shellIndexProvider =
    StateNotifierProvider<ShellIndexNotifier, int>(
  (ref) => ShellIndexNotifier(),
);

class ShellIndexNotifier extends StateNotifier<int> {
  ShellIndexNotifier() : super(0);

  void setIndex(int index) => state = index;
}
