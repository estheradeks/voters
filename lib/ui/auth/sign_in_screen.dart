import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:voters/ui/auth/sign_up_screen.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/admin_bottom_nav.dart';
import 'package:voters/ui/modules/voter/voter_bottom_nav/voter_bottom_nav.dart';
import 'package:voters/ui/widgets/buttons.dart';
import 'package:voters/ui/widgets/text_fields.dart';
import 'package:voters/utils/theme.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isVoter = true;

  void _changeRole() {
    setState(() {
      _isVoter = !_isVoter;
    });
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
            ),
            SizedBox(
              height: 20,
            ),
            VotersTextField(
              labelText: 'Password',
              hintText: 'password',
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: _changeRole,
                customBorder: StadiumBorder(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Switch to ${_isVoter ? 'Admin' : 'Voter'} Log In',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            VotersFilledButton(
              text: 'Log In as ${_isVoter ? 'a Voter' : 'an Admin'}',
              onPressed: () {
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
