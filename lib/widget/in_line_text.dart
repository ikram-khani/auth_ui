import 'package:flutter/material.dart';

class InLineText extends StatelessWidget {
  const InLineText({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            height: 1,
            color: Colors.black,
          ),
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.grey),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 8),
            height: 1,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
