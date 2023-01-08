import 'package:flutter/material.dart';
import 'package:fit_together/widgets/rounded_button_widget.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Text(
            "Upgrade to PRO version of FitTogether to view and share premium content",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
          ),
        ),
        RoundedButton(
          text: "Upgrade to PRO",
          onPressed: () {}, //TODO: Add upgrade function
        ),
      ],
    );
  }
}
