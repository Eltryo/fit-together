import 'package:flutter/material.dart';
import 'package:sports_app/home_page.dart';

import 'colors.dart';

class AppTabController extends StatefulWidget {
  const AppTabController({Key? key}) : super(key: key);

  @override
  State<AppTabController> createState() => AppTabControllerState();
}

class AppTabControllerState extends State<AppTabController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppTheme.appBackgroundColor,
              titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: AppTheme.appTextColor),
              bottom: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: <Tab>[
                  Tab(icon: Image.asset('lib/icons/home.png', height: 17)),
                  Tab(icon: Image.asset('lib/icons/crown.png', height: 20)),
                  Tab(icon: Image.asset('lib/icons/running.png', height: 20)),
                  Tab(icon: Image.asset('lib/icons/clock.png', height: 20)),
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
              Center(),
              Center(),
              Center(),
            ])));
  }
}
