import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    void chat() {
      Navigator.pushNamed(context, '/conversation');
    }

    return Scaffold(
      backgroundColor: ivoryWhite,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Chats',
          style: GoogleFonts.poppins(
            fontSize: width * 0.08,
            fontWeight: FontWeight.w600,
            color: black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.035,
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: GoogleFonts.inter(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
              ),
              Gap(height * 0.02),
              myContainer('NHL Community', 'How are you?', '7:16 am', chat,
                  width, height),
              Gap(height * 0.02),
              myContainer('Angel Nina', 'How are you?', '12:30 pm', chat, width,
                  height),
              Gap(height * 0.02),
              myContainer(
                  'Navi Leiru', 'How are you?', '4:12 pm', chat, width, height),
            ],
          ),
        ),
      ),
    );
  }
}

Widget myContainer(String username, String message, String time,
    void Function()? ontap, double width, double height) {
  return InkWell(
    borderRadius: BorderRadius.circular(20),
    onTap: ontap,
    child: Ink(
      width: width,
      height: height * 0.12,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.01,
        ),
        child: Row(
          children: [
            Container(
              width: width * 0.17,
              height: height * 0.075,
              decoration: BoxDecoration(
                color: black,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            Gap(width * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  username,
                  style: GoogleFonts.inter(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  message,
                  style: GoogleFonts.inter(
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              time,
              style: GoogleFonts.inter(
                fontSize: width * 0.035,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
