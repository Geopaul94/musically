// audio_picker_service.dart
// audio_picker_service.dart
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AudioPickerService with ChangeNotifier {
  String? _audioFileName;
  String? _audioFilePath;

  String? get audioFileName => _audioFileName;
  String? get audioFilePath => _audioFilePath; // Expose the file path

  // Return the path of the selected audio file
  Future<String?> pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio, // Only pick audio files
    );

    if (result != null && result.files.isNotEmpty) {
      // Update the audio file name and path
      _audioFileName = result.files.first.name; // Get the file name
      _audioFilePath = result.files.first.path; // Get the file path
      notifyListeners(); // Notify listeners to update the UI
      return _audioFilePath; // Return the file path
    } else {
      _audioFileName = null;
      _audioFilePath = null; // User canceled the picker
      notifyListeners(); // Notify listeners to update the UI
      return null; // Return null if no file is picked
    }
  }
}
