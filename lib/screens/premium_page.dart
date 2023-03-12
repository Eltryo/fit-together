import 'package:fit_together/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Text(
              "Upgrade to FitTogetherPro to view and share premium content",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
            ),
          ),
          RoundedButton(
            text: "Upgrade",
            onPressed: () {}, //TODO: Add upgrade function
          ),
        ],
      ),
    );
  }
}
