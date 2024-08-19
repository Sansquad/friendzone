import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String gridCode;
  //final UserModel user;
  final String id;
  final String uid;
  final String username;
  final String profileImgUrl;
  final String contentText;
  final String contentImageUrl;
  final Timestamp timestamp;
  final int likeCount;
  final int commentCount;
  final List<String> likedBy;

  Post({
    required this.gridCode,
    //required this.user,
    required this.id,
    required this.uid,
    required this.username,
    required this.profileImgUrl,
    required this.contentText,
    required this.contentImageUrl,
    required this.timestamp,
    required this.likeCount,
    required this.commentCount,
    required this.likedBy,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      gridCode: doc['gridCode'],
      //user: UserModel.fromMap(doc['user']),
      id: doc.id,
      uid: doc['uid'],
      username: doc['username'],
      profileImgUrl: doc['profileImgUrl'],
      contentText: doc['contentText'],
      contentImageUrl: doc['contentImageUrl'],
      timestamp: doc['timestamp'],
      likeCount: doc['likeCount'],
      commentCount: doc['commentCount'],
      likedBy: List<String>.from(doc['likedBy'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'gridCode': gridCode,
      //'user': user.toMap(),
      'uid': uid,
      'username': username,
      'profileImgUrl': profileImgUrl,
      'contentText': contentText,
      'contentImageUrl': contentImageUrl,
      'timestamp': timestamp,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'likedBy': likedBy,
    };
  }
}
