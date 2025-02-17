// // import 'package:audioplayers/audioplayers.dart';
// // import 'package:flutter/material.dart';
// // import 'package:musically/data/models/songs/songS_ample.dart';

// // class Playlistprovider extends ChangeNotifier {
// //   final List<SongsAmple> _playlist = [
// //     SongsAmple(
// //       songname: 'aksfaskl',
// //       artistname: 'yesudas',
// //       songimage: 'assets/images/1.jpg',
// //       songpath: 'assets/music/lacore-diamond-reach-you-110784.mp3',
// //     ),
// //     SongsAmple(
// //       songname: 'odadafs',
// //       artistname: 'yesudas',
// //       songimage: 'assets/images/3.jpg',
// //       songpath: 'assets/music/lacore-diamond-reach-you-110784.mp3',
// //     ),
// //     SongsAmple(
// //       songname: 'Never give up',
// //       artistname: 'flutter dev',
// //       songimage: 'assets/images/2.jpg',
// //       songpath: 'assets/music/lacore-diamond-reach-you-110784.mp3',
// //     ),
// //   ];

// //   int? _currentsongIndex;

// //   final AudioPlayer _audiopalyer = AudioPlayer();

// //   Duration _currentDuration = Duration.zero;
// //   Duration _totoalDuration = Duration.zero;

// //   bool _isplaying = false;

// //   Playlistprovider() {
// //     listenToDuration();
// //   }

// //   // void play() async {
// //   //   final String path = _playlist[_currentsongIndex!].songpath;

// //   //   await _audiopalyer.stop();
// //   //   await _audiopalyer.play(AssetSource(path)); // Use the correct path

// //   //   _isplaying = true;
// //   //   notifyListeners();
// //   // }

// // //   void play() async {
// // //   final String path = _playlist[_currentsongIndex!].songpath;
// // //   await _audiopalyer.stop();
// // //   await _audiopalyer.play(AssetSource(path)); // Ensure the path is correct
// // //   _isplaying = true;
// // //   notifyListeners();
// // // }

// //   void pause() async {
// //     await _audiopalyer.pause();
// //     _isplaying = false;
// //     notifyListeners();
// //   }

// //   void resume() async {
// //     await _audiopalyer.resume();
// //     _isplaying = true;
// //     notifyListeners();
// //   }

// //   void pauseOrResume() async {
// //     if (_isplaying) {
// //       pause();
// //     } else {
// //       resume();
// //     }
// //     notifyListeners();
// //   }

// //   void seek(Duration position) async {
// //     await _audiopalyer.seek(position);
// //   }

// //   void playNextSong() {
// //     if (_currentsongIndex != null) {
// //       if (_currentsongIndex! < _playlist.length - 1) {
// //         currentsongIndex = _currentsongIndex! + 1;
// //       } else {
// //         currentsongIndex = 0;
// //       }
// //     }
// //   }

// //   void playPreviousSong() async {
// //     if (_currentDuration.inSeconds > 2) {
// //       await (Duration.zero); // Restart the song
// //     } else {
// //       if (_currentsongIndex! > 0) {
// //         currentsongIndex = _currentsongIndex! - 1;
// //       } else {
// //         currentsongIndex = _playlist.length - 1; 
// //       }
// //     }
// //   }

// //   void listenToDuration() {
// //     _audiopalyer.onDurationChanged.listen((newDuration) {
// //       _totoalDuration = newDuration;
// //       notifyListeners();
// //     });

// //     _audiopalyer.onPositionChanged.listen((newPosition) {
// //       _currentDuration = newPosition;
// //       notifyListeners();
// //     });

// //     _audiopalyer.onPlayerComplete.listen((event) {
// //       playNextSong();
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _audiopalyer.dispose();
// //     super.dispose();
// //   }

// //   List<SongsAmple> get playlist => _playlist;
// //   int? get currentsongIndex => _currentsongIndex;
// //   bool get isPlaying => _isplaying;

// //   Duration get currentDuration => _currentDuration;
// //   Duration get totalDuration => _totoalDuration;

// //   set currentsongIndex(int? newIndex) {
// //     _currentsongIndex = newIndex;

// //     if (newIndex != null) {
// //       //  play();
// //     }

// //     notifyListeners();
// //   }
// // }




// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:musically/data/models/songs/song_model.dart';
// import 'package:musically/data/repository/fetchsongs.dart';
// import 'package:musically/presentation/screeens/splash_screen.dart';









// // class PlaylistProvider extends ChangeNotifier {
// //   List<SongsModel> _playlist = [];
// //   int? _currentSongIndex;
// //   final AudioPlayer _audioPlayer = AudioPlayer();

// //   Duration _currentDuration = Duration.zero;
// //   Duration _totalDuration = Duration.zero;

// //   bool _isPlaying = false;
// //   bool _isLoading = false; // Loading state added

// //   PlaylistProvider() {
// //     listenToDuration();
// //     fetchSongsFromFirebase(); // Fetch songs when the provider is initialized
// //   }

// // void fetchSongsFromFirebase() async {
// //   _isLoading = true; // Set loading to true
// //   // Defer the update of the UI until the next frame, after the build is done
// //   WidgetsBinding.instance.addPostFrameCallback((_) {
// //     notifyListeners();
// //   });

// //   try {
// //     String userId = currentUserId.toString();
// //     print("user id   =========   ${userId}");

// //     FetchSongs fetchSongs = FetchSongs();
// //     _playlist = await fetchSongs.getUserSongs(userId);
// //   } catch (e) {
// //     print("Error fetching songs: $e");
// //   } finally {
// //     _isLoading = false; // Set loading to false after fetching

