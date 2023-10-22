import 'package:auth_ui/screens/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final firebase = FirebaseAuth.instance;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 10,
        titleSpacing: -5,
        leading: const Icon(
          Icons.home,
          color: Colors.green,
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          const Text(
            'Log out',
            style:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.blueGrey),
          ),
          IconButton(
            onPressed: () {
              firebase.signOut();
              //also sign out the user if he is sign in with google
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const AuthScreen(),
              ));
            },
            icon: const Icon(Icons.logout),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.5,
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: firebase.currentUser == null
              ? const Text(
                  'Hello \n Welcome Here!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      wordSpacing: 3),
                )
              : Text(
                  'Hello ${firebase.currentUser!.displayName} \n Welcome Here!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      wordSpacing: 3),
                ),
        ),
      ),
    );
  }
}
