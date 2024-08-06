class User {
  final String username;
  final String profileImgUrl;

  User({
    required this.username,
    required this.profileImgUrl,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      username: data['username'],
      profileImgUrl: data['profileImgUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'profileImgUrl': profileImgUrl,
    };
  }
}
