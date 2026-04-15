class UserProgress {
  const UserProgress({
    required this.skillId,
    required this.currentStageId,
    required this.completedStageIds,
    required this.practiceStreak,
    required this.totalSessions,
    required this.stagePracticeCount,
    this.lastPracticeDate,
    this.bestHoldSeconds,
  });

  final String skillId;
  final String currentStageId;
  final Set<String> completedStageIds;
  final int practiceStreak;
  final int totalSessions;
  final Map<String, int> stagePracticeCount; // stageId -> session count
  final DateTime? lastPracticeDate;
  final int? bestHoldSeconds;

  bool isStageCompleted(String stageId) => completedStageIds.contains(stageId);

  bool isStageUnlocked(String stageId, List<String> allStageIdsInOrder) {
    final index = allStageIdsInOrder.indexOf(stageId);
    if (index == 0) return true;
    return completedStageIds.contains(allStageIdsInOrder[index - 1]);
  }

  double get progressFraction {
    if (stagePracticeCount.isEmpty) return 0;
    return completedStageIds.length / stagePracticeCount.length.clamp(1, double.infinity);
  }

  UserProgress copyWith({
    String? currentStageId,
    Set<String>? completedStageIds,
    int? practiceStreak,
    int? totalSessions,
    Map<String, int>? stagePracticeCount,
    DateTime? lastPracticeDate,
    int? bestHoldSeconds,
  }) {
    return UserProgress(
      skillId: skillId,
      currentStageId: currentStageId ?? this.currentStageId,
      completedStageIds: completedStageIds ?? this.completedStageIds,
      practiceStreak: practiceStreak ?? this.practiceStreak,
      totalSessions: totalSessions ?? this.totalSessions,
      stagePracticeCount: stagePracticeCount ?? this.stagePracticeCount,
      lastPracticeDate: lastPracticeDate ?? this.lastPracticeDate,
      bestHoldSeconds: bestHoldSeconds ?? this.bestHoldSeconds,
    );
  }
}
