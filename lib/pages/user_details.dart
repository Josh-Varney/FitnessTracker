import 'package:flutter/material.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _desiredWeightController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.deepPurpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage(
                    'assets/logo_placeholder.png'), // Replace with your logo image
              ),
              const SizedBox(height: 32.0),
              const Text(
                'Welcome to your Local Fitness App!',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.deepPurple),
                        decoration: InputDecoration(
                          labelText: 'Your Name',
                          labelStyle: const TextStyle(color: Colors.deepPurple),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurple.withOpacity(0.7)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.deepPurple),
                        decoration: InputDecoration(
                          labelText: 'Your Gender',
                          labelStyle: const TextStyle(color: Colors.deepPurple),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurple.withOpacity(0.7)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: _phoneController,
                        style: const TextStyle(color: Colors.deepPurple),
                        decoration: InputDecoration(
                          labelText: 'Your Phone Number',
                          labelStyle: const TextStyle(color: Colors.deepPurple),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurple.withOpacity(0.7)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _weightController,
                        style: const TextStyle(color: Colors.deepPurple),
                        decoration: InputDecoration(
                          labelText: 'Your Current Weight (kg)',
                          labelStyle: const TextStyle(color: Colors.deepPurple),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurple.withOpacity(0.7)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: _desiredWeightController,
                        style: const TextStyle(color: Colors.deepPurple),
                        decoration: InputDecoration(
                          labelText: 'Your Desired Weight (kg)',
                          labelStyle: const TextStyle(color: Colors.deepPurple),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurple.withOpacity(0.7)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  // Handle button press, you can access input values using controllers
                  print('Name: ${_nameController.text}');
                  print('Email: ${_emailController.text}');
                  print('Phone Number: ${_phoneController.text}');
                  print('Weight: ${_weightController.text}');
                  print('Desired Weight: ${_desiredWeightController.text}');
                },
                child: const Text(
                  'Let\'s Get Fit!',
                  style: TextStyle(fontSize: 18.0),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
