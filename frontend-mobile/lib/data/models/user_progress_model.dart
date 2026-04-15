import '../../domain/entities/user_progress.dart';

class UserProgressModel extends UserProgress {
  const UserProgressModel({
    required super.skillId,
    required super.currentStageId,
    required super.completedStageIds,
    required super.practiceStreak,
    required super.totalSessions,
    required super.stagePracticeCount,
    super.lastPracticeDate,
    super.bestHoldSeconds,
  });

  factory UserProgressModel.fromJson(Map<String, dynamic> json) {
    return UserProgressModel(
      skillId: json['skillId'] as String,
      currentStageId: json['currentStageId'] as String,
      completedStageIds: Set<String>.from(json['completedStageIds'] as List),
      practiceStreak: json['practiceStreak'] as int,
      totalSessions: json['totalSessions'] as int,
      stagePracticeCount: Map<String, int>.from(json['stagePracticeCount'] as Map),
      lastPracticeDate: json['lastPracticeDate'] != null
          ? DateTime.parse(json['lastPracticeDate'] as String)
          : null,
      bestHoldSeconds: json['bestHoldSeconds'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'skillId': skillId,
      'currentStageId': currentStageId,
      'completedStageIds': completedStageIds.toList(),
      'practiceStreak': practiceStreak,
      'totalSessions': totalSessions,
      'stagePracticeCount': stagePracticeCount,
      'lastPracticeDate': lastPracticeDate?.toIso8601String(),
      'bestHoldSeconds': bestHoldSeconds,
    };
  }

  factory UserProgressModel.fromEntity(UserProgress progress) {
    return UserProgressModel(
      skillId: progress.skillId,
      currentStageId: progress.currentStageId,
      completedStageIds: progress.completedStageIds,
      practiceStreak: progress.practiceStreak,
      totalSessions: progress.totalSessions,
      stagePracticeCount: progress.stagePracticeCount,
      lastPracticeDate: progress.lastPracticeDate,
      bestHoldSeconds: progress.bestHoldSeconds,
    );
  }
}
