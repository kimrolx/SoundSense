import 'package:flutter/material.dart';
import 'package:soundsense/src/screens/login_page.dart';
import 'package:soundsense/src/screens/register_page.dart';

import 'src/screens/chat_page.dart';
import 'src/screens/conversation_page.dart';
import 'src/screens/home_page.dart';
import 'src/screens/music_page.dart';
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
      home: const LoginPage(),
      routes: {
        '/nav': (context) => const MyNavBar(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/chat': (context) => const ChatPage(),
        '/conversation': (context) => const ConversationPage(),
        '/music': (context) => const MusicPage(),
      },
    );
  }
}
