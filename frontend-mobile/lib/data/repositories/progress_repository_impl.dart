import '../../domain/entities/practice_session.dart';
import '../../domain/entities/user_progress.dart';
import '../../domain/repositories/progress_repository.dart';
import '../datasources/local/progress_local_datasource.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  ProgressRepositoryImpl(this._datasource);

  final ProgressLocalDatasource _datasource;

  @override
  Future<UserProgress?> getProgress(String skillId) => _datasource.getProgress(skillId);

  @override
  Future<void> saveProgress(UserProgress progress) => _datasource.saveProgress(progress);

  @override
  Future<void> saveSession(PracticeSession session) => _datasource.saveSession(session);

  @override
  Future<List<PracticeSession>> getSessions(String skillId) => _datasource.getSessions(skillId);

  @override
  Future<UserProgress> initProgress(String skillId, String firstStageId) async {
    final existing = await _datasource.getProgress(skillId);
    if (existing != null) return existing;

    final initial = UserProgress(
      skillId: skillId,
      currentStageId: firstStageId,
      completedStageIds: {},
      practiceStreak: 0,
      totalSessions: 0,
      stagePracticeCount: {},
    );
    await _datasource.saveProgress(initial);
    return initial;
  }
}
