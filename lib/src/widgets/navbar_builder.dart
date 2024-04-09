import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:soundsense/src/constants/colors.dart';

import '../screens/chat_page.dart';
import '../screens/home_page.dart';
import '../screens/musig_page.dart';
import '../screens/notifications_page.dart';

class MyNavBar extends StatefulWidget {
  const MyNavBar({super.key});

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  int currentIndex = 0;

  final screens = [
    const HomePage(),
    const ChatPage(),
    const MusicPage(),
    const NotificationsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        color: navbar,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.018,
            vertical: height * 0.008,
          ),
          child: GNav(
            selectedIndex: currentIndex,
            backgroundColor: navbar,
            color: grayFont,
            activeColor: theme,
            tabBackgroundColor: Colors.grey.shade200,
            gap: width * 0.02,
            padding: const EdgeInsets.all(18),
            onTabChange: (index) => setState(() => currentIndex = index),
            tabs: const [
              GButton(
                icon: CupertinoIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: CupertinoIcons.double_music_note,
                text: 'Chat',
              ),
              GButton(
                icon: CupertinoIcons.chat_bubble,
                text: 'Music',
              ),
              GButton(
                icon: CupertinoIcons.person_alt_circle_fill,
                text: 'Notifications',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
