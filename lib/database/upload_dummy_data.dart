import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post.dart';

Future<void> uploadDummyData() async {
  final List<Map<String, dynamic>> dummyData = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  print("Uploading dummy data...");
  for (var postData in dummyData) {
    //final user = UserModel(
    // username: postData['username']!,
    //  profileImgUrl: postData['profileImgUrl']!,
    // );

    final post = Post(
      gridCode: postData['gridCode'],
      id: postData['id'],
      uid: postData['uid'],
      username: postData['username'],
      contentText: postData['contentText']!,
      contentImageUrl: postData['contentImageUrl']!,
      timestamp: generateRandomTimestamp(),
      likeCount: postData['likeCount']!,
      commentCount: postData['commentCount']!,
      likedBy: List<String>.from(postData['likedBy'] ?? []),
    );

    final gridDocRef = firestore.collection('grids').doc(postData['gridCode']);
    final postCollectionRef = gridDocRef.collection('posts');

    await gridDocRef.set({});

    await postCollectionRef.add(post.toMap());
  }
}

Timestamp generateRandomTimestamp() {
  final random = Random();
  final now = DateTime.now();
  final randomDays =
      random.nextInt(30); // Random number of days within the last month
  final randomHours = random.nextInt(24); // Random number of hours
  final randomMinutes = random.nextInt(60); // Random number of minutes

  final randomTimestamp = now.subtract(
      Duration(days: randomDays, hours: randomHours, minutes: randomMinutes));
  return Timestamp.fromDate(randomTimestamp); // Convert to Firestore Timestamp
}
