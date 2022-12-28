import 'package:flutter/material.dart';
import 'package:sports_app/services/auth.dart';
import 'package:sports_app/services/firestore.dart';

import '../models/app_user.dart';
import '../widget/numbers_widget.dart';
import '../widget/profile_image_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();
  String _username = "";
  String _email = "";
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    fetchAppUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          ProfileImageWidget(
            imagePath: _checkImagePath(_imageUrl),
            onClicked: () async {},
          ),
          const SizedBox(height: 10),
          Text(
            _username,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            _email,
            style: const TextStyle(
                fontStyle: FontStyle.italic, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          const NumbersWidget(),
        ],
      ),
    );
  }

  String _checkImagePath(String? imagePath) {
    if (imagePath == null) {
      return "assets/images/default_user_image.png";
    }
    return imagePath;
  }

  void fetchAppUser() async {
    String? currentUID = await _authService.getCurrentUID();
    if (currentUID == null) throw Exception(); //TODO: throw custom exception
    AppUser appUser = await _firestoreService.getUserByUID(currentUID);
    setState(() {
      _username = appUser.username;
      _email = appUser.email;
      _imageUrl = appUser.imageUrl;
    });
  }
}
