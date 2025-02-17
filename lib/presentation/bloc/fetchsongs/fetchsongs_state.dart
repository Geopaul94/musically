
// State classes
import 'package:musically/data/models/songs/song_model.dart';

sealed class FetchSongsState {}

final class FetchSongsInitial extends FetchSongsState {}

class FetchSongsLoadingState extends FetchSongsState {}

class FetchSongsSuccessState extends FetchSongsState {
  final List<SongsModel> songs;

  FetchSongsSuccessState({required this.songs});
}

class FetchSongsErrorState extends FetchSongsState {
  final String error;

  FetchSongsErrorState({required this.error});
}
