// import 'dart:js';

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_log/pages/auth_page.dart';
// import 'package:flutter_log/pages/home_page.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleSignInHandler {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   Future<void> handleSignIn(BuildContext context) async {
//     try {
//       final GoogleSignInAccount? googleSignInAccount =
//           await _googleSignIn.signIn();
//       if (googleSignInAccount == null) {
//         // User canceled the sign-in
//         return;
//       }

//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );

//       final UserCredential authResult =
//           await _auth.signInWithCredential(credential);
//       final User? user = authResult.user;

//       print('Signed In: ${user?.displayName}');

//       // Navigate to the second screen after successful sign-in
//       // ignore: use_build_context_synchronously
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const HomePage(),
//         ),
//       );
//     } catch (error) {
//       print(error);
//     }
//   }
// }
