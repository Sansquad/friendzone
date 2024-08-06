import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post.dart';
import '../models/user.dart';

Future<void> uploadDummyData() async {
  final List<Map<String, dynamic>> dummyData = [
    {
      'gridCode': 'C - 137',
      'username': 'Kusupman_David',
      'profileImgUrl':
          'https://image.api.playstation.com/cdn/UP0151/CUSA09971_00/FEs8B2BDAudxV3js6SM2t4vZ88vnxSi0.png?w=440&thumb=false',
      'timestamp': '30 minutes ago',
      'contentText':
          'I am so extremely hungry\nNo breakfast. 2 eggs for lunch. 10 hours of work.... Can’t wait to go home...',
      'likeNum': 137,
      'commentNum': 69,
      'contentImageUrl': ''
    },
    {
      'gridCode': 'C - 137',
      'username': 'ilovedanchu',
      'profileImgUrl':
          'https://image.api.playstation.com/cdn/UP0151/CUSA09971_00/0RcbL27NY6TiKznAHsJXUcALVKb4AMyM.png?w=440&thumb=false',
      'timestamp': '44 minutes ago',
      'contentText': 'Peaceful Tuesday',
      'likeNum': 42,
      'commentNum': 27,
      'contentImageUrl':
          'https://moewalls.com/wp-content/uploads/2023/05/rengoku-death-kimetsu-no-yaiba-thumb.jpg'
    },
    {
      'gridCode': 'C - 137',
      'username': 'hellothisisxyz',
      'profileImgUrl':
          'https://i1.sndcdn.com/artworks-000244570678-1pbn82-t500x500.jpg',
      'timestamp': '4 hours ago',
      'contentText':
          'watch this video\nhttps://www.youtube.com/watch?v=E8H-67ILaqc',
      'likeNum': 12,
      'commentNum': 8,
      'contentImageUrl': ''
    },
    {
      'gridCode': 'C - 137',
      'username': 'hiddenperson',
      'profileImgUrl':
          'https://preview.redd.it/wtc3gq9qhe041.jpg?auto=webp&s=59263396dfaccee7362a7d5dce235c2d1810a4cf',
      'timestamp': '6 hours ago',
      'contentText': 'damn you found me by scrolling are you flutter god',
      'likeNum': 1,
      'commentNum': 2,
      'contentImageUrl': ''
    }
  ];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  for (var postData in dummyData) {
    final user = User(
      username: postData['username']!,
      profileImgUrl: postData['profileImgUrl']!,
    );

    final post = Post(
      gridCode: postData['gridCode'],
      user: user,
      timestamp: postData['timestamp']!,
      contentText: postData['contentText']!,
      likeNum: postData['likeNum']!,
      commentNum: postData['commentNum']!,
      contentImageUrl: postData['contentImageUrl']!,
    );

    await firestore
        .collection('grids')
        .doc('C - 137')
        .collection('posts')
        .add(post.toMap());
  }
}
