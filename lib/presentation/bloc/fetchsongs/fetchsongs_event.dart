
sealed class FetchsongsEvent {}


class FetchSongsInitialEvent extends FetchsongsEvent {
  final String userId;

  FetchSongsInitialEvent({required this.userId});
}