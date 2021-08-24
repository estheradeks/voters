import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voters/core/constants.dart';
import 'package:voters/core/services/election_service.dart';
import 'package:voters/core/services/storage_service.dart';
import 'package:voters/ui/auth/get_started_screen.dart';
import 'package:voters/ui/auth/sign_up_screen.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/admin_bottom_nav.dart';
import 'package:voters/ui/modules/admin/admin_bottom_nav/voters/face_reg_screen.dart';
import 'package:voters/ui/modules/voter/voter_bottom_nav/voter_bottom_nav.dart';
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

  void _loadSplash() async {
    final duration = Duration(seconds: 2);

    Timer(
      duration,
      () async {
        StorageService storageService = StorageService();
        String address = await storageService.getAddress();
        String privateKey = await storageService.getPrivateKey();
        bool isLoggedIn = address != null && privateKey != null;
        String role = await storageService.getRole();
        bool isAdmin = role == 'admin';

        log('splash screen private key is $privateKey');
        if (isLoggedIn) {
          electionService = ElectionService(privateKey);

          await Future.delayed(Duration(seconds: 3));
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => isLoggedIn
                ? isAdmin
                    ? AdminBottomNav()
                    : VotersFaceRegScreen()
                : GetStartedScreen(),
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
