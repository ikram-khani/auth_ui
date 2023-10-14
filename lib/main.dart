import 'package:auth_ui/screens/auth.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 165, 102)),
        primaryColor: const Color.fromRGBO(65, 196, 133, 1),
        useMaterial3: true,
      ),
      home: const AuthScreen(),
    );
  }
}
