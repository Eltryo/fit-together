import 'package:sports_app/utils/user_numbers.dart';
import 'package:sports_app/utils/user_preferences.dart';

class User {
  String username = "Prison_Mike";
  String email = "prison.mike@gmail.com";
  String? imagePath;
  String? about;
  bool? isDarkMode;
  int? pictureCount;
  int? followingCount;
  int? followerCount;


  User(this.username, this.email, this.imagePath, this.about, this.isDarkMode,
      this.pictureCount, this.followingCount, this.followerCount);

  User.empty(){
    imagePath = "lib/images/prison_mike.jpg";
    about = "I stole and I robbed and I kidnapped the president's son an held him for ransom";
    isDarkMode = false;
    pictureCount = 0;
    followingCount = 0;
    followerCount = 0;
  }

  UserPreferences getPreferences(){
    return UserPreferences(
      username,
      email,
      imagePath,
      about,
      isDarkMode
    );
  }

  UserNumbers getUserNumbers() {
    return UserNumbers(pictureCount, followingCount, followerCount);
  }
}