// //     // Again, defer the update of the UI to avoid modifying the state during the build
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       notifyListeners();
// //     });
// //   }
// // }


// //   void play() async {
// //     if (_currentSongIndex != null) {
// //       final String path = _playlist[_currentSongIndex!].audiopath;
// //       await _audioPlayer.stop();
// //       await _audioPlayer.play(UrlSource(path)); // Use UrlSource for Firebase storage paths
// //       _isPlaying = true;
// //       notifyListeners();
// //     }
// //   }

// //   void pause() async {
// //     await _audioPlayer.pause();
// //     _isPlaying = false;
// //     notifyListeners();
// //   }

// //   void resume() async {
// //     await _audioPlayer.resume();
// //     _isPlaying = true;
// //     notifyListeners();
// //   }

// //   void pauseOrResume() async {
// //     if (_isPlaying) {
// //       pause();
// //     } else {
// //       resume();
// //     }
// //   }

// //   void seek(Duration position) async {
// //     await _audioPlayer.seek(position);
// //   }

// //   void playNextSong() {
// //     if (_currentSongIndex != null) {
// //       if (_currentSongIndex! < _playlist.length - 1) {
// //         currentSongIndex = _currentSongIndex! + 1;
// //       } else {
// //         currentSongIndex = 0;
// //       }
// //     }
// //   }

// //   void playPreviousSong() async {
// //     if (_currentDuration.inSeconds > 2) {
// //       await _audioPlayer.seek(Duration.zero); // Restart the song
// //     } else {
// //       if (_currentSongIndex! > 0) {
// //         currentSongIndex = _currentSongIndex! - 1;
// //       } else {
// //         currentSongIndex = _playlist.length - 1; 
// //       }
// //     }
// //   }

// //   void listenToDuration() {
// //     _audioPlayer.onDurationChanged.listen((newDuration) {
// //       _totalDuration = newDuration;
// //       notifyListeners();
// //     });

// //     _audioPlayer.onPositionChanged.listen((newPosition) {
// //       _currentDuration = newPosition;
// //       notifyListeners();
// //     });

// //     _audioPlayer.onPlayerComplete.listen((event) {
// //       playNextSong();
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _audioPlayer.dispose();
// //     super.dispose();
// //   }

// //   List<SongsModel> get playlist => _playlist;
// //   int? get currentSongIndex => _currentSongIndex;
// //   bool get isPlaying => _isPlaying;
// //   bool get isLoading => _isLoading; // Getter for loading state

// //   Duration get currentDuration => _currentDuration;
// //   Duration get totalDuration => _totalDuration;

// //   set currentSongIndex(int? newIndex) {
// //     _currentSongIndex = newIndex;
// //     if (newIndex != null) {
// //       play();
// //     }
// // WidgetsBinding.instance.addPostFrameCallback((_) {
// //     notifyListeners();
// //   });
// //   }
// // }


// import 'package:flutter/foundation.dart';
// import 'package:audioplayers/audioplayers.dart';

// class PlaylistProvider extends ChangeNotifier {
//   List<SongsModel> _playlist = [];
//   int? _currentSongIndex;
//   bool _isPlaying = false;
//   bool _isLoading = false;
//   Duration _currentDuration = Duration.zero;
//   Duration _totalDuration = Duration.zero;
//    final AudioPlayer _audioPlayer = AudioPlayer();


//   List<SongsModel> get playlist => _playlist;
//   int? get currentSongIndex => _currentSongIndex;
//   bool get isPlaying => _isPlaying;
//   bool get isLoading => _isLoading;
//   Duration get currentDuration => _currentDuration;
//   Duration get totalDuration => _totalDuration;

//   void setPlaylist(List<SongsModel> songs) {
//     _playlist = songs;
//     notifyListeners();
//   }

//   // Play song
//   void play() async {
//     if (_currentSongIndex != null) {
//       final song = _playlist[_currentSongIndex!];
//  //     await _audioPlayer.play(song.audioUrl); // Use song's audio URL
//       _isPlaying = true;
//       _audioPlayer.onDurationChanged.listen((newDuration) {
//         _totalDuration = newDuration;
//         notifyListeners();
//       });
//    //  _audioPlayer.onAudioPositionChanged.listen((newDuration) 
//   {
//    //     _currentDuration = newDuration;
//         notifyListeners();
//       }
//     }
//   }

//   // Pause/Resume song
//   void pauseOrResume() {
//     if (_isPlaying) {
//       _audioPlayer.pause();
//     } else {
//       _audioPlayer.resume();
//     }
//     _isPlaying = !_isPlaying;
//     notifyListeners();
//   }

//   // Play next song
//   void playNextSong() {
//     if (_currentSongIndex != null && _currentSongIndex! < _playlist.length - 1) {
//       _currentSongIndex = _currentSongIndex! + 1;
//       play();
//     }
//     notifyListeners();
//   }

//   // Play previous song
//   void playPreviousSong() {
//     if (_currentSongIndex != null && _currentSongIndex! > 0) {
//       _currentSongIndex = _currentSongIndex! - 1;
//       play();
//     }
//     notifyListeners();
//   }

//   // Seek within the song
//   void seek(Duration position) {
//     _audioPlayer.seek(position);
//     notifyListeners();
//   }

//   // Set current song by index
//   set currentSongIndex(int? newIndex) {
//     _currentSongIndex = newIndex;
//     if (newIndex != null) {
//       play();
//     }
//     notifyListeners();
//   }
// }
