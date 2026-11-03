import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The only source of text styling in the app. Was style/style.dart.
abstract class AppTextStyles {
  static TextStyle get title => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        fontStyle: FontStyle.italic,
      );

  static TextStyle get description => GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get descriptionAppBar => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get favoriteAppBar => GoogleFonts.poppins(
        fontSize: 23,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      );

  static TextStyle get favoriteEmptyBody => GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.italic,
      );

  static TextStyle get searchAppBar => GoogleFonts.poppins(
        fontSize: 23,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      );

  static TextStyle get profileTitle => GoogleFonts.poppins(
        fontSize: 23,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      );

  static TextStyle get error => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get login => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get welcome => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      );
}
