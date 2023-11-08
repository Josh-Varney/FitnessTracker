import 'package:flutter/material.dart';
import 'package:flutter_log/data/hive_database.dart';
import 'package:flutter_log/models/exercise.dart';
import 'package:flutter_log/models/workout.dart';

class WorkOutData extends ChangeNotifier {
  // Contains list of different workouts

  final db = HiveDatabase();

  List<Workout> workoutList = [
    Workout(
      name: "Upper Body",
      exercises: [
        Exercise(
          name: "Bicep Curls",
          weight: "10",
          reps: "10",
          sets: "3",
          isCompleted: false, // CHANGE
        )
      ],
    ),
    Workout(
      name: "Lower Body",
      exercises: [
        Exercise(
          name: "Squats",
          weight: "10",
          reps: "10",
          sets: "3",
          isCompleted: false, // CHANGE
        )
      ],
    ),
  ];

  // Database Load up if previous DATA
  void intialiseWorkoutList() {
    if (db.previousDataExists()) {
      workoutList = db.readFromDatabase();
    } else {
      db.saveToDatabase(workoutList);
    }
  }

  // Get the list of different
  List<Workout> getWorkoutList() => workoutList;

  // Get the length of a given workout
  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  // Add a workout
  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));

    notifyListeners();

    print(workoutList); //Instances of Workouts in
    // Save to Workouts to DB
    db.saveToDatabase(workoutList);
  }

  // Add an Exercise to a workout
  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    //CHANFE
    // Find Relevelant Workout
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    relevantWorkout.exercises.add(Exercise(
        name: exerciseName,
        weight: weight,
        reps: reps,
        sets: sets,
        isCompleted: false)); //CHANGE

    print(relevantWorkout.exercises); // All Exercises in Workouts

    notifyListeners();

    // Save to Database
    db.saveToDatabase(workoutList);
  }

  // Check off Exercise
  void checkOffExercise(String workoutName, String exerciseName) {
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);
    // Check off boolean
    // Can check on and off
    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();

    // Save to DB
    db.saveToDatabase(workoutList);
  }
  // Get Length of a given workout

  Workout getRelevantWorkout(String workoutName) {
    Workout relevelantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);
    return relevelantWorkout;
  }

  // Return relevant excercise object, given a workout name and exercise name
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    // Find Relevant Workout
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    // Find Relevant Exercise
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);

    return relevantExercise;
  }
}
