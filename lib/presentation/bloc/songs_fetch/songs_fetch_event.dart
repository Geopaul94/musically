
// sealed class SongsFetchEvent {}
// class songsFetchinitialEvent extends SongsFetchEvent {final String userId;

//   songsFetchinitialEvent({required this.userId});}








// Events
abstract class SongsFetchEvent {}

class SongsFetchInitialEvent extends SongsFetchEvent {
  final String userId;
  SongsFetchInitialEvent({required this.userId});
}

class SongsFetchNextEvent extends SongsFetchEvent {
  final String userId;
  SongsFetchNextEvent({required this.userId});
}
