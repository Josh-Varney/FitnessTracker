import 'package:flutter/material.dart';
import 'package:flutter_log/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_log/data/workout_data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("workout_db");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (content) => WorkOutData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AuthPage(),
        theme: ThemeData(primarySwatch: Colors.deepPurple),
      ),
    );
  }
}
