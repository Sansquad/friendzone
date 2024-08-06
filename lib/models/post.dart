import 'user.dart';

class Post {
  final String gridCode;
  final User user;
  final String timestamp;
  final String contentText;
  final int likeNum;
  final int commentNum;
  final String contentImageUrl;

  Post({
    required this.gridCode,
    required this.user,
    required this.timestamp,
    required this.contentText,
    required this.likeNum,
    required this.commentNum,
    required this.contentImageUrl,
  });

  factory Post.fromMap(Map<String, dynamic> data) {
    return Post(
      gridCode: data['gridCode'],
      user: User.fromMap(data['user']),
      timestamp: data['timestamp'],
      contentText: data['contentText'],
      likeNum: data['likeNum'],
      commentNum: data['commentNum'],
      contentImageUrl: data['contentImageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'gridCode': gridCode,
      'user': user.toMap(),
      'timestamp': timestamp,
      'contentText': contentText,
      'likeNum': likeNum,
      'commentNum': commentNum,
      'contentImageUrl': contentImageUrl,
    };
  }
}
