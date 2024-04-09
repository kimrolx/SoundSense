import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void register() async {
    Navigator.pushNamed(context, '/register');
  }

  void login() async {
    Navigator.pushReplacementNamed(context, '/nav');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
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
                    Color.fromRGBO(232, 188, 185, 1.0),
                    Color.fromRGBO(243, 159, 90, 1.0),
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.03,
                    ),
                    child: Text(
                      'Log in',
                      style: GoogleFonts.poppins(
                        fontSize: width * 0.1,
                        fontWeight: FontWeight.w700,
                        color: white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: Image.asset(
                      'assets/images/login_image.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.04,
                    ),
                    child: Column(
                      children: [
                        myTextField('Username', width, height),
                        Gap(height * 0.02),
                        myTextField('Password', width, height),
                        Gap(height * 0.025),
                        myButton('Login', width, height, login),
                        Gap(height * 0.1),
                        Column(
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: GoogleFonts.inter(
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.w400,
                                color: white,
                              ),
                            ),
                            myButton('Create Account', width, height, register),
                          ],
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
