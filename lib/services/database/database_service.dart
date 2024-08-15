import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendzone/models/post.dart';
import 'package:friendzone/models/user.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // Save User info on register
  Future<void> saveUserOnRegister(
      {required String username, required String email}) async {
    String uid = _auth.currentUser!.uid;

    UserModel user = UserModel(
      uid: uid,
      username: username,
      email: email,
      bio: '',
      profileImgUrl: '',
    );

    final userMap = user.toMap();
    await _db.collection("users").doc(uid).set(userMap);
  }

  // Get User from Firebase
  Future<UserModel?> getUserFirebase(String uid) async {
    try {
      DocumentSnapshot userDoc = await _db.collection("users").doc(uid).get();
      return UserModel.fromDocument(userDoc);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Create a post
  Future<void> createPostFirebase(
      String gridCode, String contentText, String contentImageUrl) async {
    try {
      String uid = _auth.currentUser!.uid;

      UserModel? user = await getUserFirebase(uid);

      Post newPost = Post(
        id: '',
        gridCode: gridCode,
        uid: uid,
        username: user!.username,
        contentText: contentText,
        contentImageUrl: contentImageUrl,
        timestamp: Timestamp.now(),
        likeCount: 0,
        commentCount: 0,
        likedBy: [],
      );

      Map<String, dynamic> newPostMap = newPost.toMap();
      // TODO
      await _db.collection("grids").doc(gridCode).collection("posts").add(newPostMap);
    } catch (e) {
      print(e);
    }
  }
}
