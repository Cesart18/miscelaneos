


  import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

    ThemeData getTheme() => ThemeData(
      colorSchemeSeed: Colors.blue,

      // Text Theme
      textTheme: TextTheme(
        titleLarge: GoogleFonts.montserratAlternates(),
        titleMedium: GoogleFonts.montserratAlternates(),

      )

    );

  }