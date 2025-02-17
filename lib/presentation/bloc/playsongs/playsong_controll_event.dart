import 'package:equatable/equatable.dart';

abstract class MusicPlayerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlaySong extends MusicPlayerEvent {}

class PauseSong extends MusicPlayerEvent {}

class NextSong extends MusicPlayerEvent {}

class PreviousSong extends MusicPlayerEvent {}

class SeekToPosition extends MusicPlayerEvent {
  final Duration position;

  SeekToPosition(this.position);

  @override
  List<Object> get props => [position];
}

class UpdateDuration extends MusicPlayerEvent {
  final Duration currentDuration;
  final Duration totalDuration;

  UpdateDuration(this.currentDuration, this.totalDuration);

  @override
  List<Object> get props => [currentDuration, totalDuration];

}
