import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String username;
  final String email;
  final String password;
  final String phonenumber;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.phonenumber,
  });

  // Factory constructor for creating a new UserModel instance from a Firestore document snapshot
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      username: data['username'] as String,
      email: data['email'] as String,
      password: data['password'] as String,
      phonenumber: data['phonenumber'] as String,
    );
  }

  // Convert a UserModel instance to a Firestore document map
  Map<String, dynamic> toFirestore() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'phonenumber': phonenumber,
    };
  }

  // You can add helper methods if needed
  UserModel copyWith({
    String? username,
    String? email,
    String? password,
    String? phonenumber,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      phonenumber: phonenumber ?? this.phonenumber,
    );
  }

  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, password: $password, phonenumber: $phonenumber)';
  }
}
