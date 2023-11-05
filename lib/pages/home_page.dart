import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_log/data/workout_data.dart';
import 'package:flutter_log/pages/about_us_page.dart';
import 'package:flutter_log/pages/profile_page.dart';
import 'package:flutter_log/pages/work_out_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Provider.of<WorkOutData>(context, listen: false).intialiseWorkoutList();
  }

  final user = FirebaseAuth.instance.currentUser!;

  // Sign User Out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // Text Controller
  final newWorkoutNameController = TextEditingController();

  // Create New Workout
  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Create New Workout"),
        content: TextField(
          controller: newWorkoutNameController,
        ),
        actions: [
          // Save Button
          MaterialButton(
            onPressed: saveWorkout,
            child: const Text("Save"),
          ),
          // Cancel Button
          MaterialButton(
            onPressed: cancelWorkout,
            child: const Text("Cancel"),
          )
        ],
      ),
    );
  }

  // Go to Workout Page
  void goToWorkoutPage(String workoutName) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutPage(
            workoutName: workoutName,
          ),
        ));
  }

  // Save Workout
  void saveWorkout() {
    String newWorkoutName = newWorkoutNameController.text;
    // Add Workout to Workout Data List
    Provider.of<WorkOutData>(context, listen: false).addWorkout(newWorkoutName);
    // Pop dialog

    Navigator.pop(context);
    clear();
  }

  // Delete Workout
  void cancelWorkout() {
    Navigator.pop(context);
    clear();
  }

  // Clear Controllers
  void clear() {
    newWorkoutNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkOutData>(
      builder: (context, value, child) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              //title: const Text('Workouts'),
              ),
          drawer: Drawer(
            child: Container(
              color: Colors.deepPurple[200],
              child: ListView(
                children: [
                  const DrawerHeader(
                      child: Center(
                    child: Text(
                      'L O G O',
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title:
                        const Text('Profile', style: TextStyle(fontSize: 20)),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ProfilePage())),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title:
                        const Text('About Us', style: TextStyle(fontSize: 20)),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AboutUsPage())),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title:
                        const Text('Workouts', style: TextStyle(fontSize: 20)),
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage())),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title:
                        const Text('Log Out', style: TextStyle(fontSize: 20)),
                    onTap: () => signUserOut(),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: createNewWorkout,
            child: const Icon(Icons.add),
          ),
          body: ListView.builder(
            itemCount: value.getWorkoutList().length < 15 // Limit size to 8
                ? value.getWorkoutList().length
                : 10,
            itemBuilder: (context, index) => ListTile(
              title: Text(value.getWorkoutList()[index].name),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () =>
                    goToWorkoutPage(value.getWorkoutList()[index].name),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
