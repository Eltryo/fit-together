import 'package:flutter/material.dart';

import 'colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
              Center(),
              Center(),
              Center(),
              Center(),
            ])));
  }
}
