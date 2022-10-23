import 'package:flutter/material.dart';
import 'package:sports_app/page/home_page.dart';
import 'package:sports_app/page/profile_page.dart';

import '../page/premium_page.dart';
import '../utils/colors.dart';

class AppTabController extends StatefulWidget {
  const AppTabController({Key? key}) : super(key: key);

  @override
  State<AppTabController> createState() => AppTabControllerState();
}

class AppTabControllerState extends State<AppTabController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: AppColors.appTextColor),
              bottom: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                tabs: <Tab>[
                  Tab(icon: Image.asset('lib/icons/home.png', height: 17)),
                  Tab(icon: Image.asset('lib/icons/crown.png', height: 20)),
                  Tab(icon: Image.asset('lib/icons/running.png', height: 20)),
                  Tab(icon: Image.asset('lib/icons/clock.png', height: 20)),
                  Tab(icon: Image.asset('lib/icons/user.png', height: 20)),
                ],
              ),
              title: const Center(
                  child: Text(
                "FitTogether",
                style: TextStyle(fontStyle: FontStyle.italic),
              )),
              elevation: 0,
            ),
            body: const TabBarView(children: [
              HomePage(),
              PremiumPage(),
              Center(),
              Center(),
              ProfilePage(),
            ])));
  }
}
