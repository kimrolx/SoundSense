import 'package:flutter/material.dart';
import 'src/screens/chat_page.dart';
import 'src/screens/home_page.dart';
import 'src/screens/musig_page.dart';
import 'src/screens/onboarding_page.dart';
import 'src/widgets/navbar_builder.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OnboardingPage(),
      routes: {
        '/navbar': (context) => const MyNavBar(),
        '/homepage': (context) => const HomePage(),
        '/chatpage': (context) => const ChatPage(),
        '/musicpage': (context) => const MusicPage(),
      },
    );
  }
}
