import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Survey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Color(0xFFE4E4E3),
          iconTheme: Get.theme.iconTheme.copyWith(color: Colors.black),
          elevation: 0,
          title: SizedBox(
            height: 56,
            child: Image.asset(
              'assets/images/PRAPARE-Logo-no-tagline.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          titleSpacing: 0,
          // remove this line to include back navigation button
          // automaticallyImplyLeading: false,
          bottom: TabBar(
            labelColor: Colors.black,
            tabs: [
              Tab(
                icon: Image.asset(
                  'assets/icons/personal_characteristics.png',
                  height: 48,
                ),
              ),
              Tab(
                icon: Image.asset(
                  'assets/icons/family_and_home.png',
                  height: 48,
                ),
              ),
              Tab(
                icon: Image.asset(
                  'assets/icons/money_and_resources.png',
                  height: 48,
                ),
              ),
              Tab(
                icon: Image.asset(
                  'assets/icons/social_and_emotional_health.png',
                  height: 48,
                ),
              ),
              Tab(
                icon: Image.asset(
                  'assets/icons/other_measures.png',
                  height: 48,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xFFDAE7DB),
        body: TabBarView(children: [
          Center(
              child: Text(
            'Personal',
            style: TextStyle(fontSize: 32),
          )),
          Center(
              child: Text(
            'Home',
            style: TextStyle(fontSize: 32),
          )),
          Center(
              child: Text(
            'Money',
            style: TextStyle(fontSize: 32),
          )),
          Center(
              child: Text(
            'Social',
            style: TextStyle(fontSize: 32),
          )),
          Center(
              child: Text(
            'Optional',
            style: TextStyle(fontSize: 32),
          )),
        ]),
      ),
    );
  }
}