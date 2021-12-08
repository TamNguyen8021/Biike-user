import 'package:bikes_user/app/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class TooltipPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Path();
    p.moveTo(size.width / 2 - 8, size.height - 20);
    p.lineTo(size.width / 2, size.height - 20 + 17);
    p.lineTo(size.width / 2 + 8, size.height - 20);
    p.close();

    canvas.drawPath(p, Paint()..color = CustomColors.kLightGray);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
