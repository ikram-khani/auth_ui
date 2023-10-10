import 'package:flutter/material.dart';

class SignInWithSocial extends StatelessWidget {
  const SignInWithSocial({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 30),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Image.asset(
            'assets/icons/microsoft.png',
            height: 30,
            width: 30,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 30),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Image.asset(
            'assets/icons/google.png',
            height: 30,
            width: 30,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Image.asset(
            'assets/icons/facebook.png',
            height: 30,
            width: 30,
          ),
        ),
      ],
    );
  }
}
