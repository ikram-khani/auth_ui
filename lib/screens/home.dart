import 'package:auth_ui/screens/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firebase = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              firebase.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const AuthScreen(),
              ));
            },
            icon: const Icon(Icons.logout),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Hello ${firebase.currentUser!.displayName} \n Welcome Here',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
