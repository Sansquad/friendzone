import 'package:flutter/material.dart';
import 'package:friendzone/models/user.dart';
import 'package:friendzone/services/database/database_service.dart';

import '../models/post.dart';

class DatabaseProvider extends ChangeNotifier {
  final _db = DatabaseService();

  // Get userModel given uid
  Future<UserModel?> userModel(String uid) => _db.getUserDB(uid);

  // Update user bio
  Future<void> updateBio(String bio) => _db.updateUserBioDB(bio);

  List<Post> _localPosts = [];
  List<Post> _bestPosts = [];

  List<Post> get localPosts => _localPosts;
  List<Post> get bestPosts => _bestPosts;

  // Posting a post
  Future<void> createPost(String gridCode, String contentText, String contentImageUrl) async {
    await _db.createPostDB(gridCode, contentText, contentImageUrl);
    await loadLocalPosts(gridCode);
  }


  // Fetch local posts
  Future<void> loadLocalPosts(String gridCode) async {

    final localPosts = await _db.getLocalPostsDB(gridCode);
    _localPosts = localPosts;

    // Update UI
    notifyListeners();
  }
}
