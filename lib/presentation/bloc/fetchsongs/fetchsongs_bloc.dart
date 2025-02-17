import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musically/data/models/songs/song_model.dart';
import 'package:musically/data/repository/fetchsongs.dart';
import 'package:musically/presentation/bloc/fetchsongs/fetchsongs_event.dart';
import 'package:musically/presentation/bloc/fetchsongs/fetchsongs_state.dart';

class FetchSongsBloc extends Bloc<FetchsongsEvent, FetchSongsState> {
  FetchSongsBloc() : super(FetchSongsInitial()) {
    on<FetchSongsInitialEvent>(_onFetchSongsInitialEvent);
  }

  Future<void> _onFetchSongsInitialEvent(
      FetchSongsInitialEvent event, Emitter<FetchSongsState> emit) async {
    emit(FetchSongsLoadingState());

    try {
      final List<SongsModel> songs =
          await FetchSongs().getUserSongs(event.userId.toString());
      print("Songs fetched: ${songs.length}");
      emit(FetchSongsSuccessState(songs: songs));
    } catch (e) {
      emit(FetchSongsErrorState(error: e.toString()));
    }
  }
}
