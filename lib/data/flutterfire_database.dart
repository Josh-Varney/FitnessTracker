import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final firestore = FirebaseFirestore.instance;

  Future<void> storeUserDetails(UserModel user) async {
    await firestore.collection("UserDetails").add(user.toJson());
  }
}

class UserModel {
  final String? id;
  final String firstName;
  final String phoneNo;
  final String weight;
  final String targetWeight;
  final String height;

  const UserModel({
    this.id,
    required this.firstName,
    required this.phoneNo,
    required this.weight,
    required this.targetWeight,
    required this.height,
  });

  Map<String, dynamic> toJson() {
    return {
      "First Name": firstName,
      "Phone Number": phoneNo,
      "Weight": weight,
      "Target Weight": targetWeight,
      'Height': height,
    };
  }
}
