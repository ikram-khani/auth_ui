import 'package:auth_ui/screens/email_verification.dart';
import 'package:auth_ui/widget/steps_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_data_provider.dart';

class SignUpScreen3 extends StatefulWidget {
  const SignUpScreen3({super.key});

  @override
  State<SignUpScreen3> createState() => _SignUpScreen3State();
}

class _SignUpScreen3State extends State<SignUpScreen3> {
  var _isUserCreating = false;
  final _fieldKey = GlobalKey<FormFieldState>();

  var _enteredPassword = '';

  void _submit() async {
    final userData = Provider.of<UserDataProvider>(context, listen: false);

    final isValid = _fieldKey.currentState!.validate();

    if (!isValid) {
      //error message
      return;
    }
    _fieldKey.currentState!.save();
    userData.savePassword(_enteredPassword);

    //if the createUserInFirebase provider return the success value true then move to the verification screen else not move and show error message
    userData.createUserInFirebase(context).then(
      (map) async {
        if (map['success'] == true) {
          setState(() {
            _isUserCreating = true;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account created Successfully'),
            ),
          );
          await Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const EmailVerificationScreen(),
            ),
            (Route route) => false,
          );
          return;
        }
        setState(() {
          _isUserCreating = false;
        });
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(map['error'].message ?? 'Authentication failed.'),
          ),
        );
      },
    );
  }

  bool _showPassword = false;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 26,
                    right: 50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.arrow_back),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Sign up',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
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
                          "Create a Password",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: TextFormField(
                          key: _fieldKey,
                          autofocus: true,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !_showPassword ? true : false,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'Password must be atleast 6 character long.';
                            }
                            return null;
                          },
                          onSaved: (newValue) => _enteredPassword = newValue!,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            value: _showPassword,
                            onChanged: (context) => setState(() {
                              _showPassword = !_showPassword;
                            }),
                          ),
                          const Expanded(
                            child: Text(
                              'Show Password',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                child: Center(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const StepsLine(
                          totalSteps: 3,
                          step: 2,
                        ),
                        _isUserCreating
                            ? const Center(child: CircularProgressIndicator())
                            : SizedBox(
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
                                      const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  onPressed: _submit,
                                  child: const Text('Sign Up'),
                                ),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                    text: 'By signing up, you agree to our '),
                                TextSpan(
                                  text: 'Terms of services',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
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
