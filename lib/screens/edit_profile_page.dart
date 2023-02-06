import 'package:fit_together/providers.dart';
import 'package:fit_together/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final authService = ref.read(authServiceProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          //TODO: implement features
          children: [
            RoundedButton(
              color: Theme.of(context).primaryColor,
              text: "Log out",
              onPressed: () {
                authService.signOut();
                if (mounted) {
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
