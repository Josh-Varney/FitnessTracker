import 'package:flutter/material.dart';
import 'package:flutter_log/data/hive_database.dart';
import 'package:flutter_log/models/exercise.dart';
import 'package:flutter_log/models/workout.dart';

class WorkOutData extends ChangeNotifier {
  // Contains list of different workouts

  final dataBase = HiveDatabase();

  List<Workout> workoutObj = [
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
    if (dataBase.previousDataExists()) {
      workoutObj = dataBase.readFromDatabase();
    } else {
      dataBase.saveToDatabase(workoutObj);
    }
  }

  // Get the list of different
  List<Workout> getWorkoutList() => workoutObj;

  // Get the length of a given workout
  int numberOfExercisesInWorkout(String workoutName) {
    Workout currentWorkout = getRelevantWorkout(workoutName);
    return currentWorkout.exercises.length;
  }

  // Add a workout
  void addWorkout(String name) {
    workoutObj.add(Workout(name: name, exercises: []));

    notifyListeners();

    print(workoutObj); //Instances of Workouts in
    // Save to Workouts to DB
    dataBase.saveToDatabase(workoutObj);
  }

  // Add an Exercise to a workout
  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    //CHANFE
    // Find Relevelant Workout
    Workout currentWorkout = getRelevantWorkout(workoutName);

    currentWorkout.exercises.add(Exercise(
        name: exerciseName,
        weight: weight,
        reps: reps,
        sets: sets,
        isCompleted: false)); //CHANGE

    print(currentWorkout.exercises); // All Exercises in Workouts

    notifyListeners();

    // Save to Database
    dataBase.saveToDatabase(workoutObj);
  }

  // Check off Exercise
  void checkOffExercise(String workoutName, String exerciseName) {
    Exercise currentExercise = getRelevantExercise(workoutName, exerciseName);
    // Check off boolean
    // Can check on and off
    currentExercise.isCompleted = !currentExercise.isCompleted;

    notifyListeners();

    // Save to DB
    dataBase.saveToDatabase(workoutObj);
  }
  // Get Length of a given workout

  Workout getRelevantWorkout(String workoutName) {
    Workout currentWorkout =
        workoutObj.firstWhere((workout) => workout.name == workoutName);
    return currentWorkout;
  }

  // Return relevant excercise object, given a workout name and exercise name
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    // Find Relevant Workout
    Workout currentWorkout = getRelevantWorkout(workoutName);

    // Find Relevant Exercise
    Exercise relevantExercise = currentWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);

    return relevantExercise;
  }
}
