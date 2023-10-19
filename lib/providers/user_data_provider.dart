import 'package:auth_ui/models/user_data_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class UserDataProvider with ChangeNotifier {
  final UserData _userData = UserData();

  UserData get userData => _userData;

  void saveBasicDetails(
      String name, DateTime dob, String address, String phoneNumber) {
    _userData.name = name;
    _userData.dob = dob;
    _userData.address = address;
    _userData.phoneNumber = phoneNumber;
    notifyListeners();
  }

  void saveEmail(String email) {
    _userData.email = email;
    notifyListeners();
  }

  void savePassword(String password) {
    _userData.password = password;
    notifyListeners();
  }

  //used return type bool to make sure if it succeed return in try block return true, else in catch block return false
  Future<bool> createUserInFirebase(BuildContext context) async {
    try {
      final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: _userData.email!, password: _userData.password!);

      FirebaseFirestore.instance
          .collection('users')
          .doc(userCredentials.user!.uid)
          .set(
        {
          'name': _userData.name,
          'email': _userData.email,
          'dob': _userData.dob,
          'address': _userData.address,
          'phone_number': _userData.phoneNumber,
        },
      );
      return true;
    } on FirebaseAuthException catch (error) {
      // if (error.code == 'email-already-in-use') {
      // }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed.'),
        ),
      );
      return false;
    }
  }
}
