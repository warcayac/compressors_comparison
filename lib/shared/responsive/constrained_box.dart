import 'package:flutter/material.dart';

import '../constants.dart';


class WConstrainedBox extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final AlignmentGeometry alignment;
  /* ---------------------------------------------------------------------------- */
  const WConstrainedBox({Key? key, required this.child, this.maxWidth = kMaxWidth, this.alignment = Alignment.topCenter}) : super(key: key);
  /* ---------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}