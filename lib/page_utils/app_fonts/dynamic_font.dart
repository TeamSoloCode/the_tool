library app_font;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' deferred as gg_fonts;

class DynamicFonts {
  Future<TextStyle> getFont(String fontFamily) async {
    await gg_fonts.loadLibrary();
    return gg_fonts.GoogleFonts.getFont(fontFamily);
  }
}
