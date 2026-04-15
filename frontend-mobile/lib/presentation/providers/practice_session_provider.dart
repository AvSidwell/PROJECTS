import 'package:flutter_riverpod/flutter_riverpod.dart';

class PracticeSessionState {
  const PracticeSessionState({
    required this.checkedDrillIds,
    required this.elapsedSeconds,
    required this.isRunning,
    this.bestHoldSeconds,
  });

  final Set<String> checkedDrillIds;
  final int elapsedSeconds;
  final bool isRunning;
  final int? bestHoldSeconds;

  PracticeSessionState copyWith({
    Set<String>? checkedDrillIds,
    int? elapsedSeconds,
    bool? isRunning,
    int? bestHoldSeconds,
  }) {
    return PracticeSessionState(
      checkedDrillIds: checkedDrillIds ?? this.checkedDrillIds,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      isRunning: isRunning ?? this.isRunning,
      bestHoldSeconds: bestHoldSeconds ?? this.bestHoldSeconds,
    );
  }
}

class PracticeSessionNotifier extends StateNotifier<PracticeSessionState> {
  PracticeSessionNotifier()
      : super(const PracticeSessionState(
          checkedDrillIds: {},
          elapsedSeconds: 0,
          isRunning: false,
        ));

  void toggleDrill(String drillId) {
    final updated = Set<String>.from(state.checkedDrillIds);
    if (updated.contains(drillId)) {
      updated.remove(drillId);
    } else {
      updated.add(drillId);
    }
    state = state.copyWith(checkedDrillIds: updated);
  }

  void tick() {
    if (state.isRunning) {
      state = state.copyWith(elapsedSeconds: state.elapsedSeconds + 1);
    }
  }

  void startTimer() => state = state.copyWith(isRunning: true);
  void pauseTimer() => state = state.copyWith(isRunning: false);

  void recordHold(int seconds) {
    final best = state.bestHoldSeconds;
    state = state.copyWith(
      bestHoldSeconds: best == null ? seconds : (seconds > best ? seconds : best),
    );
  }

  void reset() {
    state = const PracticeSessionState(
      checkedDrillIds: {},
      elapsedSeconds: 0,
      isRunning: false,
    );
  }
}

final practiceSessionProvider =
    StateNotifierProvider.autoDispose<PracticeSessionNotifier, PracticeSessionState>(
  (_) => PracticeSessionNotifier(),
);
