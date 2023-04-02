class Exercise {
  int exerciseId;
  String? muscleGroup;
  String? equipment;
  String? workoutGif;
  String? name;
  String? target;
  int sets;
  int reps;
  DateTime date;

  Exercise(
      this.exerciseId,
      this.muscleGroup,
      this.equipment,
      this.workoutGif,
      this.name,
      this.target,
      this.reps,
      this.sets,
      {DateTime? date})
      : date = date ?? DateTime.now();
}