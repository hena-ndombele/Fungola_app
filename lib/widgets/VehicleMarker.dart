import 'package:flutter/material.dart';

class VehicleMarker extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Dessine le corps du véhicule
    final bodyPaint = Paint()..color = Colors.blue;
    canvas.drawRect(Rect.fromLTWH(-20, -30, 40, 60), bodyPaint);

    // Dessine les roues du véhicule
    final wheelPaint = Paint()..color = Colors.black;
    canvas.drawCircle(Offset(-15, 15), 10, wheelPaint);
    canvas.drawCircle(Offset(15, 15), 10, wheelPaint);

    // Dessine les fenêtres du véhicule
    final windowPaint = Paint()..color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(-15, -20, 30, 20), windowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}