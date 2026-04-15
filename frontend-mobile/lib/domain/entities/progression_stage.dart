import 'drill.dart';

class ProgressionStage {
  const ProgressionStage({
    required this.id,
    required this.skillId,
    required this.order,
    required this.name,
    required this.description,
    required this.goal,
    required this.drills,
    required this.successCriteria,
    required this.commonMistakes,
    this.holdDurationSeconds,
  });

  final String id;
  final String skillId;
  final int order; // 1-indexed display order
  final String name;
  final String description;
  final String goal;
  final List<Drill> drills;
  final String successCriteria;
  final List<String> commonMistakes;
  final int? holdDurationSeconds; // target hold for timed stages
}
