import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  const SocialIcon({required this.iconPath, super.key});
  final String iconPath;

  @override
  Widget build(BuildContext context) {
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
        height: 30,
        width: 30,
      ),
    );
  }
}
