import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String username;
  final String email;
  final String bio;
  final String profileImgUrl;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.bio,
    required this.profileImgUrl,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      uid: doc['uid'],
      username: doc['username'],
      email: doc['email'],
      bio: doc['bio'],
      profileImgUrl: doc['profileImgUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'bio': bio,
      'profileImgUrl': profileImgUrl,
    };
  }
}
