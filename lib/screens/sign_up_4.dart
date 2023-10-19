import 'package:auth_ui/widget/steps_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen4 extends StatelessWidget {
  const SignUpScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 26,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        const Text(
                          'Log out',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: GestureDetector(
                              onTap: () => FirebaseAuth.instance.signOut(),
                              child: const Icon(Icons.logout_rounded),
                            ))
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 25,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Verify Email",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Please verify your email',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          "We have sent a verification link to your email address",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 30,
                  right: 30,
                ),
                child: Center(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const StepsLine(
                          totalSteps: 3,
                          step: 3,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColor,
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text('Verify'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
