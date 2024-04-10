import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Relaxing Music',
          style: GoogleFonts.poppins(
            fontSize: width * 0.05,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            myContainer('assets/images/soothing_music_1.jpg',
                'Soothing Music 1', width, height),
            myContainer('assets/images/soothing_music_2.jpg',
                'Soothing Music 2', width, height),
            myContainer('assets/images/soothing_music_3.jpg',
                'Soothing Music 3', width, height),
            myContainer('assets/images/soothing_music_4.jpg',
                'Soothing Music 4', width, height),
          ],
        ),
      ),
    );
  }
}

Widget myContainer(String image, String text, double width, double height) {
  return Column(
    children: [
      Stack(
        children: [
          Container(
            width: width,
            height: height * 0.2,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.play,
                  size: width * 0.1,
                  color: white,
                ),
              ),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: width,
          height: height * 0.05,
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: width * 0.04,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      )
    ],
  );
}
