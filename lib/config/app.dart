import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class WApp {
  static final material = _WMaterial._();
}

/* ============================================================================================= */

class _WMaterial {
  /* ---------------------------------------------------------------------------- */
  _WMaterial._();
  /* ---------------------------------------------------------------------------- */
  TextTheme googleTextTheme(BuildContext context, {int index = 0}) {
    final _textTheme = Theme.of(context).textTheme;
    final _themes = [   // more fonts: https://fonts.google.com
    GoogleFonts.interTextTheme, // default
    GoogleFonts.titilliumWebTextTheme,
    GoogleFonts.notoSansTextTheme,
    GoogleFonts.ptSansNarrowTextTheme,
    GoogleFonts.specialEliteTextTheme,  // tipo máquina de escribir
    ];
    return _themes[index](_textTheme);
  }
}
