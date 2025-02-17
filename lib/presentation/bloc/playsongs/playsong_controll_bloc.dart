// import 'package:bloc/bloc.dart';
// import 'package:musically/data/models/songs/song_model.dart';
// import 'package:musically/presentation/bloc/playsongs/playsong_controll_event.dart';
// import 'package:musically/presentation/bloc/playsongs/playsong_controll_state.dart';


// class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> { List<Song> songs;
//   int currentIndex;
//   MusicPlayerBloc(List<SongsModel> songs, int initialIndex)
//       : super(MusicPlayerState(
//           isPlaying: false,
//           currentDuration: Duration.zero,
//           totalDuration: Duration.zero,
//           currentIndex: initialIndex,
//         )) {
//     on<PlaySong>((event, emit) {
//       emit(state.copyWith(isPlaying: true));
//     });

//     on<PauseSong>((event, emit) {
//       emit(state.copyWith(isPlaying: false));
//     });

//     on<NextSong>((event, emit) {
//       int nextIndex = (state.currentIndex + 1) % songs.length;
//       emit(state.copyWith(currentIndex: nextIndex));
//     });

//     on<PreviousSong>((event, emit) {
//       int prevIndex = (state.currentIndex - 1 + songs.length) % songs.length;
//       emit(state.copyWith(currentIndex: prevIndex));
//     });

//     on<SeekToPosition>((event, emit) {
//       emit(state.copyWith(currentDuration: event.position));
//     });

//     on<UpdateDuration>((event, emit) {
//       emit(state.copyWith(
//         currentDuration: event.currentDuration,
//         totalDuration: event.totalDuration,
//       ));
//     });
//   }
// }
