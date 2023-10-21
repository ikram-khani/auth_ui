import 'package:auth_ui/providers/user_data_provider.dart';
import 'package:auth_ui/screens/sign_up_3.dart';
import 'package:auth_ui/widget/steps_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen2 extends StatefulWidget {
  const SignUpScreen2({super.key});

  @override
  State<SignUpScreen2> createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  final _fieldKey = GlobalKey<FormFieldState>();

  var _enteredEmail = '';

  void _submit() {
    final userData = Provider.of<UserDataProvider>(context, listen: false);
    final isValid = _fieldKey.currentState!.validate();

    if (!isValid) {
      //error
      return;
    }
    _fieldKey.currentState!.save();

    userData.saveEmail(_enteredEmail);
    //going to the next scren
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignUpScreen3(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  child: Center(
                    child: Text(
                      'Sign up',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                      const Text(
                        "What's your email?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      TextFormField(
                        key: _fieldKey,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Email Address',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
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
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Center(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const StepsLine(
                          totalSteps: 3,
                          step: 1,
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
                            onPressed: _submit,
                            child: const Text('Next'),
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
