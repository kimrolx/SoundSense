import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ivoryWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back),
          iconSize: width * 0.065,
          color: black,
        ),
        title: Row(
          children: [
            Container(
              width: width * 0.115,
              height: height * 0.05,
              decoration: BoxDecoration(
                color: black,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            Gap(width * 0.03),
            Text(
              'Full Name',
              style: GoogleFonts.inter(
                fontSize: width * 0.0425,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            myChats('Navi', 'Good Morning!', false, width, height),
            myChats('Angel', 'yesss', true, width, height),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Aa',
                  hintStyle: GoogleFonts.inter(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(20),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.arrow_up_circle_fill),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget myChats(
    String name, String message, bool alignRight, double width, double height) {
  return SizedBox(
    height: height * 0.125,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            alignRight ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!alignRight) ...[
            Container(
              width: width * 0.115,
              height: height * 0.05,
              decoration: BoxDecoration(
                color: black,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            Gap(width * 0.02),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.inter(
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: navbar,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      message,
                      style: GoogleFonts.inter(
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // If alignRight is true, add a spacer before the text to push it to the end
          if (alignRight) ...[
            Gap(width * 0.02),
            Container(
              width: width * 0.115,
              height: height * 0.05,
              decoration: BoxDecoration(
                color: black,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ],
        ],
      ),
    ),
  );
}
