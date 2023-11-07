import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_log/data/flutterfire_database.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // Error Check and Change Physical Properties, Store in Database
  final nameController = TextEditingController();
  final bioContoller = TextEditingController();
  final weightController = TextEditingController();
  final heightControler = TextEditingController();
  final desiredWeightController = TextEditingController();

  // Actual Text Controllers
  final actualName = TextEditingController();
  final actualBio = TextEditingController();
  final actualWeight = TextEditingController();
  final actualHeight = TextEditingController();
  final actualDesiredWeight = TextEditingController();
  final actualProteinController = TextEditingController();
  final actualCalController = TextEditingController();
  final actualBMIController = TextEditingController();
  final actualRecommendedExerciseController = TextEditingController();

  // Grabbing States
  Future<void> loadUserDetails() async {
    String uid = await getCurrentUserUID();

    if (uid.isNotEmpty) {
      // Use the DatabaseService to get user details
      Map<String, dynamic> userDetails =
          await DatabaseService().getUserDetails(uid);

      setState(() {
        // CHANGES THE STATES ON THE SCREEN
        actualName.text = userDetails['firstName'] ?? '';
        actualBio.text = userDetails['bio'] ?? '';
        actualWeight.text = userDetails['weight'] ?? '';
        actualHeight.text = userDetails['height'] ?? '';
        actualDesiredWeight.text = userDetails['targetWeight'] ?? '';

        // SORT BMI, CALORIES, PROTEIN, HEIGHT, AGE, GENDER
      });
    }
  }

  void addUserDetails() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Profile"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Enter your Name",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bioContoller,
              decoration: const InputDecoration(
                hintText: "Add a Bio",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: heightControler,
              decoration: const InputDecoration(
                hintText: "Enter your Height",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(
                hintText: "Enter your Current Weight",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: desiredWeightController,
              decoration: const InputDecoration(
                hintText: "Enter your Desired Weight",
              ),
            ),
          ],
        ),
        actions: [
          // Save Button
          MaterialButton(
            onPressed: saveProfileDetails,
            child: const Text("Save"),
          ),
          // Cancel Button
          MaterialButton(
            onPressed: cancelButton,
            child: const Text("Cancel"),
          )
        ],
      ),
    );
  }

  Future<String> getCurrentUserUID() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      User? user = _auth.currentUser;

      if (user != null) {
        return user.uid;
      } else {
        return ''; // You may want to handle the case when there is no user
      }
    } catch (e) {
      print('Error: $e');
      return ''; // Handle errors by returning an empty string or another default value
    }
  }

// Query to Retrieve The Data

  Future<void> saveProfile() async {
    String newName = nameController.text;
    String newBio = bioContoller.text;
    String newHeight = heightControler.text;
    String newWeight = weightController.text;
    String newDesiredWeight = desiredWeightController.text;

    // Get UID using await
    String uid = await getCurrentUserUID();

    DatabaseService databaseService = DatabaseService();

    UserModel updateUserDetails = UserModel(
      firstName: newName,
      bio: newBio,
      weight: newWeight,
      targetWeight: newDesiredWeight,
      height: newHeight,
    );

    await databaseService.storeUserDetails(updateUserDetails, uid);

    Navigator.pop(context);
    clear();
  }

  void saveProfileDetails() {
    saveProfile();
    Navigator.pop(context);
    clear();
  }

  void cancelButton() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    nameController.clear();
    bioContoller.clear();
    weightController.clear();
    desiredWeightController.clear();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    actualName.text = 'Name'; // Initial Text States
    actualBio.text = 'Enter A Bio';
    actualWeight.text = 'Unknown';
    actualDesiredWeight.text = 'Unknown';
    actualBMIController.text = 'Unknown';
    actualCalController.text = 'Unknown';
    actualProteinController.text = 'Unknown';
    actualRecommendedExerciseController.text = 'Running';
    loadUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.28,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple[800]!, Colors.purple[500]!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    ScaleTransition(
                      scale: _animation,
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('lib/fitnessImage/fitnessLogo.jpeg'),
                        backgroundColor: Colors
                            .white, // Add a background color for a circle avatar
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      actualName.text,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      actualBio.text,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                elevation: 25,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      const Text(
                        'User Information:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      buildUserDetail(
                          'Weight', actualWeight, Icons.fitness_center),
                      buildUserDetail(
                          'BMI', actualBMIController, Icons.accessibility),
                      buildUserDetail('Calories Required', actualCalController,
                          Icons.local_fire_department),
                      buildUserDetail('Protein Required',
                          actualProteinController, Icons.restaurant),
                      buildUserDetail('Desired Weight', actualDesiredWeight,
                          Icons.fitbit_outlined),
                      buildUserDetail(
                          'Recommended Exercise',
                          actualRecommendedExerciseController,
                          Icons.directions_run),
                      const SizedBox(height: 30),
                      const Text(
                        'Heat Map: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the Heat Map page
                          Navigator.pushNamed(context, '/heatmap');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple[800],
                          foregroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: const Text('View Heat Map'),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addUserDetails,
        backgroundColor: Colors.purple,
        elevation: 5,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildUserDetail(
      String title, TextEditingController controller, IconData icon) {
    // Bug, need to change text editing controller within this
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.purple[800]),
          const SizedBox(width: 10),
          Text(
            '$title: ${controller.text}',
            style: const TextStyle(fontSize: 16, color: Colors.purple),
          ),
        ],
      ),
    );
  }

  Widget buildInfoColumn(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple[800],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.purple),
          ),
          const SizedBox(height: 5),
          Icon(
            icon,
            color: Colors.purple[500],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
