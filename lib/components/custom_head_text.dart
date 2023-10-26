import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHeadText extends StatelessWidget {
  const CustomHeadText(
      {super.key, required this.textValue, required this.textAlign});
  final String textValue;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      textAlign: textAlign,
      overflow: TextOverflow.clip,
      style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 30),
    );
  }
}
