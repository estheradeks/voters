import 'package:flutter/material.dart';
import 'package:voters/ui/splash_screen.dart';
import 'package:voters/utils/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: votersTheme(context),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
