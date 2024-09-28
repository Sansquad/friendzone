import 'package:flutter/material.dart';
import 'package:friendzone/models/user.dart';
import 'package:friendzone/services/auth/firebase_auth_services.dart';
import 'package:friendzone/services/database/database_service.dart';

import '../models/post.dart';

class DatabaseProvider extends ChangeNotifier {
  final _db = DatabaseService();
  final _auth = FirebaseAuthService();

  UserModel? _currentUser;
  List<Post> _localPosts = [];
  List<Post> _bestPosts = [];
  String _currentZone = "";

  List<Post> get localPosts => _localPosts;
  List<Post> get bestPosts => _bestPosts;
  UserModel? get currentUser => _currentUser;
  String get currentZone => _currentZone;

  Future<String> calibrateZone() async {
    _currentZone = "C - 137";
    return currentZone;
  }

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
  Future<void> updateUsername(String username) =>
      _db.updateUserUsernameDB(username);
  Future<void> updateProfileImage(String profileImageUrl) =>
      _db.updateUserProfileImageDB(profileImageUrl);

  // Posting a post
  Future<void> createPost(
      String gridCode, String contentText, String contentImageUrl) async {
    await _db.createPostDB(gridCode, contentText, contentImageUrl);
    await loadLocalPosts(gridCode);
  }

  // Deleting a post
  Future<void> deletePost(String gridCode, String postId) async {
    await _db.deletePostDB(gridCode, postId);
    // TODO potential problem: current zone might be different from delted post grid
    await loadLocalPosts(gridCode);
  }

  // Fetch local posts
  Future<void> loadLocalPosts(String gridCode) async {
    final localPosts = await _db.getLocalPostsDB(gridCode);
    _localPosts = localPosts;

    initializeLocalLikeMap();

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

  // Local map to track like counts for each post in the local posts page
  Map<String, int> _localLikeCounts = {};

  // Local map to track like counts for each post in the best posts page
  Map<String, int> _bestLikeCounts = {};

  // Local list to track posts liked by current user
  List<String> _userLikedPosts = [];

  // return whether user likes a post
  bool isLikedByUser(String postId) => _userLikedPosts.contains(postId);

  // get like count of local post
  int getLocalLikeCount(String postId) => _localLikeCounts[postId]!;

  //initialize like map locally
  void initializeLocalLikeMap() {
    // get current uid
    final currentUserID = _auth.getCurrentUid();

    // for each post get like data
    for (var post in _localPosts) {
      //update like count map
      _localLikeCounts[post.id] == post.likeCount;

      if (post.likedBy.contains(currentUserID)) {
        _userLikedPosts.add(post.id);
      }
    }
  }

  // initialize like map locally
  void initializeBestLikeMap() {
    // get current uid
    final currentUserID = _auth.getCurrentUid();

    // for each post get like data
    for (var post in _bestPosts) {
      //update like count map
      _bestLikeCounts[post.id] == post.likeCount;

      // TODO: potential problem: bestPost's likedBy list can potentially be massive, so might be inefficient.
      // why are we initializing this here in the first place? shouldn't it already exist when user is created,
      // and posts add as they like them?
      if (post.likedBy.contains(currentUserID)) {
        _userLikedPosts.add(post.id);
      }
    }
  }

  // Toggle like
  Future<void> toggleLike(String postId) async {
    // store original values in case database write fails
    final likedPostsOriginal = _userLikedPosts;
    final localLikedCountsOriginal = _localLikeCounts;

    if (_userLikedPosts.contains(postId)) {
      _userLikedPosts.remove(postId);
      _localLikeCounts[postId] = (_localLikeCounts[postId] ?? 0) - 1;
    } else {
      _userLikedPosts.add(postId);
      _localLikeCounts[postId] = (_localLikeCounts[postId] ?? 0) + 1;
    }

    // update UI optimistically
    notifyListeners();

    // perform database update
  }
}
