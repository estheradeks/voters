import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voters/ui/auth/sign_in_screen.dart';
import 'package:voters/ui/modules/voter/voter_bottom_nav/voter_bottom_nav.dart';
import 'package:voters/ui/widgets/buttons.dart';
import 'package:voters/ui/widgets/text_fields.dart';
import 'package:voters/utils/theme.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
              VotersTextField(
                labelText: 'First Name',
                hintText: 'John',
              ),
              SizedBox(
                height: 20,
              ),
              VotersTextField(
                labelText: 'Last Name',
                hintText: 'Doe',
              ),
              SizedBox(
                height: 20,
              ),
              VotersTextField(
                labelText: 'Email',
                hintText: 'email@email.com',
              ),
              SizedBox(
                height: 20,
              ),
              VotersTextField(
                labelText: 'Phone Number',
                hintText: '0123456789',
              ),
              SizedBox(
                height: 20,
              ),
              VotersTextField(
                labelText: 'Gender',
                hintText: 'Male',
              ),
              SizedBox(
                height: 20,
              ),
              VotersTextField(
                labelText: 'Date of Birth',
                hintText: '00/00/0000',
              ),
              SizedBox(
                height: 20,
              ),
              VotersTextField(
                labelText: 'State',
                hintText: 'State',
              ),
              SizedBox(
                height: 20,
              ),
              VotersTextField(
                labelText: 'LGA',
                hintText: 'LGA',
              ),
              SizedBox(
                height: 20,
              ),
              VotersTextField(
                labelText: 'Password',
                hintText: 'password',
              ),
              SizedBox(
                height: 50,
              ),
              VotersFilledButton(
                text: 'Create a Voter Account',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VoterBottomNav(),
                    ),
                  );
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
