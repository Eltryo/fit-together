import 'package:flutter/material.dart';
import 'package:sports_app/widget/rounded_button_widget.dart';

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
        RoundedButtonWidget(
            color: Theme.of(context).primaryColor, text: "Upgrade to PRO"),
      ],
    );
  }
}
