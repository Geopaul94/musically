import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAudio extends ChangeNotifier {
  Duration? totalDuration = Duration.zero;
  Duration? position = Duration.zero;
  String? audioState = "Stopped";
  AudioPlayer audioPlayer = AudioPlayer();

  MyAudio() {
    initAudio();
  }

  initAudio() {
    audioPlayer.onDurationChanged.listen((updateDuration) {
      totalDuration = updateDuration;
      notifyListeners();
    });

    audioPlayer.onPositionChanged.listen((updatedPosition) {
      position = updatedPosition;
      notifyListeners();
    });

    audioPlayer.onPlayerStateChanged.listen((playerState) {
      if (playerState == PlayerState.playing) {
        audioState = "Playing";
      } else if (playerState == PlayerState.paused) {
        audioState = "Paused";
      } else if (playerState == PlayerState.stopped) {
        audioState = "Stopped";
      }
      notifyListeners();
    });
  }

  void playAudio(String songUrl) {
    audioState = "Playing";
    audioPlayer.play(UrlSource(songUrl));
    notifyListeners();
  }

  void pauseAudio() {
    audioState = "Paused";
    audioPlayer.pause();
    notifyListeners();
  }

  void stopAudio() {
    audioState = "Stopped";
    audioPlayer.stop();
    notifyListeners();
  }
}



// class MyAudio extends ChangeNotifier {
//   Duration? totalDuration = Duration.zero;
//   Duration? position = Duration.zero;
//   String? audioState = "Stopped";
//   AudioPlayer audioPlayer = AudioPlayer();

//   MyAudio() {
//     initAudio();
//   }

//   initAudio() {
//     audioPlayer.onDurationChanged.listen((updateDuration) {
//       totalDuration = updateDuration;
//       notifyListeners();
//     });

//     audioPlayer.onPositionChanged.listen((updatedPosition) {
//       position = updatedPosition;
//       notifyListeners();
//     });

//     audioPlayer.onPlayerStateChanged.listen((playerState) {
//       if (playerState == PlayerState.playing) {
//         audioState = "Playing";
//       } else if (playerState == PlayerState.paused) {
//         audioState = "Paused";
//       }
//       notifyListeners();
//     });
//   }

//   void playAudio(String songUrl) {
//     audioState = "Playing";
//     audioPlayer.play(UrlSource(songUrl));
//     notifyListeners();
//   }

//   void pauseAudio() {
//     audioState = "Paused";
//     audioPlayer.pause();
//     notifyListeners();
//   }
// }
