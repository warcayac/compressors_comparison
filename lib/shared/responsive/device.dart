import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


// Referencias de dimensiones de dispositivos:
// https://mediag.com/blog/popular-screen-resolutions-designing-for-all/
const _breakpoints = <double>[
  300,    // watch / ipod : width <= 300 , portrait
  500,    // smartphone : 300 < width <= 500, portrait
  1280,   // tablet : 480 < width <= 1280, portrait
];        // desktop : 1280 < width, no interesa orientación

class WDevice {
  final BuildContext context;
  /* ---------------------------------------------------------------------------- */
  const WDevice(this.context);
  /* ---------------------------------------------------------------------------- */
  Size get size => MediaQuery.of(context).size;
  double get referentialWidth => inPortrait ? size.width : size.height;
  // El modo de orientación en que se encuentra el dispositivo. Portrait: width/height <= 1
  bool get inPortrait => MediaQuery.of(context).orientation == Orientation.portrait;
  bool get inLandscape => MediaQuery.of(context).orientation == Orientation.landscape;
  // ¿La applicación fue compilada para ejecutarse como Web?
  bool get isWeb => kIsWeb;
  // Si no fue compilado para Web, intenta discernir en qué SO se ejecutando la app
  bool? get isAndroid => isWeb ? null : Platform.isAndroid;
  bool? get isIOS => isWeb ? null : Platform.isIOS;
  bool? get isFuchsia => isWeb ? null : Platform.isFuchsia;
  bool? get isLinux => isWeb ? null : Platform.isLinux;
  bool? get isMacOS => isWeb ? null : Platform.isMacOS;
  bool? get isWindows => isWeb ? null : Platform.isWindows;
  // Si el dispositivo real es un smartphone
  bool get isMobile => (isAndroid != null && isAndroid!) || (isIOS != null && isIOS!);
  // ws = WorkSpace. Aŕea de trabajo de referencia para el contenido adaptable
  bool get wsIsWatch => size.width <= _breakpoints[0];
  bool get wsIsPhone => _breakpoints[0] < size.width && size.width <= _breakpoints[1];
  bool get wsIsTablet => _breakpoints[1] < size.width && size.width <= _breakpoints[2];
  bool get wsIsDesktop => _breakpoints[2] < size.width;
  // Referencias para intuir dispositivos reales
  bool get _isWatch => referentialWidth <= _breakpoints[0];
  bool get _isPhone => _breakpoints[0] < referentialWidth && referentialWidth <= _breakpoints[1];
  bool get _isTablet => _breakpoints[1] < referentialWidth && referentialWidth <= _breakpoints[2];
  bool get _isDesktop => _breakpoints[2] < referentialWidth;
  // Si no fue compilado para Web, intenta discernir qué tipo de dispositivo REAL es.
  bool? get isWatch => isWeb ? null : _isWatch;
  bool? get isPhone => isWeb ? null : _isPhone;
  bool? get isTablet => isWeb ? null : _isTablet;
  bool? get isDesktop => isWeb ? null : _isDesktop;
  /* ---------------------------------------------------------------------------- */
  /* ---------------------------------------------------------------------------- */
  /* ---------------------------------------------------------------------------- */
  /* ---------------------------------------------------------------------------- */
  /* ---------------------------------------------------------------------------- */
  /* ---------------------------------------------------------------------------- */
  /* ---------------------------------------------------------------------------- */
}