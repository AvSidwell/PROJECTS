import 'progression_stage.dart';
import 'hurdle.dart';

enum SkillDifficulty { beginner, intermediate, advanced }

enum SkillStatus { available, comingSoon }

class Skill {
  const Skill({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.description,
    required this.whyItsHard,
    required this.difficulty,
    required this.prerequisites,
    required this.stages,
    required this.hurdles,
    required this.tags,
    this.status = SkillStatus.available,
  });

  final String id;
  final String name;
  final String subtitle;
  final String description;
  final String whyItsHard;
  final SkillDifficulty difficulty;
  final List<String> prerequisites; // human-readable strings
  final List<ProgressionStage> stages;
  final List<Hurdle> hurdles;
  final List<String> tags;
  final SkillStatus status;

  String get difficultyLabel {
    switch (difficulty) {
      case SkillDifficulty.beginner:
        return 'Beginner';
      case SkillDifficulty.intermediate:
        return 'Intermediate';
      case SkillDifficulty.advanced:
        return 'Advanced';
    }
  }
}
