


import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musically/data/models/songs/songS_ample.dart';

class Playlistprovider extends ChangeNotifier {
  final List<SongsAmple> _playlist = [
    SongsAmple(
      songname: 'aksfaskl',
      artistname: 'yesudas',
      songimage: 'assets/images/1.jpg',
      songpath: 'assets/music/lacore-diamond-reach-you-110784.mp3',
    ),
    SongsAmple(
      songname: 'odadafs',
      artistname: 'yesudas',
      songimage: 'assets/images/3.jpg',
      songpath: 'assets/music/lacore-diamond-reach-you-110784.mp3',
    ),
    SongsAmple(
      songname: 'Never give up',
      artistname: 'flutter dev',
      songimage: 'assets/images/2.jpg',
      songpath: 'assets/music/lacore-diamond-reach-you-110784.mp3',
    ),
  ];

  int? _currentsongIndex;

  final AudioPlayer _audiopalyer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totoalDuration = Duration.zero;

  bool _isplaying = false;

  Playlistprovider() {
    listenToDuration();
  }

  // void play() async {
  //   final String path = _playlist[_currentsongIndex!].songpath;

  //   await _audiopalyer.stop();
  //   await _audiopalyer.play(AssetSource(path)); // Use the correct path

  //   _isplaying = true;
  //   notifyListeners();
  // }





//   void play() async {
//   final String path = _playlist[_currentsongIndex!].songpath;
//   await _audiopalyer.stop();
//   await _audiopalyer.play(AssetSource(path)); // Ensure the path is correct
//   _isplaying = true;
//   notifyListeners();
// }


  void pause() async {
    await _audiopalyer.pause();
    _isplaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audiopalyer.resume();
    _isplaying = true;
    notifyListeners();
  }

  void pauseOrResume() async {
    if (_isplaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  void seek(Duration position) async {
    await _audiopalyer.seek(position);
  }

  void playNextSong() {
    if (_currentsongIndex != null) {
      if (_currentsongIndex! < _playlist.length - 1) {
        currentsongIndex = _currentsongIndex! + 1;
      } else {
        currentsongIndex = 0;
      }
    }
  }

  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 2) {
      await (Duration.zero); // Restart the song
    } else {
      if (_currentsongIndex! > 0) {
        currentsongIndex = _currentsongIndex! - 1; // Play previous song
      } else {
        currentsongIndex = _playlist.length - 1; // Wrap around to last song
      }
    }
  }

  void listenToDuration() {
    _audiopalyer.onDurationChanged.listen((newDuration) {
      _totoalDuration = newDuration;
      notifyListeners();
    });

    _audiopalyer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audiopalyer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  @override
  void dispose() {
    _audiopalyer.dispose();
    super.dispose();
  }

  List<SongsAmple> get playlist => _playlist;
  int? get currentsongIndex => _currentsongIndex;
  bool get isPlaying => _isplaying;

  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totoalDuration;

  set currentsongIndex(int? newIndex) {
    _currentsongIndex = newIndex;

    if (newIndex != null) {
    //  play();
    }

    notifyListeners();
  }
}





// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:musically/data/models/songs/song_model.dart';
// import 'package:musically/data/repository/fetchsongs.dart';

// class Playlistprovider extends ChangeNotifier {
//   // Use List<SongsModel> instead of List<SongsAmple>

//   final String userId;
//   List<SongsModel> _playlist = [];
//   int? _currentSongIndex;
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   Duration _currentDuration = Duration.zero;
//   Duration _totalDuration = Duration.zero;
//   bool _isPlaying = false;
//   final FetchSongsInitials _fetchSongsInitials = FetchSongsInitials();

// Playlistprovider({required this.userId}) {
//     _initializePlaylist();
//     listenToDuration();
//   }

//   Future<void> _initializePlaylist() async {
//     // Start with fetching initial songs
//     await _fetchAndAddSongs();
//   }

//  Future<void> _fetchAndAddSongs() async {
//   try {
//     final newSongs = await _fetchSongsInitials.fetchInitialSongs(userId); // Use 'userId' from the class field
//     _playlist.addAll(newSongs);
//     if (_currentSongIndex == null && _playlist.isNotEmpty) {
//       _currentSongIndex = 0;
//     }
//     notifyListeners();
//   } catch (e) {
//     print("Error fetching songs: $e");
//   }
// }

//   // Play method now uses SongsModel
//   void play() async {
//     if (_currentSongIndex != null && _currentSongIndex! < _playlist.length) {
//       final song = _playlist[_currentSongIndex!];
//       await _audioPlayer.stop();
//       // Here, you'll need to decide how to handle the 'audiopath'. If it's a URL, use UrlSource
//       await _audioPlayer.play(UrlSource(song.audiopath)); // Use UrlSource if path is URL, else use DeviceFileSource or AssetSource
//       _isPlaying = true;
//       notifyListeners();
//     }
//   }

//   void pause() async {
//     await _audioPlayer.pause();
//     _isPlaying = false;
//     notifyListeners();
//   }

//   void resume() async {
//     await _audioPlayer.resume();
//     _isPlaying = true;
//     notifyListeners();
//   }

//   void pauseOrResume() async {
//     if (_isPlaying) {
//       pause();
//     } else {
//       resume();
//     }
//   }

//   void seek(Duration position) async {
//     await _audioPlayer.seek(position);
//   }

//   void playNextSong() {
//     if (_currentSongIndex != null) {
//       _currentSongIndex = (_currentSongIndex! < _playlist.length - 1) ? _currentSongIndex! + 1 : 0;
//       play();
//       _checkAndFetchMoreSongs();
//     }
//   }

//   void playPreviousSong() async {
//     if (_currentDuration.inSeconds > 2) {
//       await _audioPlayer.seek(Duration.zero); // Restart the song
//     } else {
//       if (_currentSongIndex != null && _currentSongIndex! > 0) {
//         _currentSongIndex = _currentSongIndex! - 1;
//       } else {
//         _currentSongIndex = _playlist.length - 1; // Wrap around to last song
//       }
//       play();
//     }
//   }

//   void listenToDuration() {
//     _audioPlayer.onDurationChanged.listen((newDuration) {
//       _totalDuration = newDuration;
//       notifyListeners();
//     });

//     _audioPlayer.onPositionChanged.listen((newPosition) {
//       _currentDuration = newPosition;
//       notifyListeners();
//     });

//     _audioPlayer.onPlayerComplete.listen((event) {
//       playNextSong();
//     });
//   }

//   void _checkAndFetchMoreSongs() {
//     // Check if we need to fetch more songs
//     if (_currentSongIndex != null && _playlist.length - _currentSongIndex! <= 5) {
//       // Fetch more songs in the background
//       _fetchAndAddSongs();
//     }
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   List<SongsModel> get playlist => _playlist;
//   int? get currentSongIndex => _currentSongIndex;
//   bool get isPlaying => _isPlaying;
//   Duration get currentDuration => _currentDuration;
//   Duration get totalDuration => _totalDuration;

//   set currentSongIndex(int? newIndex) {
//     _currentSongIndex = newIndex;
//     if (newIndex != null) {
//       play();
//     }
//     notifyListeners();
//   }
// }