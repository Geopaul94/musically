import 'package:bloc/bloc.dart';
import 'package:musically/data/models/songs/song_model.dart';
import 'package:musically/data/repository/fetchsongs.dart';
import 'package:musically/presentation/bloc/songs_fetch/songs_fetch_event.dart';
import 'package:musically/presentation/bloc/songs_fetch/songs_fetch_state.dart';

import 'dart:async';

// class SongsFetchBloc extends Bloc<SongsFetchEvent, SongsFetchState> {
//   final FetchSongsInitials _fetchSongsInitials = FetchSongsInitials();
//    List<SongsModel> _songsList = []; 
//   String? _lastDocumentId;

//   SongsFetchBloc() : super(SongsFetchInitial()) {
//     on<songsFetchinitialEvent>(_songFetchInitialEvent);
//   }

//   Future<void> _songFetchInitialEvent(
//       songsFetchinitialEvent event, Emitter<SongsFetchState> emit) async {
//     emit(SongsFetchLoadingState());
//     try {
//       // Fetch initial 10 songs
//       final songs = await _fetchSongsInitials.fetchInitialSongs(event.userId); // Replace 'userId' with actual user ID
//       _songsList.addAll(songs);
//       _lastDocumentId = songs.last.documentId;

//       emit(SongsFetchSuccessState(songsModel: songs.first)); 

     
//       Timer.periodic(Duration(seconds: 1), (timer) {
//         if (_songsList.length - 5 <= _currentPlayingIndex) {
//           _fetchNextSongs();
//           timer.cancel();
//         }
//       });
//     } catch (e) {
//       emit(SongsFetchErrorState(error: e.toString()));
//     }
//   }

//   int _currentPlayingIndex = 0; // To keep track of which song is currently playing

//   Future<void> _fetchNextSongs() async {
//     if (_lastDocumentId != null) {
//       try {
//         final nextSongs = await _fetchSongsInitials.fetchNextSongs('userId', _lastDocumentId!, 5);
//         if (nextSongs.isNotEmpty) {
//           _songsList.addAll(nextSongs);
//           _lastDocumentId = nextSongs.last.documentId;
//         }
//       } catch (e) {
//         print("Error fetching next songs: $e");
//       }
//     }
//   }

//   // Method to update current index when song changes
//   void updateCurrentIndex(int index) {
//     _currentPlayingIndex = index;
//   }

//   // Method to get current song for playing
//   SongsModel getCurrentSong() {
//     if (_currentPlayingIndex < _songsList.length) {
//       return _songsList[_currentPlayingIndex];
//     } else {
//       throw Exception("No more songs to play");
//     }
//   }
// }



class SongsFetchBloc extends Bloc<SongsFetchEvent, SongsFetchState> {
  final FetchSongsInitials _fetchSongsInitials = FetchSongsInitials();
  List<SongsModel> _songsList = [];
  String? _lastDocumentId;

  SongsFetchBloc() : super(SongsFetchInitial()) {
    on<SongsFetchInitialEvent>(_songFetchInitialEvent);
    on<SongsFetchNextEvent>(_songFetchNextEvent);
  }

  Future<void> _songFetchInitialEvent(
      SongsFetchInitialEvent event, Emitter<SongsFetchState> emit) async {
    emit(SongsFetchLoadingState());
    try {
      // Fetch initial songs
      final songs = await _fetchSongsInitials.fetchInitialSongs(event.userId);
      _songsList.addAll(songs);
      _lastDocumentId = songs.last.documentId;
      emit(SongsFetchSuccessState(songsModel: _songsList));
    } catch (e) {
      emit(SongsFetchErrorState(error: e.toString()));
    }
  }

  Future<void> _songFetchNextEvent(
      SongsFetchNextEvent event, Emitter<SongsFetchState> emit) async {
    if (_lastDocumentId != null) {
      try {
        final nextSongs = await _fetchSongsInitials.fetchNextSongs(
          event.userId,
          _lastDocumentId!,
          5,
        );
        if (nextSongs.isNotEmpty) {
          _songsList.addAll(nextSongs);
          _lastDocumentId = nextSongs.last.documentId;
          emit(SongsFetchSuccessState(songsModel: _songsList));
        }
      } catch (e) {
        emit(SongsFetchErrorState(error: e.toString()));
      }
    }
  }
}