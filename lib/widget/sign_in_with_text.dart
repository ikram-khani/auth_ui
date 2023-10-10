import 'package:flutter/material.dart';

class SignInWithText extends StatelessWidget {
  const SignInWithText({super.key});

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
        const Text('Or sign in with'),
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
