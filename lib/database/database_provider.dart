import 'package:flutter/material.dart';
import 'package:friendzone/models/user.dart';
import 'package:friendzone/services/database/database_service.dart';

import '../models/post.dart';

class DatabaseProvider extends ChangeNotifier {
  final _db = DatabaseService();

  UserModel? _currentUser;
  List<Post> _localPosts = [];
  List<Post> _bestPosts = [];

  List<Post> get localPosts => _localPosts;
  List<Post> get bestPosts => _bestPosts;
  UserModel? get currentUser => _currentUser;

  // Fetch all data on content_layout
  Future<void> loadAllData(String uid, gridCode) async {
    _currentUser = await _db.getUserDB(uid);
    _localPosts = await _db.getLocalPostsDB(gridCode);
    _bestPosts = await _db.getBestPostsDB();

    notifyListeners();
  }

  // Get userModel given uid
  Future<UserModel?> userModel(String uid) => _db.getUserDB(uid);

  // Update user info
  Future<void> updateBio(String bio) => _db.updateUserBioDB(bio);
  Future<void> updateUsername(String username) => _db.updateUserUsernameDB(username);
  Future<void> updateProfileImage(String profileImageUrl) => _db.updateUserProfileImageDB(profileImageUrl);


  // Posting a post
  Future<void> createPost(
      String gridCode, String contentText, String contentImageUrl) async {
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

  // Fetch best posts
  Future<void> loadBestPosts(String gridCode) async {
    // TODO: Implement fetching best posts
    final bestPosts = await _db.getBestPostsDB();
    _bestPosts = bestPosts;

    // Update UI
    notifyListeners();
  }
}
