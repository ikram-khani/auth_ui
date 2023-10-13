import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final DateFormat formatter = DateFormat.yMd();
  final TextEditingController _dateController = TextEditingController();
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2007),
      firstDate: DateTime(1913),
      lastDate: DateTime(2008),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = formatter.format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 60,
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 22,
                  ),
                ),
                const Center(
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 50,
                  ),
                  child: Text(
                    'Fill your information below or register with your social account',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                label: const Text('Name'),
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                                hintText: 'Your Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              autocorrect: true,
                              keyboardType: TextInputType.name,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _dateController,
                              onTap: _selectDate,
                              decoration: InputDecoration(
                                suffixIcon: const Padding(
                                  padding: EdgeInsets.only(right: 30.0),
                                  child: Icon(Icons.date_range_outlined),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                label: const Text('Birthday'),
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                                hintText: 'Please select your birthday',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                label: const Text('Address'),
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                                hintText: 'Enter your location',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              autocorrect: true,
                              keyboardType: TextInputType.streetAddress,
                            ),
                            const SizedBox(height: 20),
                            IntlPhoneField(
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                label: const Text('Phone no'),
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              initialCountryCode: 'PK',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
