import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundsense/src/constants/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ivoryWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            fontSize: width * 0.06,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width,
              height: height * 0.25,
              child: Icon(
                CupertinoIcons.person_circle,
                size: width * 0.4,
                color: black,
              ),
            ),
            Text(
              'Account Settings',
              style: GoogleFonts.inter(
                  fontSize: width * 0.04, fontWeight: FontWeight.w400),
            ),
            myContainer('Personal Information', width, height),
            Gap(height * 0.035),
            Text(
              'Help & Support',
              style: GoogleFonts.inter(
                  fontSize: width * 0.04, fontWeight: FontWeight.w400),
            ),
            myContainer('Privacy Policy', width, height),
            myContainer('FAQ & Help', width, height),
            Gap(height * 0.1),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text(
                  'Logout',
                  style: GoogleFonts.inter(
                    fontSize: width * 0.05,
                    color: Colors.red,
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

Widget myContainer(String text, double width, double height) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: height * 0.01),
    child: InkWell(
      onTap: () {},
      child: Ink(
        width: width,
        child: Row(
          children: [
            Text(
              text,
              style: GoogleFonts.inter(
                  fontSize: width * 0.05, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            const Icon(
              CupertinoIcons.right_chevron,
            ),
          ],
        ),
      ),
    ),
  );
}
