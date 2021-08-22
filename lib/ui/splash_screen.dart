import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voters/ui/auth/get_started_screen.dart';
import 'package:voters/ui/auth/sign_up_screen.dart';
import 'package:voters/utils/theme.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadSplash();
  }

  void _loadSplash() {
    final duration = Duration(seconds: 2);

    Timer(
      duration,
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => GetStartedScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
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
            ],
          ),
        ),
      ),
    );
  }
}
