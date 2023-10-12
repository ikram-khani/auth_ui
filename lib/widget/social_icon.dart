import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  const SocialIcon({required this.iconPath, super.key});
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double imageSize = screenSize.width * 0.08;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Image.asset(
        iconPath,
        height: imageSize,
        width: imageSize,
      ),
    );
  }
}
