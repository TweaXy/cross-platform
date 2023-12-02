import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHeadText extends StatelessWidget {
  CustomHeadText(
      {super.key, required this.textValue, required this.textAlign, this.size});
  final String textValue;
  final TextAlign textAlign;
  double? size;
  @override
  Widget build(BuildContext context) {
    return Text(
      textValue,
      textAlign: textAlign,
      overflow: TextOverflow.clip,
      style:
          GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: size ?? 30,color: Colors.black),
    );
  }
}
