import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voters/core/constants.dart';
import 'package:voters/core/services/election_service.dart';
import 'package:voters/core/services/face_reg_service.dart';
import 'package:voters/core/services/storage_service.dart';
import 'package:voters/ui/auth/sign_in_screen.dart';
import 'package:voters/ui/auth/take_picture_screen.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/voters/face_reg_screen.dart';
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
  final ImagePicker _picker = ImagePicker();
  File _image;

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
              // their image here
              InkWell(
                onTap: () async {
                  var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TakePictureScreen(),
                    ),
                  );

                  if (res != null) {
                    setState(() {
                      _image = res;
                    });
                  }
                  // final XFile photo =
                  //     await _picker.pickImage(source: ImageSource.camera);

                  // if (photo != null) {
                  //   _image = File(photo.path);
                  // }
                  // setState(() {});
                },
                child: Align(
                  child: Stack(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor.withOpacity(.5),
                        ),
                        child: _image != null
                            ? ClipOval(
                                child: Image.file(
                                  _image,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : SizedBox.shrink(),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 5,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: whiteColor,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.camera_rounded,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                  if (_image != null) {
                    showLoadingDialog(context);

                    // check if the private key matches any from the database
                    FirebaseFirestore ff = FirebaseFirestore.instance;

                    DocumentSnapshot documentSnapshot = await ff
                        .collection('addresses')
                        .doc(_ethPrivateKey)
                        .get();

                    if (documentSnapshot.exists) {
                      // upload image
                      bool result = await FaceRegService.registerFace(
                          _image, _ethPrivateKey);
                      log('upload image result is $result');

                      if (result) {
                        if (!documentSnapshot.data()['has_registered']) {
                          ff.collection('addresses').doc(_ethPrivateKey).update(
                            {
                              'has_registered': true,
                            },
                          );
                          // get the eth_address from firebase
                          Map data = documentSnapshot.data();
                          _ethAddress = data['eth_address'];

                          log('eth address is $_ethAddress');
                          // save to local storage
                          StorageService storageService = StorageService();

                          storageService.saveAddress(_ethAddress.toLowerCase());
                          storageService
                              .savePrivateKey(_ethPrivateKey.toLowerCase());
                          storageService.saveRole('voter');
                          storageService.saveVoteStatus(false);
                          

                          ElectionService electionService = ElectionService(_ethPrivateKey);
                          await electionService.initialSetup();

                          // await Future.delayed(Duration(seconds: 6));

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

                          ff
                              .collection('voters_addresses')
                              .doc('addresses')
                              .update(
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
                                builder: (_) => VotersFaceRegScreen(),
                              ),
                            );
                          }
                        } else {
                          Navigator.pop(context);
                          showErrorDialog(
                            context,
                            'User has already registered using this ETH Private Key',
                          );
                        }
                      } else {
                        Navigator.pop(context);
                        showErrorDialog(
                          context,
                          'Error while uploading image, try again.',
                        );
                      }
                    } else {
                      Navigator.pop(context);
                      showErrorDialog(
                        context,
                        'Incorrect ETH Priate Key',
                      );
                    }
                  } else {
                    showErrorDialog(
                      context,
                      'Please upload your picture before proceeding.',
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
