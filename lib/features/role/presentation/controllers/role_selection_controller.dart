import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saudiaaaa/features/role/domain/entities/user_role.dart';
import 'package:saudiaaaa/features/role/presentation/controllers/role_controller.dart';

/// Transient state of the selection screen.
///
/// Separate from [roleControllerProvider], which holds the *committed* role:
/// a tap here is a pending choice that means nothing to the rest of the app
/// until Continue persists it.
class RoleSelectionState {
  const RoleSelectionState({
    this.selected,
    this.isSaving = false,
    this.hasError = false,
  });

  final UserRole? selected;
  final bool isSaving;

  /// Set when persisting threw. Held as a flag rather than a message so the
  /// view resolves the copy through `AppStrings` in the active language.
  final bool hasError;

  /// Continue stays disabled until something is picked, and while a commit is
  /// in flight.
  bool get canContinue => selected != null && !isSaving;

  bool isSelected(UserRole role) => selected == role;

  RoleSelectionState copyWith({
    UserRole? selected,
    bool? isSaving,
    bool? hasError,
  }) {
    return RoleSelectionState(
      selected: selected ?? this.selected,
      isSaving: isSaving ?? this.isSaving,
      hasError: hasError ?? this.hasError,
    );
  }
}

/// ViewModel for the role selection screen.
///
/// autoDispose: the screen is shown once on first launch, so its state should
/// not outlive it.
final roleSelectionControllerProvider = StateNotifierProvider.autoDispose<
    RoleSelectionController, RoleSelectionState>(
  RoleSelectionController.new,
);

class RoleSelectionController extends StateNotifier<RoleSelectionState> {
  RoleSelectionController(this._ref) : super(const RoleSelectionState());

  final Ref _ref;

  void select(UserRole role) {
    // Ignore taps mid-commit: the destination for the previous choice is
    // already resolving, and switching now would route somewhere the user
    // didn't confirm.
    if (state.isSaving) return;
    state = state.copyWith(selected: role, hasError: false);
  }

  /// Commits the pending choice.
  ///
  /// Deliberately no `Navigator` call: the root gate watches the persisted
  /// role and swaps the tree itself, which keeps routing out of the view and
  /// means the same logic serves both first launch and every launch after.
  Future<void> confirm() async {
    final selected = state.selected;
    if (selected == null || state.isSaving) return;

    state = state.copyWith(isSaving: true, hasError: false);
    try {
      await _ref.read(roleControllerProvider.notifier).setRole(selected);
      // No success state to publish: this notifier is disposed the moment the
      // gate swaps the selection screen out for the destination.
    } catch (e) {
      debugPrint('RoleSelectionController.confirm failed: $e');
      if (!mounted) return;
      state = state.copyWith(isSaving: false, hasError: true);
    }
  }
}
