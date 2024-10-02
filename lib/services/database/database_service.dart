import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendzone/models/comment.dart';
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

  // Update user info
  Future<void> updateUserBioDB(String bio) async {
    String uid = FirebaseAuthService().getCurrentUid();

    try {
      await _db.collection("users").doc(uid).update({'bio': bio});
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUserUsernameDB(String username) async {
    String uid = FirebaseAuthService().getCurrentUid();

    try {
      await _db.collection("users").doc(uid).update({'username': username});
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUserProfileImageDB(String profileImgUrl) async {
    String uid = FirebaseAuthService().getCurrentUid();

    try {
      await _db
          .collection("users")
          .doc(uid)
          .update({'profileImgUrl': profileImgUrl});
    } catch (e) {
      print(e);
    }
  }

  // Calibrate current grid
  String calibrateZoneDB() {
    // TODO finish zone calibration method
    return "C - 137";
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

  // Delete User Post
  Future<void> deletePostDB(String gridCode, String postId) async {
    try {
      await _db
          .collection("grids")
          .doc(gridCode)
          .collection("posts")
          .doc(postId)
          .delete();
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

  Future<void> togglePostLikeDb(String gridCode, String postId) async {
    try {
      String uid = _auth.currentUser!.uid;

      DocumentReference postDoc =
          _db.collection("grids").doc(gridCode).collection("posts").doc(postId);

      await _db.runTransaction(
        (transaction) async {
          // get post data
          DocumentSnapshot postSnapshot = await transaction.get(postDoc);

          // get like of users who like this post
          List<String> likedBy =
              List<String>.from(postSnapshot['likedBy'] ?? []);

          // get like count
          int currentLikeCount = postSnapshot['likeCount'];

          // if user has not liked this post yet, like
          if (!likedBy.contains(uid)) {
            likedBy.add(uid);
            currentLikeCount++;
          } else {
            likedBy.remove(uid);
            currentLikeCount--;
          }

          // update in database
          transaction.update(postDoc, {
            'likeCount': currentLikeCount,
            'likedBy': likedBy,
          });
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // Add comment to a post
  Future<void> addCommentDB(String gridCode, String postId, message) async {
    try {
      String uid = _auth.currentUser!.uid;
      UserModel? user = await getUserDB(uid);

      Comment newComment = Comment(
        id: '',
        postId: postId,
        uid: uid,
        username: user!.username,
        message: message,
        timestamp: Timestamp.now(),
      );

      // Convert comment to map
      Map<String, dynamic> newCommentMap = newComment.toMap();

      // TODO add comments to posts themselves???
      await _db.collection("comments").add(newCommentMap);
    } catch (e) {
      print(e);
    }
  }
}
