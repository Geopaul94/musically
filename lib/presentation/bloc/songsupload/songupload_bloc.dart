import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musically/data/models/songs/song_model.dart';
import 'package:musically/data/repository/song_upload.dart';

part 'songupload_event.dart';
part 'songupload_state.dart';

class SonguploadBloc extends Bloc<SonguploadEvent, SonguploadState> {
  SonguploadBloc() : super(SonguploadInitial()) {
  on<UsersongsUploadEvent>(_useruploadsongsEvent);
   // on<UsersongUpdateUploadEvent>(_userUpdatesongsEvent); 
  }

  Future<void> _useruploadsongsEvent(UsersongsUploadEvent event, Emitter<SonguploadState> emit) async {
    emit(SonguploadLoadingState());
    try {
      await SongsUpload().uploadSongs(event.songs);
      emit(SonguploadSuccessState());
    } catch (e) {
      emit(SonguploadErrorState(error: e.toString())); // Capture and pass error
    }
  }

  // Future<void> _userUpdatesongsEvent(UsersongUpdateUploadEvent event, Emitter<SonguploadState> emit) async {
  //   emit(SongUpdateLoadingState());
  //   try {
  //     // Assume `AuthService` has a method for Google sign-in
  //     await AuthService().loginWithGoogle(); 
  //     emit(SongUpdateSuccessState());
  //   } catch (e) {
  //     emit(SongUpdateErrorState(error: e.toString())); // Capture and pass error
  //   }
  // }
}