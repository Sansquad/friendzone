import 'package:flutter/material.dart';
import 'package:friendzone/models/user.dart';
import 'package:friendzone/services/auth/firebase_auth_services.dart';
import 'package:friendzone/services/database/database_service.dart';

class DatabaseProvider extends ChangeNotifier {

  final _auth = FirebaseAuthService();
  final _db = DatabaseService();

  // Get userModel given uid
  Future<UserModel?> userModel(String uid) => _db.getUserFirebase(uid);

}
