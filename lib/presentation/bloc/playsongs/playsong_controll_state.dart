import 'package:equatable/equatable.dart';

class MusicPlayerState extends Equatable {
  final bool isPlaying;
  final Duration currentDuration;
  final Duration totalDuration;
  final int currentIndex;

  const MusicPlayerState({
    required this.isPlaying,
    required this.currentDuration,
    required this.totalDuration,
    required this.currentIndex,
  });

  MusicPlayerState copyWith({
    bool? isPlaying,
    Duration? currentDuration,
    Duration? totalDuration,
    int? currentIndex,
  }) {
    return MusicPlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      currentDuration: currentDuration ?? this.currentDuration,
      totalDuration: totalDuration ?? this.totalDuration,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object> get props => [isPlaying, currentDuration, totalDuration, currentIndex];
}
