import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musically/data/models/songs/song_model.dart';

class FetchSongsInitials {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<SongsModel>> fetchInitialSongs(String userId) async {
    // Query Firestore for the first 10 songs
    final querySnapshot = await _firestore
        .collection('songs')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(10)
        .get();

    return querySnapshot.docs
        .map((doc) => SongsModel.fromFirestore(doc.data()))
        .toList();
  }

  Future<List<SongsModel>> fetchNextSongs(
      String userId, String lastDocumentId, int count) async {
    // Query Firestore for the next set of songs after the last document
    final querySnapshot = await _firestore
        .collection('songs')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .startAfterDocument(
            await _firestore.collection('songs').doc(lastDocumentId).get())
        .limit(count)
        .get();

    return querySnapshot.docs
        .map((doc) => SongsModel.fromFirestore(doc.data()))
        .toList();
  }
}
