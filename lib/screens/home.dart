import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sports_app/screens/profile_page.dart';
import 'package:sports_app/screens/subscription_content_page.dart';

import 'premium_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod("TextInput.hide");
    return DefaultTabController(
        length: 5,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                tabs: <Tab>[
                  Tab(icon: Image.asset('assets/icons/home.png', height: 20)),
                  Tab(icon: Image.asset('assets/icons/crown.png', height: 20)),
                  Tab(
                      icon:
                          Image.asset('assets/icons/running.png', height: 20)),
                  Tab(icon: Image.asset('assets/icons/clock.png', height: 20)),
                  Tab(icon: Image.asset('assets/icons/user.png', height: 20)),
                ],
              ),
              title: const Center(
                  child: Text(
                "FitTogether",
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
            ),
            body: const TabBarView(children: [
              SubscriptionContentPage(),
              PremiumPage(),
              Center(),
              Center(),
              ProfilePage(),
            ])));
  }
}
