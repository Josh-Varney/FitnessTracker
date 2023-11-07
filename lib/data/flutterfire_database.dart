import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  DatabaseService();

  Future<void> storeUserDetails(UserModel user, String uid) async {
    try {
      print(uid);
      await firestore.collection("UserDetails").doc(uid).set(user.toJson());
      print('User details stored successfully.');
    } catch (e) {
      print("Error storing user details: $e");
    }
  }

  // Gets data from the database
  Future<Map<String, dynamic>> getUserDetails(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await firestore.collection("UserDetails").doc(uid).get();

      if (documentSnapshot.exists) {
        // Return user details as a Map
        return documentSnapshot.data()!;
      } else {
        // Return an empty Map or handle the case when the document doesn't exist
        return {};
      }
    } catch (e) {
      print("Error retrieving user details: $e");
      // Handle errors by returning an empty Map or another default value
      return {};
    }
  }
}

class UserModel {
  final String? id;
  final String firstName;
  final String bio;
  final String age;
  final String weight;
  final String targetWeight;
  final String height;

  const UserModel({
    this.id,
    required this.firstName,
    required this.bio,
    required this.age,
    required this.weight,
    required this.targetWeight,
    required this.height,
  });

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "bio": bio,
      'age': age,
      "weight": weight,
      "targetWeight": targetWeight,
      'height': height,
    };
  }
}
