class Exercise {
  final String name;
  final String weight;
  final String reps;
  final String sets;
  late bool isCompleted = false;

  Exercise({
    required this.name,
    required this.weight,
    required this.reps,
    required this.sets,
    required bool isCompleted, // CHANGE
  });
}
