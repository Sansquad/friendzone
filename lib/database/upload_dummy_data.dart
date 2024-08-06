import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post.dart';
import '../models/user.dart';

Future<void> uploadDummyData() async {
  final List<Map<String, dynamic>> dummyData = [
    {
      'gridCode': 'C - 138',
      'username': 'Belon Tusk',
      'profileImgUrl':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Elon_Musk_Colorado_2022_%28cropped2%29.jpg/640px-Elon_Musk_Colorado_2022_%28cropped2%29.jpg',
      'timestamp': '30 minutes ago',
      'contentText':
          '**URGENT** how do i divide the earth into zones in flutter. help me dev gods',
      'likeNum': 120344,
      'commentNum': 2103,
      'contentImageUrl': ''
    },
    {
      'gridCode': 'A - 283',
      'username': 'MrEast',
      'profileImgUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCXjqOm-txYEsDyCtQdJCXlu6JFwHOaS8QoA&s',
      'timestamp': '44 minutes ago',
      'contentText':
          'i am testing for very looooooooooooooong looooooooooooooooooooooooooooooooooooooooooooooooooooooong looooooooooooooong contentText.',
      'likeNum': 10367,
      'commentNum': 6292,
      'contentImageUrl':
          'https://file.forms.app/sitefile/55+Hilarious-developer-memes-that-will-leave-you-in-splits-9.jpeg'
    },
    {
      'gridCode': 'D - 283',
      'username': 'hellothisisxyz',
      'profileImgUrl': '',
      'timestamp': '4 hours ago',
      'contentText':
          'watch this video\nhttps://www.youtube.com/watch?v=9RZ2Y-IyK3g',
      'likeNum': 1123,
      'commentNum': 632,
      'contentImageUrl': ''
    },
    {
      'gridCode': 'G - 281',
      'username': 'hiddenperson',
      'profileImgUrl':
          'https://image.civitai.com/xG1nkqKTMzGDvpLrqFT7WA/a8a20233-d498-480a-bd8a-700a74374d35/width=1200/a8a20233-d498-480a-bd8a-700a74374d35.jpeg',
      'timestamp': '2 hours ago',
      'contentText': 'SPOILER ALERT how muzan dies',
      'likeNum': 300,
      'commentNum': 62,
      'contentImageUrl':
          'https://i.pinimg.com/736x/f9/06/a1/f906a1909dc27df0acedb174d18b6901.jpg'
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
        .doc(postData['gridCode'])
        .collection('posts')
        .add(post.toMap());
  }
}
