class Exercise {
  int exerciseId;
  String? muscleGroup;
  String? equipment;
  String? workoutGif;
  String? name;
  String? target;
  int sets;
  int reps;
  bool? isPressed;


  Exercise(
      this.exerciseId,
      this.muscleGroup,
      this.equipment,
      this.workoutGif,
      this.name,
      this.target,
      this.reps,
      this.sets,
      {bool? isPressed})
      : this.isPressed = isPressed ?? false;

}