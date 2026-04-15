class PracticeSession {
  const PracticeSession({
    required this.id,
    required this.skillId,
    required this.stageId,
    required this.date,
    required this.durationSeconds,
    required this.completedDrillIds,
    required this.completed,
    this.bestHoldSeconds,
    this.notes,
  });

  final String id;
  final String skillId;
  final String stageId;
  final DateTime date;
  final int durationSeconds;
  final List<String> completedDrillIds;
  final bool completed;
  final int? bestHoldSeconds;
  final String? notes;
}
