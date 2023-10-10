import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _obscureText = true; //initialy the password text is obscure
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      'Hi! Welcome',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 30,
                ),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Email Address",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter Your Email',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
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
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      const Text(
                        "Password",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Your Password',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                        obscureText: _obscureText,
                        validator: (value) {
                          if (value == null || value.trim().length < 6) {
                            return 'Password must be atleast 6 character long.';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(65, 196, 133, 1),
                    ),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Log In'),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
