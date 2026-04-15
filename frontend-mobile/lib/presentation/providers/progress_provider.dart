import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local/progress_local_datasource.dart';
import '../../data/repositories/progress_repository_impl.dart';
import '../../domain/entities/practice_session.dart';
import '../../domain/entities/user_progress.dart';
import '../../domain/repositories/progress_repository.dart';
import 'skill_provider.dart';

final progressLocalDatasourceProvider = Provider<ProgressLocalDatasource>(
  (ref) => ProgressLocalDatasource(ref.watch(sharedPrefsProvider)),
);

final progressRepositoryProvider = Provider<ProgressRepository>(
  (ref) => ProgressRepositoryImpl(ref.watch(progressLocalDatasourceProvider)),
);

// Notifier that manages a single skill's progress
class ProgressNotifier extends StateNotifier<AsyncValue<UserProgress?>> {
  ProgressNotifier(this._repo, this._skillId) : super(const AsyncLoading()) {
    _load();
  }

  final ProgressRepository _repo;
  final String _skillId;

  Future<void> _load() async {
    state = const AsyncLoading();
    try {
      final progress = await _repo.getProgress(_skillId);
      state = AsyncData(progress);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> initIfNeeded(String firstStageId) async {
    if (state.value != null) return;
    final progress = await _repo.initProgress(_skillId, firstStageId);
    state = AsyncData(progress);
  }

  Future<void> completeSession(PracticeSession session) async {
    final current = state.value;
    if (current == null) return;

    await _repo.saveSession(session);

    // Update streak
    final today = DateTime.now();
    final lastDate = current.lastPracticeDate;
    final isConsecutive = lastDate != null &&
        today.difference(lastDate).inDays <= 1 &&
        today.day != lastDate.day;
    final newStreak = isConsecutive ? current.practiceStreak + 1 : 1;

    // Update stage count
    final counts = Map<String, int>.from(current.stagePracticeCount);
    counts[session.stageId] = (counts[session.stageId] ?? 0) + 1;

    final updated = current.copyWith(
      totalSessions: current.totalSessions + 1,
      practiceStreak: newStreak,
      lastPracticeDate: today,
      stagePracticeCount: counts,
      bestHoldSeconds: session.bestHoldSeconds != null
          ? (current.bestHoldSeconds == null
              ? session.bestHoldSeconds
              : [current.bestHoldSeconds!, session.bestHoldSeconds!].reduce(
                  (a, b) => a > b ? a : b,
                ))
          : current.bestHoldSeconds,
    );

    await _repo.saveProgress(updated);
    state = AsyncData(updated);
  }

  Future<void> markStageComplete(String stageId, String nextStageId) async {
    final current = state.value;
    if (current == null) return;

    final completed = Set<String>.from(current.completedStageIds)..add(stageId);
    final updated = current.copyWith(
      completedStageIds: completed,
      currentStageId: nextStageId,
    );

    await _repo.saveProgress(updated);
    state = AsyncData(updated);
  }
}

final progressProvider =
    StateNotifierProvider.family<ProgressNotifier, AsyncValue<UserProgress?>, String>(
  (ref, skillId) => ProgressNotifier(ref.watch(progressRepositoryProvider), skillId),
);

final sessionsProvider = FutureProvider.family<List<PracticeSession>, String>(
  (ref, skillId) => ref.watch(progressRepositoryProvider).getSessions(skillId),
);
