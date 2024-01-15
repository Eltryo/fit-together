import 'package:fit_together/presentation/home/achievements.dart';
import 'package:fit_together/presentation/home/profile/profile_page.dart';
import 'package:fit_together/presentation/home/subscription_content_page.dart';
import 'package:fit_together/presentation/home/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'premium_page.dart';

class AppTabController extends StatelessWidget {
  const AppTabController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod("TextInput.hide");
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
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
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SubscriptionContentPage(),
            PremiumPage(),
            Achievements(),
            Timer(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
