// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:musically/data/models/songs/songS_ample.dart';

// class Playlistprovider extends ChangeNotifier {
//   final List<SongsAmple> _playlist = [
//     //song 1
//     SongsAmple(
//         songname: 'aksfaskl',
//         artistname: 'yesudas',
//         songimage: 'assets/images/1.jpg',
//         songpath: 'assets/music/lacore-diamond-reach-you-110784.mp3'),

// //song 2

//     SongsAmple(
//         songname: 'odadafs',
//         artistname: 'yesudas',
//         songimage: 'assets/images/3.jpg',
//         songpath: 'assets/music/lacore-diamond-reach-you-110784.mp3'),

// //song 3
//     SongsAmple(
//         songname: 'Never give up',
//         artistname: 'flutter dev',
//         songimage: 'assets/images/2.jpg',
//         songpath: 'assets/music/lacore-diamond-reach-you-110784.mp3'),
//   ];

// // current song playing index

//   int? _currentsongIndex;

// /*
//    Audio player 



// */

// // audio player

//   final AudioPlayer _audiopalyer = AudioPlayer();

// // duration

//   Duration _currentDuration = Duration.zero;
//   Duration _totoalDuration = Duration.zero;

// // constructor

//   Playlistprovider() {
//     listenToDuration();
//   }

// // initialy not playing

//   bool _isplaying = false;

// // play the song

//   void play() async {
//     final String path = _playlist[_currentsongIndex!].songpath;

//     await _audiopalyer.stop();
//     await _audiopalyer
//         .play(AssetSource('assets/music/lacore-diamond-reach-you-110784.mp3')); // Use `AssetSource` to load the asset

//     _isplaying = true;
//     notifyListeners();
//   }

// // pause song

//   void pause() async {
//     await _audiopalyer.pause();
//     _isplaying = false;
//     notifyListeners();
//   }

// // resume playing

//   void resume() async {
//     await _audiopalyer.resume();

//     _isplaying = true;
//     notifyListeners();
//     ;
//   }

// // pause or resume

//   void pauseOrResume() async {
//     if (_isplaying) {
//       pause();
//     } else {
//       resume();
//     }
//     notifyListeners();
//   }

// //void seek 

// void seek(Duration position)async{await _audiopalyer.seek(position);}


// // play next song
// void playNextSong(){

//   if (_currentsongIndex !=null) {
//     if (_currentsongIndex! < _playlist.length-1) {
//       currentsongIndex=_currentsongIndex!   +  1;
//     }else{


//       currentsongIndex=0;
//     }
//   }
// }

// //// play previous song



// void playPreviousSong ()async{
//   if (_currentDuration.inSeconds>2) {
    
//   }else{
//     if (_currentsongIndex!   >0) {
//       currentsongIndex =_currentsongIndex! -1;
      
//     }else{
//       currentsongIndex =_playlist.length-1;
//     }
//   }

// }

// // listenToDuration

//   void listenToDuration() {
// // listen for total duration
//     _audiopalyer.onDurationChanged.listen((newDuraion) {
//       _totoalDuration = newDuraion;
//       notifyListeners();
//     });

// // listen for current durartion

//     _audiopalyer.onPositionChanged.listen((newPostion) {
//       _currentDuration = newPostion;

//       notifyListeners();
//     });
// // Listen for song completion
//     _audiopalyer.onPlayerComplete.listen((event) {
//       playNextSong();
//     });
//   }
// //dispose audio player



// /*

// GETTERS

// */
  




//   List<SongsAmple> get playlist => _playlist;
//   int? get currentsongIndex => _currentsongIndex;
//   bool get isPlaying  => isPlaying;

// Duration get currentDuration => _currentDuration;
// Duration get totalDuration=>_totoalDuration;
//   set currentsongIndex(int? newIndex) {
//     _currentsongIndex = newIndex;


// if (newIndex !=null) {
//   play();
// }


//     notifyListeners();
//   }
// }



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
