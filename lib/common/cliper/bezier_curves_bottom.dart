import 'package:flutter/cupertino.dart';

class BezierCurvesBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double w = size.width;
    double h = size.height;

    final path = Path();

    path.lineTo(0, h);
    path.lineTo(w * 0.35, h);
    path.quadraticBezierTo(w * 0.5, h - 100, w * 0.65, h);

    path.lineTo(w, h);
    path.lineTo(w, 0); //! End bottom bezier clipper

    path.lineTo(0, 0);
    path.lineTo(w, h);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
