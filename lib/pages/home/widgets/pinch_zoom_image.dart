import 'package:flutter/material.dart';


class WPinchZoomImage extends StatefulWidget {
  final Image child;
  /* ---------------------------------------------------------------------------- */
  const WPinchZoomImage({Key? key, required this.child}) : super(key: key);
  /* ---------------------------------------------------------------------------- */
  @override
  State<WPinchZoomImage> createState() => _WPinchZoomImageState();
}

/* ============================================================================================= */

class _WPinchZoomImageState extends State<WPinchZoomImage> with SingleTickerProviderStateMixin {
  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  OverlayEntry? entry;
  final minScale = 1.0;
  final maxScale = 4.0;
  var scale = 1.0;
  /* ---------------------------------------------------------------------------- */
  @override
  void initState() {
    super.initState();
    controller = TransformationController();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200))
      ..addListener(() => controller.value = animation!.value)
      // ..addStatusListener((status) {
      //   if (status == AnimationStatus.completed) removeOverlay();
      // })
      ;
  }
  /* ---------------------------------------------------------------------------- */
  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }
  /* ---------------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    return buildImage();
  }
  /* ---------------------------------------------------------------------------- */
  Widget buildImage() {
    return Builder(
      builder: (context) {
        return InteractiveViewer(
          transformationController: controller,
          clipBehavior: Clip.none,
          panEnabled: false,
          minScale: minScale,
          maxScale: maxScale,
          onInteractionStart: (details) {
            if (details.pointerCount < 2) return;
            showOverlay(context);
          },
          onInteractionUpdate: (details) {
            if (entry == null) return;

            scale = details.scale;
            entry!.markNeedsBuild();
          },
          onInteractionEnd: (details) {
            resetAnimation();
            removeOverlay();
          },
          child: widget.child,
        );
      }
    );
  }
  /* ---------------------------------------------------------------------------- */
  void resetAnimation() {
    animation = Matrix4Tween(begin: controller.value, end: Matrix4.identity())
      .animate(CurvedAnimation(
        parent: animationController, 
        curve: Curves.elasticInOut,
      ));
    animationController.forward(from: 0);
  }
  /* ---------------------------------------------------------------------------- */
  void showOverlay(BuildContext context) {
    final renderBox = context.findRenderObject()! as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = MediaQuery.of(context).size;
    
    entry = OverlayEntry(
      builder: (context) {
        final opacity = ((scale - 1) / (maxScale - 1)).clamp(0, 1) + 0.0;
        return Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: opacity,
                child: Container(color: Colors.black),
              ),
            ),
            Positioned(
              left: offset.dx,
              top: offset.dy,
              width: size.width,
              child: buildImage(),
            ),
          ],
        );
      },
    );

    Overlay.of(context)!.insert(entry!);
  }
  /* ---------------------------------------------------------------------------- */
  void removeOverlay() {
    entry?.remove();
    entry = null;
  }
}
