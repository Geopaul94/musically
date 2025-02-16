import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';

import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:musically/data/models/songs/song_model.dart';
import 'package:musically/main.dart';

// class SongsUpload {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> uploadSongs(SongsModel song) async {
//     try {
//       String? userId = getCurrentUserId();

//       String imagePath = song.imagepath;

//       String? imageUrl = await uploadImageToCloudinary(imagePath);
//       CollectionReference songsCollection =
//           FirebaseFirestore.instance.collection('songs');

//       // Generate a document ID (can be custom or automatically generated)
//       DocumentReference docRef =
//           songsCollection.doc(); // Auto-generates a document ID

//       // Check if image upload was successful
//       if (imageUrl != null) {
//         // Step 2: Create a new SongsModel with the image URL
//         SongsModel updatedSong = SongsModel(
//           songname: song.songname,
//           artistname: song.artistname,
//           audiopath: song
//               .audiopath, // The local path to the audio file can remain the same for now
//           imagepath: imageUrl, // Replace local image path with Cloudinary URL
//           createdAt: song.createdAt,
//           userId: userId,
//           documentId: docRef.id, // Optional
//         );

//         // Step 3: Save the updated song to Firestore
//         await saveSongsToFirestore(updatedSong);

//         print('Song with image saved successfully!');
//       } else {
//         print('Failed to upload image to Cloudinary');
//       }
//     } catch (error) {
//       print('Error uploading song with image: $error');
//     }
//   }

// // Function to save song details to Firestore
//   Future<void> saveSongsToFirestore(SongsModel song) async {
//     // Get a reference to the Firestore collection
//     CollectionReference songsRef =
//         FirebaseFirestore.instance.collection('songs');

//     try {
//       // Add the song data to Firestore
//       await songsRef.add(song.toFirestore());
//       print('Song added successfully to Firestore');
//     } catch (error) {
//       print('Failed to add song to Firestore: $error');
//     }
//   }

// // Function to upload image to Cloudinary
//   Future<String?> uploadImageToCloudinary(String imagePath) async {
//     File file = File(imagePath);

//     try {
//       // Cloudinary API endpoint
//       final url =
//           Uri.parse('https://api.cloudinary.com/v1_1/duyqxp4er/image/upload');

//       // Create a multipart request
//       final request = http.MultipartRequest('POST', url)
//         ..fields['upload_preset'] = 'vlbl4hxd' // Use your Cloudinary preset
//         ..files.add(await http.MultipartFile.fromPath('file', file.path));

//       // Send the request
//       final response = await request.send();

//       // Check if the upload is successful
//       if (response.statusCode == 200) {
//         final res = await http.Response.fromStream(response);
//         final jsonMap = jsonDecode(res.body);

//         // Get the URL of the uploaded image from Cloudinary
//         String imageUrl = jsonMap['secure_url'];
//         return imageUrl;
//       }

//       if (response.statusCode != 200) {
//         final res = await http.Response.fromStream(response);
//         print(
//             'Failed to upload image to Cloudinary. Status Code: ${response.statusCode}, Response: ${res.body}');
//         return null;
//       } else {
//         print(
//             'Failed to upload image to Cloudinary. Status Code: ${response.statusCode}');
//         return null;
//       }
//     } catch (e) {
//       print('Error uploading image to Cloudinary: $e');
//       return null;
//     }
//   }
// }




class SongsUpload {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadSongs(SongsModel song) async {
    try {
      String? userId = getCurrentUserId();
      String imagePath = song.imagepath;
      String audioPath = song.audiopath;

      // Step 1: Upload the image to Cloudinary
      String? imageUrl = await uploadImageToCloudinary(imagePath);

      // Step 2: Upload the audio file to Cloudinary
      String? audioUrl = await uploadAudioToCloudinary(audioPath);

      // Step 3: Check if both uploads were successful
      if (imageUrl != null && audioUrl != null) {
        CollectionReference songsCollection =
            FirebaseFirestore.instance.collection('songs');

        // Generate a document ID (can be custom or automatically generated)
        DocumentReference docRef =
            songsCollection.doc(); // Auto-generates a document ID

        // Step 4: Create a new SongsModel with the image and audio URLs
        SongsModel updatedSong = SongsModel(
          songname: song.songname,
          artistname: song.artistname,
          audiopath: audioUrl,
          imagepath: imageUrl, 
          createdAt: song.createdAt,
          userId: userId,
          documentId: docRef.id, 
        );

        await saveSongsToFirestore(updatedSong);
        print('Song with image and audio saved successfully!');
      } else {
        print('Failed to upload image or audio to Cloudinary');
      }
    } catch (error) {
      print('Error uploading song with image and audio: $error');
    }
  }

  // Function to save song details to Firestore
  Future<void> saveSongsToFirestore(SongsModel song) async {
    // Get a reference to the Firestore collection
    CollectionReference songsRef =
        FirebaseFirestore.instance.collection('songs');
    try {
      // Add the song data to Firestore
      await songsRef.add(song.toFirestore());
      print('Song added successfully to Firestore');
    } catch (error) {
      print('Failed to add song to Firestore: $error');
    }
  }

  // Function to upload image to Cloudinary
  Future<String?> uploadImageToCloudinary(String imagePath) async {
    File file = File(imagePath);
    try {
      // Cloudinary API endpoint
      final url =
          Uri.parse('https://api.cloudinary.com/v1_1/duyqxp4er/image/upload');
      // Create a multipart request
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'vlbl4hxd' // Use your Cloudinary preset
        ..files.add(await http.MultipartFile.fromPath('file', file.path));
      // Send the request
      final response = await request.send();
      // Check if the upload is successful
      if (response.statusCode == 200) {
        final res = await http.Response.fromStream(response);
        final jsonMap = jsonDecode(res.body);
        // Get the URL of the uploaded image from Cloudinary
        String imageUrl = jsonMap['secure_url'];
        return imageUrl;
      } else {
        final res = await http.Response.fromStream(response);
        print(
            'Failed to upload image to Cloudinary. Status Code: ${response.statusCode}, Response: ${res.body}');
        return null;
      }
    } catch (e) {
      print('Error uploading image to Cloudinary: $e');
      return null;
    }
  }

  // Function to upload audio to Cloudinary
  Future<String?> uploadAudioToCloudinary(String audioPath) async {
    File file = File(audioPath);
    try {
      // Cloudinary API endpoint
      final url =
          Uri.parse('https://api.cloudinary.com/v1_1/duyqxp4er/video/upload'); // Use 'video/upload' for audio files
      // Create a multipart request
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'vlbl4hxd' // Use your Cloudinary preset
        ..files.add(await http.MultipartFile.fromPath('file', file.path));
      // Send the request
      final response = await request.send();
      // Check if the upload is successful
      if (response.statusCode == 200) {
        final res = await http.Response.fromStream(response);
        final jsonMap = jsonDecode(res.body);
        // Get the URL of the uploaded audio from Cloudinary
        String audioUrl = jsonMap['secure_url'];
        return audioUrl;
      } else {
        final res = await http.Response.fromStream(response);
        print(
            'Failed to upload audio to Cloudinary. Status Code: ${response.statusCode}, Response: ${res.body}');
        return null;
      }
    } catch (e) {
      print('Error uploading audio to Cloudinary: $e');
      return null;
    }
  }
}