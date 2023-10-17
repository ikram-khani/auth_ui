import 'package:auth_ui/providers/user_data_provider.dart';
import 'package:auth_ui/screens/sign_up_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:provider/provider.dart';

import '../widget/in_line_text.dart';
import '../widget/social_icon.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final DateFormat formatter = DateFormat.yMd();

  final TextEditingController _dateController = TextEditingController();

  dynamic _emptyPhoneFieldError;

  final _formKey = GlobalKey<FormState>();

  var _enteredName = '';
  DateTime _enteredDob = DateTime(0);
  var _enteredAddress = '';
  var _enteredPhone = '';
  var _number = '';

  void _submit() {
    final isFormValid = _formKey.currentState!.validate();
    if (!isFormValid) {
      //error message shown on widget
      return;
    }

    //for checking here if there is empty number(number is just number without the country code)
    //using the validation here because the validator in the int phone field is not working here with the form it's automatic validation on uerInteraction
    _formKey.currentState!.save();
    if (_number.isEmpty) {
      setState(() {
        _emptyPhoneFieldError = 'Please enter your phone number';
      });
      return;
    }

    var userData = Provider.of<UserDataProvider>(context, listen: false);
//saving basic details in the provider
    userData.saveBasicDetails(
      _enteredName,
      _enteredDob,
      _enteredAddress,
      _enteredPhone,
    );

    //going to the next scren
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen2(),
      ),
    );
  }

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
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
                    Icons.arrow_back,
                    size: 25,
                  ),
                ),
                const Center(
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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
            child: Container(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                bottom: 30,
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: TextFormField(
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
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                autocorrect: true,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  if (value.contains(
                                      RegExp('[0-9!@#\$\'%^&*(),.?":{}|<>]'))) {
                                    return 'Enter a valid name with characters only';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) => _enteredName = newValue!,
                              ),
                            ),
                            const SizedBox(height: 25),
                            TextFormField(
                              readOnly: true,
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
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Select your date of birth';
                                }
                                return null;
                              },
                              onSaved: (newValue) =>
                                  _enteredDob = formatter.parse(newValue!),
                            ),
                            const SizedBox(height: 25),
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
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              autocorrect: true,
                              keyboardType: TextInputType.streetAddress,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your address';
                                }
                                return null;
                              },
                              onSaved: (newValue) =>
                                  _enteredAddress = newValue!,
                            ),
                            const SizedBox(height: 25),
                            IntlPhoneField(
                              decoration: InputDecoration(
                                counterStyle: const TextStyle(
                                    fontSize: 13, color: Colors.grey),
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
                                errorText: _emptyPhoneFieldError,
                              ),
                              keyboardType: TextInputType.phone,
                              initialCountryCode: 'PK',
                              onSaved: (newValue) {
                                _enteredPhone =
                                    newValue!.completeNumber.toString();
                                _number = newValue.number.toString();
                              },
                              onChanged: (value) {
                                //on entering number there should be no empty text error
                                setState(() {
                                  _emptyPhoneFieldError = null;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor,
                            ),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            textStyle: MaterialStateProperty.all(
                              const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          onPressed: _submit,
                          child: const Text('Next'),
                        ),
                      ),
                      const SizedBox(height: 25),
                      const InLineText(
                        text: 'Or sign in with',
                      ),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const SocialIcon(
                                  iconPath: 'assets/icons/microsoft.png'),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () {},
                              icon: const SocialIcon(
                                  iconPath: 'assets/icons/google.png'),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () {},
                              icon: const SocialIcon(
                                  iconPath: 'assets/icons/facebook.png'),
                            ),
                          ]),
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
