import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundsense/src/models/onboarding_model.dart';

import '../constants/colors.dart';

Widget buildOnboardingPage(OnboardingModel page, double width, double height) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: height * 0.01,
      horizontal: width * 0.05,
    ),
    child: Column(
      children: [
        Text(
          page.title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: width * 0.08,
            fontWeight: FontWeight.w700,
            color: theme,
          ),
        ),
        Gap(height * 0.01),
        Text(
          page.description,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: width * 0.043,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}
