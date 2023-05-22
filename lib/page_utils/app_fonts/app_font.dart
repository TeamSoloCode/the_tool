library app_font;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' deferred as gg_fonts;
import 'package:the_tool/page_utils/app_fonts/dynamic_font.dart'
    deferred as dynamic_fonts;

class AppFont {
  Future<TextStyle> getFont(String fontFamily) async {
    await gg_fonts.loadLibrary();
    switch (fontFamily) {
      case "Acme":
        return gg_fonts.GoogleFonts.acme();
      case "Roboto":
        return gg_fonts.GoogleFonts.roboto();
      case "":
        return gg_fonts.GoogleFonts.lato();
      default:
        await dynamic_fonts.loadLibrary();
        return dynamic_fonts.DynamicFonts().getFont(fontFamily);
    }
  }
}
