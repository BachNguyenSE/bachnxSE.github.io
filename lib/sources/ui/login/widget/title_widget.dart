import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleWidget extends StatelessWidget {
  final IconData? icon;
  final String? text;

  const TitleWidget({
    Key? key,
    @required this.icon,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Icon(icon, size: 100),
          const SizedBox(height: 16),
          Text(
            text!,
            style: GoogleFonts.monoton(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 50.0,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
}
