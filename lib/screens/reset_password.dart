import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _fieldKey = GlobalKey<FormFieldState>();

  var _enteredEmail = '';
  var _sendEmail = false;

  void _submit() async {
    bool isValid = _fieldKey.currentState!.validate();
    bool isEmailRegistered = false;

    if (isValid) {
      _fieldKey.currentState!.save();

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      CollectionReference userCollection =
          firebaseFirestore.collection('users');

      QuerySnapshot querySnapshot =
          await userCollection.where('email', isEqualTo: _enteredEmail).get();

      if (querySnapshot.size > 0) {
        setState(() {
          isEmailRegistered = true;
        });
      } else {
        setState(() {
          isEmailRegistered = false;
        });
      }

      if (!isEmailRegistered) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account not found on the entered email'),
          ),
        );
        return;
      }

      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _enteredEmail);
        setState(() {
          _sendEmail = true;
        });
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.message.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _sendEmail
          ? const Center(
              child: Text(
                'We have sent a "reset password link" to your email address',
                textAlign: TextAlign.center,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 30,
                    ),
                    child: Center(
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Enter your account email",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: TextFormField(
                            key: _fieldKey,
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: 'Email Address',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                            onSaved: (newValue) => _enteredEmail = newValue!,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 30, right: 30),
                      child: Center(
                        child: SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                textStyle: MaterialStateProperty.all(
                                  const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              onPressed: _submit,
                              child: const Text('Reset Password'),
                            ),
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
