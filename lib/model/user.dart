class User{
  final String username;
  final String email;
  String? imagePath;
  String? about;
  bool? isDarkMode = false;
  int pictureCount = 0;
  int followingCount = 0;
  int followerCount = 0;

  User({
    required this.username,
    required this.email,
    this.imagePath,
    this.about,
    this.isDarkMode
});
}