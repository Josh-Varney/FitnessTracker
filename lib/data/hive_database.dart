import 'package:flutter_log/datetime/date_time.dart';
import 'package:flutter_log/models/exercise.dart';
import 'package:flutter_log/models/workout.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  // Reference hive box
  final _myBox = Hive.box("workout_db");

  // Is there data already stored, if not, record start date
  bool previousDataExists() {
    if (_myBox.isEmpty) {
      print('Previous Data Non-Existent');
      // Potential Extension with an upcoming HeatMap
      _myBox.put("START_DATE", todaysDateYYYYMMDD());
      return false;
    } else {
      print('Previous Data');
      return true;
    }
  }

  // Return start date as yyyymmdd
  String getStartDate() {
    return _myBox.get("START_DATE");
  }

  // Write Data
  void saveToDatabase(List<Workout> workouts) {
    final list_Workouts = convertObjectToWorkoutList(workouts);
    final list_Exercises = convertObjectToExerciseList(workouts);

    if (exerciseCompleted(workouts)) {
      _myBox.put("COMPLETION_STATUS_${todaysDateYYYYMMDD()}", 1);
    } else {
      _myBox.put("COMPLETION_STATUS_${todaysDateYYYYMMDD()}", 0);
    }

    // Save into Hive
    _myBox.put("WORKOUTS", list_Workouts);
    _myBox.put("EXERCISES", list_Exercises);
  }

  // Read Data, and return a list of workouts
  List<Workout> readFromDatabase() {
    List<Workout> mySavedWorkouts = [];

    List<String> workoutNames = _myBox.get("WORKOUTS");
    final exerciseDetails = _myBox.get("EXERCISES");

    // Workout Object Creation
    for (int i = 0; i < workoutNames.length; i++) {
      List<Exercise> exercisesInEachWorkout = [];
      // Workout has many exercises
      for (int j = 0; j < exerciseDetails[i].length; j++) {
        // Add each exercise to workout
        exercisesInEachWorkout.add(
          Exercise(
            name: exerciseDetails[i][j][0],
            weight: exerciseDetails[i][j][1],
            reps: exerciseDetails[i][j][2],
            sets: exerciseDetails[i][j][3],
            isCompleted:
                exerciseDetails[i][j][4] == "true" ? true : false, // BUG
          ),
        );
      }
      // Create individual workout
      Workout workout =
          Workout(name: workoutNames[i], exercises: exercisesInEachWorkout);

      // Add to overall list
      mySavedWorkouts.add(workout);
    }
  
    return mySavedWorkouts;
  }

  // Check if any exercises have been completed
  bool exerciseCompleted(List<Workout> workouts) {
    for (var workout in workouts) {
      for (var exercise in workout.exercises) {
        if (exercise.isCompleted) {
          return true;
        }
      }
    }
    return false;
  }

  // Return completion status of a given date yyyymmdd
  int getCompletionStatus(String yyyymmdd) {
    int completionStatus = _myBox.get("COMPLETION_STATUS$yyyymmdd") ?? 0;
    return completionStatus;
  }

  // Converts the exercises in a workout object into a list of strings
}

// Converts workout objects into a list
List<String> convertObjectToWorkoutList(List<Workout> workouts) {
  List<String> workoutList = [];

  for (int i = 0; i < workouts.length; i++) {
    workoutList.add(workouts[i].name);
  }

  return workoutList;
}

List<List<List<String>>> convertObjectToExerciseList(List<Workout> workouts) {
  List<List<List<String>>> exerciseList = [];

  for (int i = 0; i < workouts.length; i++) {
    // Exercise in Each Workout
    List<Exercise> exercisesInWorkout = workouts[i].exercises;
    // Embedded with Type of Workout and Exercises Associated
    List<List<String>> individualWorkout = [];
    // Loop through ExerciseList
    for (int j = 0; j < exercisesInWorkout.length; j++) {
      // Each Exercise
      List<String> individualExercise = [];
      // Adds each exercise into a list
      individualExercise.addAll(
        [
          exercisesInWorkout[j].name,
          exercisesInWorkout[j].weight,
          exercisesInWorkout[j].reps,
          exercisesInWorkout[j].sets,
          exercisesInWorkout[j].isCompleted.toString()
        ],
      );
      // create individual workout and give exercise
      individualWorkout.add(individualExercise);
    }
    // each individual workout to overall list
    exerciseList.add(individualWorkout);
  }
  return exerciseList;
}
