import '../entities/user_progress.dart';
import '../entities/practice_session.dart';

abstract class ProgressRepository {
  Future<UserProgress?> getProgress(String skillId);
  Future<void> saveProgress(UserProgress progress);
  Future<void> saveSession(PracticeSession session);
  Future<List<PracticeSession>> getSessions(String skillId);
  Future<UserProgress> initProgress(String skillId, String firstStageId);
}
