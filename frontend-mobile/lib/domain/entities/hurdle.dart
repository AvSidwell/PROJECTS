import 'drill.dart';

class Hurdle {
  const Hurdle({
    required this.id,
    required this.skillId,
    required this.title,
    required this.description,
    required this.causes,
    required this.fixes,
    required this.correctiveExercises,
  });

  final String id;
  final String skillId;
  final String title;
  final String description;
  final List<String> causes;
  final List<String> fixes;
  final List<Drill> correctiveExercises;
}
