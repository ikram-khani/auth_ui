import 'dart:async';

import 'package:auth_ui/widget/steps_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  var firebaseAuth = FirebaseAuth.instance;
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) => checkEmailVerified(),
    );
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email verified successfully \n Thank you!'),
        ),
      );
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

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
            isEmailVerified
                ? const Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.done_outline_rounded,
                            size: 54,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Verified successfully',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                      top: 25,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Verify Email",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          ' Please Check Your Email',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            "We have sent a verification link to you on \n ${firebaseAuth.currentUser!.email}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Center(child: CircularProgressIndicator()),
                        const SizedBox(
                          height: 8,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Center(
                            child: Text(
                              'Verifying email....',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
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
                            onPressed: () {
                              if (isEmailVerified) {
                                return;
                              }
                              try {
                                FirebaseAuth.instance.currentUser
                                    ?.sendEmailVerification();
                              } catch (e) {
                                debugPrint('$e');
                              }
                            },
                            child: isEmailVerified
                                ? const Text('Go to home screen')
                                : const Text('Resend'),
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
