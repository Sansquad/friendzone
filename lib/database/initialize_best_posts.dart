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
      final user = postData['user'] as Map<String, dynamic>?;

      final bestPost = {
        'gridCode': gridId,
        'username': user?['username'] ?? 'Unknown',
        'profileImgUrl': user?['profileImgUrl'] ?? '',
        'timestamp': postData['timestamp'] ?? 'Unknown',
        'contentText': postData['contentText'] ?? '',
        'likeCount': postData['likeCount'] ?? 0,
        'commentCount': postData['commentCount'] ?? 0,
        'contentImageUrl': postData['contentImageUrl'] ?? '',
        'user': user,
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
