import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String username;
  final String email;
  final String password;
  final String phonenumber;
  final String? userId;

  UserModel({
    this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.phonenumber,
  });

  // Factory constructor for creating a new UserModel instance from a Firestore document snapshot
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      userId: doc.id, // Extract userId from document ID
      username: data['username'] as String,
      email: data['email'] as String,
      password: data['password'] as String,
      phonenumber: data['phonenumber'] as String,
    );
  }

  // Convert a UserModel instance to a Firestore document map
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId, // Include userId in Firestore map if needed
      'username': username,
      'email': email,
      'password': password,
      'phonenumber': phonenumber,
    };
  }
}
