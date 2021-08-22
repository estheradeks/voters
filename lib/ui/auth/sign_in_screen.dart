import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:voters/core/services/helpers.dart';
import 'package:voters/core/services/storage_service.dart';
import 'package:voters/ui/auth/sign_up_screen.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/admin_bottom_nav.dart';
import 'package:voters/ui/modules/voter/voter_bottom_nav/voter_bottom_nav.dart';
import 'package:voters/ui/widgets/buttons.dart';
import 'package:voters/ui/widgets/dialogs.dart';
import 'package:voters/ui/widgets/text_fields.dart';
import 'package:voters/utils/theme.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isVoter = false;

  String _email = '';
  String _password = '';

  void _adminLogin() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    showLoadingDialog(context);

    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      // get data from firebase
      FirebaseFirestore ff = FirebaseFirestore.instance;
      DocumentSnapshot document = await ff
          .collection('admin')
          .doc('8BvyYNbx2AVxfZZXwA9JlB4jOLr1')
          .get();
      String address = document.data()['address'];
      String privateKey = document.data()['private_key'];

      // save to storage
      StorageService storageService = StorageService();
      storageService.saveAddress(address);
      storageService.savePrivateKey(privateKey);
      storageService.saveRole('admin');
      
      Navigator.pop(context);

      Widget _screenToGo;
      if (_isVoter) {
        // navigate to voter module
        _screenToGo = VoterBottomNav();
      } else {
        // navigate to admin module
        _screenToGo = AdminBottomNav();
      }
      // pop the get started screen
      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => _screenToGo,
        ),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      String errorMessage = catchFirebaseException(e);
      log('error message is ${e.code}');
      showErrorDialog(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: primaryColor,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Log In to your account!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            VotersTextField(
              labelText: 'Email',
              hintText: 'email@email.com',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: validateEmail,
              onChanged: (val) {
                setState(() {
                  _email = val.trim();
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            VotersTextField(
              labelText: 'Password',
              hintText: 'password',
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              validator: (val) =>
                  validateRequiredFields(val.trim(), 'Password'),
              onChanged: (val) {
                setState(() {
                  _password = val.trim();
                });
              },
            ),
            // SizedBox(
            //   height: 15,
            // ),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: InkWell(
            //     onTap: _changeRole,
            //     customBorder: StadiumBorder(),
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //       child: Text(
            //         'Switch to ${_isVoter ? 'Admin' : 'Voter'} Log In',
            //         style: TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w700,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 35,
            ),
            VotersFilledButton(
              text: 'Log In as ${_isVoter ? 'a Voter' : 'an Admin'}',
              onPressed:
                  validateEmail(_email.trim()) != null && _password.length > 3
                      ? null
                      : () {
                          _adminLogin();
                        },
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              child: Text.rich(
                TextSpan(
                  text: 'Don\'t have an account? ',
                  style: TextStyle(
                    fontSize: 12,
                    color: blackColor,
                  ),
                  children: [
                    TextSpan(
                      text: 'Create a Voter Account',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SignUpScreen(),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String validateEmail(String email) {
  String source =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(source);
  if (email.trim().isEmpty) {
    return 'Email is required';
  } else if (!regExp.hasMatch(email)) {
    return 'Enter a valid email address';
  } else {
    return null;
  }
}

String validateRequiredFields(String input, String fieldName) {
  if (input.trim().isEmpty) {
    return 'Invalid $fieldName';
  } else {
    return null;
  }
}
