
part of 'songupload_bloc.dart';


@immutable
sealed class SonguploadEvent {}

class UsersongsUploadEvent extends SonguploadEvent {
  final SongsModel songs;

  UsersongsUploadEvent({required this.songs});
}

class UsersongUpdateUploadEvent extends SonguploadEvent {
  final SongsModel songs;

  UsersongUpdateUploadEvent({required this.songs});
}
