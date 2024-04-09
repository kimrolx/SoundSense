import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    void signup() {
      Navigator.pushReplacementNamed(context, '/nav');
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              //* Gradient Background Color.
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(243, 159, 90, 1.0),
                    Color.fromRGBO(174, 68, 90, 1.0),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: 0.5,
              child: SizedBox(
                width: width,
                height: height,
                child: Image.asset(
                  'assets/images/login_image.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.075,
                vertical: height * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(CupertinoIcons.back),
                    iconSize: width * 0.08,
                    color: white,
                  ),
                  Center(
                    child: Text(
                      'Log in',
                      style: GoogleFonts.poppins(
                        fontSize: width * 0.1,
                        fontWeight: FontWeight.w700,
                        color: white,
                      ),
                    ),
                  ),
                  Gap(height * 0.04),
                  myTextField('First Name', width, height),
                  Gap(height * 0.03),
                  myTextField('Last Name', width, height),
                  Gap(height * 0.03),
                  myTextField('Email', width, height),
                  Gap(height * 0.03),
                  myTextField('Username', width, height),
                  Gap(height * 0.03),
                  myTextField('Password', width, height),
                  Gap(height * 0.04),
                  Center(
                    child: myButton('Sign Up', width, height, signup),
                  ),
                  Gap(height * 0.08),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'By Signing Up, you agree to our',
                          style: GoogleFonts.inter(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w500,
                            color: white,
                          ),
                        ),
                        Text(
                          'Terms of Use and Policy',
                          style: GoogleFonts.inter(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: white,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget myTextField(String labelText, double width, double height) {
  return Form(
    child: TextFormField(
      decoration: InputDecoration(
          isDense: false,
          labelText: labelText,
          labelStyle: GoogleFonts.inter(
            fontSize: width * 0.04,
            fontWeight: FontWeight.w500,
            color: white,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                const BorderSide(color: Color.fromRGBO(174, 68, 90, 1.0)),
          )),
    ),
  );
}

Widget myButton(
    String text, double width, double height, void Function()? onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(232, 188, 185, 1.0),
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.1,
          vertical: height * 0.025,
        )),
    child: Text(
      text,
      style: GoogleFonts.inter(
        fontSize: width * 0.04,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
