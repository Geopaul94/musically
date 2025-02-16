import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:musically/data/repository/song_upload.dart';
import 'dart:convert';
import 'package:path/path.dart' as path;

class AudioUrlUploadScreen extends StatefulWidget {
  @override
  _AudioUrlUploadScreenState createState() => _AudioUrlUploadScreenState();
}

class _AudioUrlUploadScreenState extends State<AudioUrlUploadScreen> {
  final TextEditingController _audioUrlController = TextEditingController();
  final SongsUpload _songsUpload = SongsUpload();

  Future<void> _uploadAudioFromUrl() async {
    String audioUrl = _audioUrlController.text.trim();

    // Step 1: Validate the URL format
    if (!_isValidAudioUrl(audioUrl)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid URL. Please provide an MP3 or WAV file.')),
      );
      return;
    }

    try {
      // Step 2: Directly upload the file to Cloudinary
      String? cloudinaryUrl = await _songsUpload.uploadAudioFromUrl(audioUrl);

      if (cloudinaryUrl != null) {
        // Step 3: Store the Cloudinary URL in Firestore
        await _songsUpload.saveAudioUrlToFirestore(cloudinaryUrl);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Audio uploaded successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload audio to Cloudinary.')),
        );
      }
    } catch (error) {
      print('Error uploading audio: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while uploading the audio.')),
      );
    }
  }

  bool _isValidAudioUrl(String url) {
    String extension = path.extension(url).toLowerCase();
    return extension == '.mp3' || extension == '.wav';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Audio from URL'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _audioUrlController,
              decoration: InputDecoration(
                labelText: 'Paste Audio URL (MP3 or WAV)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadAudioFromUrl,
              child: Text('Upload Audio'),
            ),
          ],
        ),
      ),
    );
  }
}











class SongsUpload {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to upload audio file directly from a URL to Cloudinary
  Future<String?> uploadAudioFromUrl(String audioUrl) async {
    try {
      // Cloudinary API endpoint
      final url =
          Uri.parse('https://api.cloudinary.com/v1_1/duyqxp4er/video/upload'); // Use 'video/upload' for audio files

      // Create a multipart request
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'vlbl4hxd' // Use your Cloudinary preset
        ..fields['file'] = audioUrl; // Pass the remote URL directly

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

  // Function to save the audio URL to Firestore
  Future<void> saveAudioUrlToFirestore(String audioUrl) async {
    CollectionReference songsRef =
        FirebaseFirestore.instance.collection('songs');
    try {
      await songsRef.add({
        'audioUrl': audioUrl,
        'uploadedAt': DateTime.now(),
      });
      print('Audio URL saved successfully to Firestore');
    } catch (error) {
      print('Failed to save audio URL to Firestore: $error');
    }
  }
}