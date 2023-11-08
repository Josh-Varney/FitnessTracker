import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_log/auth/googleSignIn.dart';
import 'package:flutter_log/data/workout_data.dart';
import 'package:flutter_log/pages/about_us_page.dart';
import 'package:flutter_log/pages/profile_page.dart';
import 'package:flutter_log/pages/work_out_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

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
      ),
    );
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

  Widget drawerItem(IconData icon, String title, VoidCallback onTap) {
    return Card(
      color: Colors.transparent.withOpacity(0),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkOutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Workout'),
          backgroundColor: Colors.deepPurple,
        ),
        drawer: Drawer(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.deepPurple],
              ),
            ),
            child: ListView(
              children: [
                DrawerHeader(
                  child: Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.purple[700],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'lib/fitnessImage/fitnessLogo.jpeg',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                ),
                drawerItem(Icons.person, 'Profile', () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                }),
                const Divider(color: Colors.white),
                drawerItem(Icons.info_outlined, 'About Us', () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AboutUsPage(),
                    ),
                  );
                }),
                const Divider(color: Colors.white),
                drawerItem(Icons.heat_pump, 'HeatMap', () {}),
                const Divider(color: Colors.white),
                drawerItem(Icons.logout, 'Log Out', () {
                  signUserOut();
                }),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewWorkout,
          backgroundColor: Colors.purple,
          child: const Icon(Icons.add),
        ),
        body: Container(
          color: Colors.grey[250],
          child: ListView.builder(
            itemCount: value.getWorkoutList().length < 15
                ? value.getWorkoutList().length
                : 10,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  title: Text(
                    value.getWorkoutList()[index].name,
                    style: const TextStyle(color: Colors.deepPurple),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () =>
                        goToWorkoutPage(value.getWorkoutList()[index].name),
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
