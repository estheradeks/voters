import 'package:flutter/material.dart' hide OutlinedButton;
import 'package:flutter/services.dart';
import 'package:voters/ui/auth/sign_in_screen.dart';
import 'package:voters/ui/auth/sign_up_screen.dart';
import 'package:voters/ui/widgets/buttons.dart';
import 'package:voters/utils/theme.dart';

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                color: primaryColor,
                child: Center(
                  child: Hero(
                    tag: 'voters-logo',
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 5,
                          color: whiteColor,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Voters',
                            style: TextStyle(
                              fontSize: 30,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = whiteColor
                                ..strokeCap = StrokeCap.round,
                            ),
                          ),
                          Icon(
                            Icons.how_to_vote_rounded,
                            color: whiteColor,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: whiteColor,
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    VotersFilledButton(
                      text: 'Create a voter account',
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SignUpScreen(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Divider(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    VotersOutlinedButton(
                      text: 'Log In as Admin',
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SignInScreen(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
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
