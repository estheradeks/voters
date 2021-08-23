import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voters/core/constants.dart';
import 'package:voters/core/services/election_service.dart';
import 'package:voters/core/services/storage_service.dart';
import 'package:voters/ui/auth/sign_in_screen.dart';
import 'package:voters/ui/modules/voter/voter_bottom_nav/voter_bottom_nav.dart';
import 'package:voters/ui/widgets/buttons.dart';
import 'package:voters/ui/widgets/dialogs.dart';
import 'package:voters/ui/widgets/text_fields.dart';
import 'package:voters/utils/theme.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _ethAddress = '';
  String _ethPrivateKey = '';
  String firstName = '';
  String lastName = '';
  String _email = '';
  String _phoneNumber = '';
  String gender = '';
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15.0).add(
            EdgeInsets.only(
              bottom: 30.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create a voter account!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // VotersTextField(
              //   labelText: 'ETH Address',
              //   hintText: 'ETH Adress',
              //   onChanged: (val) {
              //     setState(() {
              //       _ethAddress = val;
              //     });
              //   },
              // ),
              SizedBox(
                height: 20,
              ),
              VotersTextField(
                labelText: 'ETH Private Key',
                hintText: 'ETH Private Key',
                onChanged: (val) {
                  setState(() {
                    _ethPrivateKey = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              VotersTextField(
                labelText: 'First Name',
                hintText: 'John',
                onChanged: (val) {
                  setState(() {
                    firstName = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              VotersTextField(
                labelText: 'Last Name',
                hintText: 'Doe',
                onChanged: (val) {
                  setState(() {
                    lastName = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              VotersTextField(
                labelText: 'Email',
                hintText: 'email@email.com',
                onChanged: (val) {
                  setState(() {
                    _email = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              VotersTextField(
                labelText: 'Phone Number',
                hintText: '0123456789',
                onChanged: (val) {
                  setState(() {
                    _phoneNumber = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              VotersTextField(
                labelText: 'Gender',
                hintText: 'Male',
                onChanged: (val) {
                  setState(() {
                    gender = val;
                  });
                },
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // VotersTextField(
              //   labelText: 'Date of Birth',
              //   hintText: '00/00/0000',
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // VotersTextField(
              //   labelText: 'State',
              //   hintText: 'State',
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // VotersTextField(
              //   labelText: 'LGA',
              //   hintText: 'LGA',
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // VotersTextField(
              //   labelText: 'Password',
              //   hintText: 'password',
              // ),
              SizedBox(
                height: 50,
              ),
              VotersFilledButton(
                text: 'Create a Voter Account',
                onPressed: () async {
                  showLoadingDialog(context);

                  // check if the private key matches any from the database
                  FirebaseFirestore ff = FirebaseFirestore.instance;

                  DocumentSnapshot documentSnapshot = await ff
                      .collection('addresses')
                      .doc(_ethPrivateKey)
                      .get();

                  if (documentSnapshot.exists) {
                    // get the eth_address from firebase
                    Map data = documentSnapshot.data();
                    _ethAddress = data['eth_address'];

                    log('eth address is $_ethAddress');
                    // save to local storage
                    StorageService storageService = StorageService();

                    storageService.saveAddress(_ethAddress);
                    storageService.savePrivateKey(_ethPrivateKey);
                    storageService.saveRole('voter');
                    storageService.saveVoteStatus(false);

                    electionService = ElectionService(_ethPrivateKey);

                    await Future.delayed(Duration(seconds: 6));

                    var result = await electionService.writeContract(
                      electionService.registerAsVoter,
                      [
                        firstName + ' ' + lastName,
                        _phoneNumber,
                      ],
                    );

                    DocumentSnapshot ds = await ff
                        .collection('voters_addresses')
                        .doc('addresses')
                        .get();

                    List dataArray = ds.data()['data'];
                    dataArray = dataArray..add(_ethAddress);

                    ff.collection('voters_addresses').doc('addresses').update(
                      {
                        'data': [
                          ...dataArray,
                        ],
                      },
                    );

                    if (result != null) {
                      // push to new screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VoterBottomNav(),
                        ),
                      );
                    }
                  } else {
                    Navigator.pop(context);
                    showErrorDialog(
                      context,
                      'Incorrect ETH Priate Key',
                    );
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                child: Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                      fontSize: 12,
                      color: blackColor,
                    ),
                    children: [
                      TextSpan(
                        text: 'Log In',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SignInScreen(),
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
      ),
    );
  }
}
