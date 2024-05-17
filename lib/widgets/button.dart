import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

class Button extends StatelessWidget {
  const Button({
    required this.displayText,
    required this.onTap,
    required this.clr,
    super.key,
  });
  final String displayText;
  final Function onTap;
  final Color clr;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onTap();
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: clr,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              displayText,
              style: GoogleFonts.roboto(
                fontSize: 25,
                color: kDarkGray,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
