import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/entities/practice_session.dart';
import '../../../domain/entities/user_progress.dart';
import '../../models/user_progress_model.dart';

class ProgressLocalDatasource {
  ProgressLocalDatasource(this._prefs);

  final SharedPreferences _prefs;

  static String _progressKey(String skillId) => 'progress_$skillId';
  static String _sessionsKey(String skillId) => 'sessions_$skillId';

  Future<UserProgress?> getProgress(String skillId) async {
    final raw = _prefs.getString(_progressKey(skillId));
    if (raw == null) return null;
    return UserProgressModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> saveProgress(UserProgress progress) async {
    final model = UserProgressModel.fromEntity(progress);
    await _prefs.setString(_progressKey(progress.skillId), jsonEncode(model.toJson()));
  }

  Future<void> saveSession(PracticeSession session) async {
    final existing = await _getRawSessions(session.skillId);
    existing.add(_sessionToJson(session));
    await _prefs.setString(_sessionsKey(session.skillId), jsonEncode(existing));
  }

  Future<List<PracticeSession>> getSessions(String skillId) async {
    final raw = await _getRawSessions(skillId);
    return raw.map((e) => _sessionFromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<dynamic>> _getRawSessions(String skillId) async {
    final raw = _prefs.getString(_sessionsKey(skillId));
    if (raw == null) return [];
    return jsonDecode(raw) as List<dynamic>;
  }

  Map<String, dynamic> _sessionToJson(PracticeSession s) => {
        'id': s.id,
        'skillId': s.skillId,
        'stageId': s.stageId,
        'date': s.date.toIso8601String(),
        'durationSeconds': s.durationSeconds,
        'completedDrillIds': s.completedDrillIds,
        'completed': s.completed,
        'bestHoldSeconds': s.bestHoldSeconds,
        'notes': s.notes,
      };

  PracticeSession _sessionFromJson(Map<String, dynamic> j) => PracticeSession(
        id: j['id'] as String,
        skillId: j['skillId'] as String,
        stageId: j['stageId'] as String,
        date: DateTime.parse(j['date'] as String),
        durationSeconds: j['durationSeconds'] as int,
        completedDrillIds: List<String>.from(j['completedDrillIds'] as List),
        completed: j['completed'] as bool,
        bestHoldSeconds: j['bestHoldSeconds'] as int?,
        notes: j['notes'] as String?,
      );
}
