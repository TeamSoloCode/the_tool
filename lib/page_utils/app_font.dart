library app_font;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFont {
  TextStyle getFont(String fontFamily) {
    return GoogleFonts.getFont(fontFamily);
  }
}
