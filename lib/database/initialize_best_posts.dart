import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> initializeBestPosts() async {
  // Get all grids
  QuerySnapshot gridSnapshot =
      await FirebaseFirestore.instance.collection('grids').get();

  for (var grid in gridSnapshot.docs) {
    String gridId = grid.id;

    // Fetch the most liked post for each grid
    QuerySnapshot postSnapshot = await FirebaseFirestore.instance
        .collection('grids')
        .doc(gridId)
        .collection('posts')
        .orderBy('likeCount', descending: true)
        .limit(1)
        .get();

    if (postSnapshot.docs.isNotEmpty) {
      final postData = postSnapshot.docs.first.data() as Map<String, dynamic>;

      final bestPost = {
        'gridCode': gridId,
        'uid': postData['uid'],
        'username': postData['username'] ?? 'Unknown',
        'profileImgUrl': postData['profileImgUrl'] ?? '',
        'contentText': postData['contentText'] ?? '',
        'contentImageUrl': postData['contentImageUrl'] ?? '',
        'timestamp': postData['timestamp'] ?? 'Unknown',
        'likeCount': postData['likeCount'] ?? 0,
        'commentCount': postData['commentCount'] ?? 0,
        'likedBy': postData['likedBy']
      };

      // Add the best post to the bestPosts collection
      await FirebaseFirestore.instance
          .collection('bestPosts')
          .doc(gridId)
          .set(bestPost);
    }
  }

  print('Best posts initialized successfully.');
}
