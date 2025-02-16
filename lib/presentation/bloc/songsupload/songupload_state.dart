part of 'songupload_bloc.dart';

@immutable
sealed class SonguploadState {}

final class SonguploadInitial extends SonguploadState {}

class SonguploadLoadingState extends SonguploadState {}

class SonguploadSuccessState extends SonguploadState {}

class SonguploadErrorState extends SonguploadState {
  final String error;

  SonguploadErrorState({required this.error});
}

class SongUpdateLoadingState extends SonguploadState {}

class SongUpdateSuccessState extends SonguploadState {}

class SongUpdateErrorState extends SonguploadState {
  final String error;

  SongUpdateErrorState({required this.error});
}
