class SongsModel {
  final String songname;
  final String artistname;
  final String audiopath; // Path to the file on the local device
  final String imagepath;
  final String createdAt;
  final String? documentId; // Document ID of the Firestore entry
  final String? userId; // User ID or email of the uploader

  SongsModel({
    required this.songname,
    required this.artistname,
    required this.audiopath,
    required this.imagepath,
    required this.createdAt,
    this.documentId,
    this.userId, // New field to associate the song with the user
  });

  // Convert the SongsModel to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'songname': songname,
      'artistname': artistname,
      'audiopath': audiopath,
      'imagepath': imagepath,
      'createdAt': createdAt,
      'documentId': documentId,
      'userId': userId, 
    };
  }

  // Create a SongsModel from Firestore Map (for retrieval)
  factory SongsModel.fromFirestore(Map<String, dynamic> json) {
    return SongsModel(
      songname: json['songname'],
      artistname: json['artistname'],
      audiopath: json['audiopath'],
      imagepath: json['imagepath'],
      createdAt: json['createdAt'],
      documentId: json['documentId'],
      userId: json['userId'], // Retrieve userId from Firestore
    );
  }
}
