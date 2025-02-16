
// import 'package:musically/data/models/songs/song_model.dart';

// sealed class SongsFetchState {}

// final class SongsFetchInitial extends SongsFetchState {}

// class SongsFetchLoadingState extends SongsFetchState {}

// class SongsFetchSuccessState extends SongsFetchState {
//   final List<SongsModel> songsModel;

//   SongsFetchSuccessState({required this.songsModel});
// }

// class SongsFetchErrorState extends SongsFetchState {final String error;

//   SongsFetchErrorState({required this.error});}



// States
import 'package:musically/data/models/songs/song_model.dart';

abstract class SongsFetchState {}

class SongsFetchInitial extends SongsFetchState {}

class SongsFetchLoadingState extends SongsFetchState {}

class SongsFetchSuccessState extends SongsFetchState {
  final List<SongsModel> songsModel;
  SongsFetchSuccessState({required this.songsModel});
}

class SongsFetchErrorState extends SongsFetchState {
  final String error;
  SongsFetchErrorState({required this.error});
}