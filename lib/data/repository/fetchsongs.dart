import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musically/data/models/songs/song_model.dart';

class FetchSongs {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to fetch songs uploaded by a specific user
  Future<List<SongsModel>> getUserSongs(String userId) async {
    try {
      // Query Firestore to get only the songs uploaded by the specific user
      QuerySnapshot snapshot = await _firestore
          .collection('songs')
          .where('userId', isEqualTo: userId) // Filter by userId
          .get();

      // Map each document in the collection to a SongsModel
      List<SongsModel> songs = snapshot.docs.map((doc) {
        return SongsModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();

      return songs;
    } catch (e) {
      print('Error fetching user songs: $e');
      return [];
    }
  }
}
