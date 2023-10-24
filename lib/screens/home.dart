import 'package:auth_ui/screens/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _firebase = FirebaseAuth.instance;
  var _isSgignoutLoading = false;

  String? _displayNameGoogle = '';

  Future<void> _signOut() async {
    try {
      setState(() {
        _isSgignoutLoading = true;
      });

      await _firebase.signOut();

      //also sign out the user if is sign in with google

      if (_firebase.currentUser == null) {
        await _googleSignIn.signOut();
      }
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        ),
      );
    } catch (error) {
      setState(() {
        _isSgignoutLoading = false;
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    //for setting the display name of google if the firebase auth user is null
    if (_firebase.currentUser == null) {
      getGoogleUserInfo();
    }
  }

  Future<void> getGoogleUserInfo() async {
    //.silently() will signIn the previously authenticated google user without the user interaction
    await _googleSignIn.signInSilently();
    setState(() {
      _displayNameGoogle = _googleSignIn.currentUser!.displayName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: _signOut,
            icon: const Icon(Icons.logout),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
      body: _isSgignoutLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  opacity: 0.5,
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: _firebase.currentUser == null
                    ? Text(
                        'Hello $_displayNameGoogle \n Welcome Here!',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            wordSpacing: 3),
                      )
                    : Text(
                        'Hello ${_firebase.currentUser!.displayName} \n Welcome Here!',
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
