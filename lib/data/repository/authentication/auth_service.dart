import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:musically/data/models/user_data_model.dart';

import 'package:shared_preferences/shared_preferences.dart';



class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signup(UserModel usersdata) async {
    try {
      // Create a new user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: usersdata.email,
        password: usersdata.password,
      );

      // Add user information to Firestore
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(usersdata.toFirestore());

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase exceptions
      switch (e.code) {
        case 'weak-password':
          throw Exception('The password provided is too weak.');
        case 'email-already-in-use':
          throw Exception('The account already exists for that email.');
        default:
          throw Exception('An error occurred: ${e.message}');
      }
    } catch (e) {
      // Handle any other exceptions
      throw Exception('An error occurred: $e');
    }
  }

  // Future<UserCredential?> loginWithEmailAndPassword(
  //     String email, String password) async {
  //   try {
  //     final UserCredential userCredential =
  //         await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     return userCredential;
  //   } on FirebaseAuthException catch (e) {
  //     // Handle errors
  //     if (e.code == 'weak-password') {
  //       throw Exception('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       throw Exception('The account already exists for that email.');
  //     } else {
  //       throw Exception('An error occurred: ${e.message}');
  //     }
  //   } catch (e) {
  //     throw Exception('An error occurred: $e.to');
  //   }
  // }


Future<UserCredential?> loginWithEmailAndPassword(
    String email, String password) async {
  try {
    final UserCredential userCredential =
        await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  } on FirebaseAuthException catch (e) {
    // Handle specific Firebase errors
    switch (e.code) {
      case 'user-not-found':
        throw Exception('No user found for that email. Please check your email.');
      case 'wrong-password':
        throw Exception('Incorrect password. Please check your password.');
      case 'invalid-email':
        throw Exception('The email address is not valid. Please check your email.');
      case 'user-disabled':
        throw Exception('This user has been disabled. Please contact support.');
      default:
        throw Exception('An error occurred. Please try again later.');
    }
  } catch (e) {
    throw Exception('An unexpected error occurred: $e');
  }
}



  Future<void> signOut() async {
    try {
      await _auth.signOut();

      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setBool('isLoggedIn', false);

      // Optionally, you can show a message to the user

    
    } catch (e) {
            throw Exception('Error signing out: $e');
    }
  }

  Future<UserCredential?> loginWithGoogle() async {
    try {
      // Create a single instance of GoogleSignIn
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Attempt to sign in
      final GoogleSignInAccount? gUser = await googleSignIn.signIn();

      // Check if the user is null
      if (gUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Get the authentication details
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Check if gAuth is null
      if (gAuth.idToken == null || gAuth.accessToken == null) {
        // Handle the case where authentication tokens are null
        print("Authentication tokens are null");
        return null;
      }

      // Create a credential
      final cred = GoogleAuthProvider.credential(
        idToken: gAuth.idToken,
        accessToken: gAuth.accessToken,
      );

      // Sign in with the credential
      return await _auth.signInWithCredential(cred);
    } catch (e) {
      // Handle the error appropriately
      print("Error during Google sign-in: ${e.toString()}");
      return null;
    }
  }
}
