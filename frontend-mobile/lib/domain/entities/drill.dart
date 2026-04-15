class Drill {
  const Drill({
    required this.id,
    required this.name,
    required this.description,
    required this.steps,
    required this.sets,
    required this.reps,
    this.tip,
    this.durationSeconds,
  });

  final String id;
  final String name;
  final String description;
  final List<String> steps;
  final String sets;
  final String reps;
  final String? tip;
  final int? durationSeconds; // for timed holds — null means rep-based
}
