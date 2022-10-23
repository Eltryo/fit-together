class UserPreferences {
  String username;
  String email;
  String? imagePath;
  String? about;
  bool? isDarkMode;

  UserPreferences(
      this.username, this.email, this.imagePath, this.about, this.isDarkMode);
}
