import 'package:flutter/material.dart';

import '../../application/authentication.dart';
import '../../service_locator.dart';

class SubscriptionContentPage extends StatelessWidget {
  const SubscriptionContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = locator<AuthenticationService>();

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                authService.signOut();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
              child: const Text(
                "Log out",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        // Text(
        //   "Subscription Content",
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     fontSize: 18,
        //     color: Colors.grey,
        //     fontStyle: FontStyle.italic,
        //   ),
        // ),
      ),
    );
  }
}
