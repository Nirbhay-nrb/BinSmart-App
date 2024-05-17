import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleToDisplay extends StatelessWidget {
  const TitleToDisplay({
    required this.displayText,
    required this.size,
    super.key,
  });
  final String displayText;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      displayText,
      textAlign: TextAlign.center,
      style: GoogleFonts.anton(
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: size.toDouble(),
        ),
      ),
    );
  }
}
