import 'package:flutter/material.dart';

class StepsLine extends StatelessWidget {
  const StepsLine({required this.step, required this.totalSteps, super.key});

  final int step;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
      child: SizedBox(
        width: double.infinity,
        height: 30,
        child: Column(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '$step of $totalSteps',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            CustomPaint(
              painter: StepsLinePainter(step: step, totalSteps: totalSteps),
              child: const SizedBox(
                height: 8,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StepsLinePainter extends CustomPainter {
  const StepsLinePainter({required this.step, required this.totalSteps});
  final int step;
  final int totalSteps;
  @override
  void paint(Canvas canvas, Size size) {
    final rectPaint = Paint()
      ..color = const Color.fromARGB(255, 215, 215, 215)
      ..style = PaintingStyle.fill;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rRect = RRect.fromRectAndRadius(rect, const Radius.circular(30));
    canvas.drawRRect(rRect, rectPaint);

    //draw the step rectangle
    final fillrectPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final fillrect =
        Rect.fromLTWH(0, 0, size.width / totalSteps * step, size.height);
    final fillrRect =
        RRect.fromRectAndRadius(fillrect, const Radius.circular(30));
    canvas.drawRRect(fillrRect, fillrectPaint);
  }

  @override
  bool shouldRepaint(StepsLinePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(StepsLinePainter oldDelegate) => false;
}
