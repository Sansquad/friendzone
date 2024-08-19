import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendzone/models/post.dart';
import 'package:friendzone/models/user.dart';
import 'package:friendzone/services/auth/firebase_auth_services.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // Save User info on register
  Future<void> saveUserDB(
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
  Future<UserModel?> getUserDB(String uid) async {
    try {
      DocumentSnapshot userDoc = await _db.collection("users").doc(uid).get();
      return UserModel.fromDocument(userDoc);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> updateUserBioDB(String bio) async {
    String uid = FirebaseAuthService().getCurrentUid();

    try {
      await _db.collection("users").doc(uid).update({'bio': bio});
    } catch (e) {
      print(e);
    }
  }

  // Create a post
  Future<void> createPostDB(
      String gridCode, String contentText, String contentImageUrl) async {
    try {
      String uid = _auth.currentUser!.uid;

      UserModel? user = await getUserDB(uid);

      Post newPost = Post(
        id: '',
        gridCode: gridCode,
        uid: uid,
        username: user!.username,
        profileImgUrl: user.profileImgUrl,
        contentText: contentText,
        contentImageUrl: contentImageUrl,
        timestamp: Timestamp.now(),
        likeCount: 0,
        commentCount: 0,
        likedBy: [],
      );

      Map<String, dynamic> newPostMap = newPost.toMap();

      final gridDocRef =
          FirebaseFirestore.instance.collection("grids").doc(gridCode);

      // Check if the gridCode document exists
      final gridDocSnapshot = await gridDocRef.get();

      if (!gridDocSnapshot.exists) {
        await gridDocRef.set({});
      }

      await _db
          .collection("grids")
          .doc(gridCode)
          .collection("posts")
          .add(newPostMap);
    } catch (e) {
      print(e);
    }
  }

  // Get localPosts
  Future<List<Post>> getLocalPostsDB(String gridCode) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection("grids")
          .doc(gridCode)
          .collection("posts")
          .orderBy("timestamp", descending: true)
          .get();

      return snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  // Get bestPosts
  Future<List<Post>> getBestPostsDB() async {
    return [];
    //try {
    //  QuerySnapshot snapshot = await _db
    //      .collection("bestPosts")
    //      .doc(gridCode)
    //      .collection("posts")
    //      .orderBy("timestamp", descending: true)
    //      .get();

    //  return snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    //} catch (e) {
    //  print(e);
    //  return [];
    //}
  }
}
