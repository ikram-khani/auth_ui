import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/home.dart';

class SignInWithGoogleButton extends StatefulWidget {
  const SignInWithGoogleButton({super.key});

  @override
  State<SignInWithGoogleButton> createState() => _SignInWithGoogleButtonState();
}

class _SignInWithGoogleButtonState extends State<SignInWithGoogleButton> {
  Future<void> _signInWithGoogle() async {
    final List<String> scopes = <String>[
      'email',
      'profile',
    ];

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: scopes,
      );
      //trying to sign in with google
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      //if sign in success then show home screen and show success message
      if (googleSignInAccount != null) {
        //for saving the user email address and name to the database for getting in future

        // Check if a document with the same ID already exists
        final userDoc = await FirebaseFirestore.instance
            .collection('GoogleUsers')
            .doc(googleSignInAccount.id)
            .get();

        if (!userDoc.exists) {
          await FirebaseFirestore.instance
              .collection('GoogleUsers')
              .doc(googleSignInAccount.id)
              .set(
            {
              'name': googleSignInAccount.displayName,
              'email': googleSignInAccount.email,
            },
          );
        }

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign in successfully'),
          ),
        );
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return InkWell(
        onTap: _signInWithGoogle,
        child: Container(
          height: screenSize.height / 18,
          width: screenSize.width / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).primaryColor,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icons/google.png'),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                const Text(
                  'Sign in with google',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
