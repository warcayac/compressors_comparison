import 'package:flutter/material.dart';

import 'device.dart';


class WResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? watch, tablet, desktop;
  final Widget? byDefault;
  /* ---------------------------------------------------------------------------- */
  const WResponsiveLayout({Key? key, required this.mobile, this.watch, this.tablet, this.desktop, this.byDefault}) : super(key: key);
  /* ---------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    var device = WDevice(context);
    var _byDefault = byDefault ?? mobile;

    // print('width: ${device.size.width}');

    return LayoutBuilder(
      builder: (context, constraints) {
        return device.wsIsPhone
          ? mobile
          : device.wsIsWatch
            ? watch ?? _byDefault
            : device.wsIsTablet
              ? tablet ?? _byDefault
              : device.wsIsDesktop
                ? desktop ?? _byDefault
                : _byDefault;
      },
    );
  }
}