import 'package:flutter/material.dart';
import 'package:flutter_log/data/workout_data.dart';
import 'package:flutter_log/ui_components/exercise_tile.dart';
import 'package:provider/provider.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;
  const WorkoutPage({super.key, required this.workoutName});

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  get isCompleted => null; // CHANGE

  // CheckBox was Tapped
  void onCheckBoxChanged(String workoutName, String exerciseName) {
    // Obtains an instance of the WorkOutData
    Provider.of<WorkOutData>(context, listen: false)
        // Calls check off exercise
        .checkOffExercise(workoutName, exerciseName);
  }

  final exerciseNameController = TextEditingController();
  final weightController = TextEditingController();
  final repsController = TextEditingController();
  final setsController = TextEditingController();

  void createNewExercise() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('Add a New Exercise'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Exercise Name
              TextField(
                controller: exerciseNameController,
                decoration: const InputDecoration(hintText: 'Exercise Name:'),
              ),
              // Weight
              TextField(
                controller: weightController,
                decoration: const InputDecoration(hintText: 'Weight:'),
              ),
              // Reps
              TextField(
                  controller: repsController,
                  decoration: const InputDecoration(hintText: 'Reps:')),
              // Sets
              TextField(
                controller: setsController,
                decoration: const InputDecoration(hintText: 'Sets:'),
              ),
            ],
          ),
          actions: [
            // Save Button
            MaterialButton(
              onPressed: saveExercise,
              child: const Text("Save"),
            ),
            // Cancel Button
            MaterialButton(
              onPressed: cancelButton,
              child: const Text("Cancel"),
            )
          ]),
    );
  }

  // Save Exercise Button
  void saveExercise() {
    String newExerciseName = exerciseNameController.text;
    String weight = weightController.text;
    String reps = repsController.text;
    String sets = setsController.text;

    // Same name issue: Get All of the Workout Names, Iterate through them
    // Data type in input
    if (newExerciseName.isEmpty ||
        weight.isEmpty ||
        reps.isEmpty ||
        sets.isEmpty ||
        weight == '0' ||
        reps == '0') {
      if (newExerciseName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Enter a Exercise Name:')),
        );
        return;
      } else if (weight.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please Enter a Weight')));
      } else if (reps.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please Enter a Rep Count:')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please Enter a Set Count')));
      }
      return;
    }
    // Add Workout to Workout Data List
    Provider.of<WorkOutData>(context, listen: false).addExercise(
      widget.workoutName,
      newExerciseName,
      weight,
      reps,
      sets, // CHANGE
    );
    // Pop dialog

    Navigator.pop(context);
    clear();
  }

  // Delete Workout
  void cancelButton() {
    Navigator.pop(context);
    clear();
  }

  // Clear Controllers
  void clear() {
    exerciseNameController.clear();
    weightController.clear();
    repsController.clear();
    setsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkOutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(title: Text(widget.workoutName)),
        floatingActionButton: FloatingActionButton(
          onPressed: () => createNewExercise(),
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
            itemBuilder: (context, index) => ExerciseTile(
                  exerciseName: value
                      .getRelevantWorkout(widget.workoutName)
                      .exercises[index]
                      .name,
                  weight: value
                      .getRelevantWorkout(widget.workoutName)
                      .exercises[index]
                      .weight,
                  reps: value
                      .getRelevantWorkout(widget.workoutName)
                      .exercises[index]
                      .reps,
                  sets: value
                      .getRelevantWorkout(widget.workoutName)
                      .exercises[index]
                      .sets,
                  isCompleted: value
                      .getRelevantWorkout(widget.workoutName)
                      .exercises[index]
                      .isCompleted,
                  onCheckBoxChanged: (val) => onCheckBoxChanged(
                    widget.workoutName,
                    value
                        .getRelevantWorkout(widget.workoutName)
                        .exercises[index]
                        .name,
                  ),
                )),
      ),
    );
  }
}
